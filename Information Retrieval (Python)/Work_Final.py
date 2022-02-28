import spacy
from rank_bm25 import BM25Okapi
from tqdm import tqdm
import time
import fileinput
import pandas as pd
import numpy as np
from gensim.models.fasttext import FastText
from pathlib import Path
import pickle
import nmslib

pd.set_option("display.max_colwidth", -1)

#https://drive.google.com/file/d/13LLeNj9Fajk0PBd7U5kXEhsEpSRMWwbJ/view?usp=sharing
df = pd.read_csv("export.csv")

df['text'] = df['tendertitle'] + ' ' + df['tenderdescription']+ ' ' + df['locality']+ ' ' + df['postalCode']
df.shape
df.head(1)

nlp = spacy.load("en_core_web_sm")

text = df.text.str.lower().values 
text = [str(i) for i in text]
print("CORPUS READ")
if Path("cache/corpus.data").is_file():
    with open("cache/corpus.data", "rb") as file:
        corpus = pickle.load(file)
else:
    corpus = []
    for doc in tqdm(nlp.pipe(text, disable=["tagger", "parser","ner"])):

       tok = [t.text for t in doc if (t.is_ascii and not t.is_punct and not t.is_space)]
       corpus.append(tok)
    with open("cache/corpus.data", "wb") as file:
        pickle.dump(corpus, file)

print("FAST TEXT")
if Path("cache/_fasttext.model").is_file():
    ft_model = FastText.load("cache/_fasttext.model")
else:
    ft_model = FastText(
        vector_size=100, # embedding dimension (default)
        window=10, # window size: 10 tokens before and 10 tokens after to get wider context
        min_count=5, # only consider tokens with at least n occurrences in the corpus
        negative=15, # negative subsampling: bigger than default to sample negative examples more
        min_n=2, # min character n-gram
        max_n=5 # max character n-gram
    )

    ft_model.build_vocab(corpus)

    print("TRAIN")

    ft_model.train(
        corpus,
        epochs=10,
        total_examples=ft_model.corpus_count,
        total_words=ft_model.corpus_total_words)

    ft_model.save("cache/_fasttext.model")

print("BM25")
bm25 = BM25Okapi(corpus)

print("WEIGHTED DOC")
weighted_doc_vects = []
if Path("cache/weighted_doc_vects.data").is_file():
    with open("cache/weighted_doc_vects.data", "rb") as file:
        weighted_doc_vects = pickle.load(file)
else:
    for i,doc in tqdm(enumerate(corpus)):
        doc_vector = []
        for word in doc:
            vector = ft_model.wv[word]
            weight = (bm25.idf[word] * ((bm25.k1 + 1.0)*bm25.doc_freqs[i][word])) \
            / \
            (bm25.k1 * (1.0 - bm25.b + bm25.b *(bm25.doc_len[i]/bm25.avgdl))+bm25.doc_freqs[i][word])
            weighted_vector = vector * weight
            doc_vector.append(weighted_vector)
        if len(doc_vector) != 0:
            doc_vector_mean = np.mean(doc_vector,axis=0)
            weighted_doc_vects.append(doc_vector_mean)
    with open("cache/weighted_doc_vects.data", "wb") as file:
        pickle.dump(weighted_doc_vects, file)

data = np.vstack(weighted_doc_vects)

index = nmslib.init()
index.addDataPointBatch(data)
index.createIndex({'post': 2}, print_progress=True)

while True:
    input_split = input("query> ").rstrip('\n').lower().split(" ")
    print(input_split)
    query = [ft_model.wv[tok] for tok in input_split]
    query = np.mean(query, axis=0)

    t0 = time.time()
    ids, distances = index.knnQuery(query, k=5)
    t1 = time.time()
    print(f'Searched {df.shape[0]} records in {round(t1-t0,4) } seconds \n')
    for i,j in zip(ids,distances):
        print(round(j,2))
        print(text[i])

