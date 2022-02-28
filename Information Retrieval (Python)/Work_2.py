import string
import math
import copy
import numpy as np
import pandas as pd
import nltk
from nltk.book import *
from collections import Counter
from collections import OrderedDict

def cleanedText(text):
    if not isinstance(text, list):
        text = nltk.word_tokenize(text)

    cleaned_text = []
    for token in text:
        if token in string.punctuation:
            continue
        else:
            cleaned_text.append(token.lower())
    return cleaned_text

def postingLists(text):
    dict_text = {}
    dict_max3 = {}

    for pos, term in enumerate(cleanedText(text)):
        if term in dict_text:
            dict_text[term][0] = dict_text[term][0] + 1
            dict_text[term][1].append(pos)
        else:
            dict_text[term] = []
            dict_text[term].append(1)
            dict_text[term].append({})     
            dict_text[term][1] = [pos]

    for i in range(3):
        max0 = max(dict_text, key=dict_text.get)
        dict_max3[max0] = dict_text[max0]
        dict_text.pop(max0)

    return dict_max3

def vectorize(txt1, txt2):
    lexicon = sorted(set(txt1 + txt2))
    zero_vector = OrderedDict((token, 0) for token in lexicon)

    text_vectors = []
    for text, text_tokens in enumerate([txt1, txt2]):
        vec = copy.copy(zero_vector)
        bag_of_words = Counter(text_tokens)
        for k, v in bag_of_words.items():
            vec[k] = v / len(lexicon)
        text_vectors.append(vec)

    return text_vectors

def cosine_sim(vec1, vec2):
    vec1 = [val for val in vec1.values()]
    vec2 = [val for val in vec2.values()]

    dot_prod = 0.0
    for i, v in enumerate(vec1):
        dot_prod += v * vec2[i]

    mag_1 = math.sqrt(sum([x**2 for x in vec1]))
    mag_2 = math.sqrt(sum([x**2 for x in vec2]))

    return dot_prod / (mag_1 * mag_2)

# ΕΡΩΤΗΣΗ 1
sentence1 = "Thomas Jefferson began building Monticello at the age of 26."
sentence2 = "This is my sentence, i used my glorious imagination to create it."

sentence1_split = sentence1.split()
sentence2_split = sentence2.split()
sentence1_word_tokenize = nltk.word_tokenize(sentence1)
sentence2_word_tokenize = nltk.word_tokenize(sentence2)

vocab_sentence1_split = sorted(set(sentence1_split))
vocab_sentence2_split = sorted(set(sentence2_split))
vocab_sentence1_word_tokenize = sorted(set(sentence1_word_tokenize))
vocab_sentence2_word_tokenize = sorted(set(sentence2_word_tokenize))

onehot_sentence1_split = np.zeros((len(sentence1_split), len(vocab_sentence1_split)), int)
onehot_sentence2_split = np.zeros((len(sentence2_split), len(vocab_sentence2_split)), int)
onehot_sentence1_word_tokenize = np.zeros((len(sentence1_word_tokenize), len(vocab_sentence1_word_tokenize)), int)
onehot_sentence2_word_tokenize = np.zeros((len(sentence2_word_tokenize), len(vocab_sentence2_word_tokenize)), int)

for i, word in enumerate(sentence1_split):
    onehot_sentence1_split[i, vocab_sentence1_split.index(word)] = 1
for i, word in enumerate(sentence2_split):
    onehot_sentence2_split[i, vocab_sentence2_split.index(word)] = 1
for i, word in enumerate(sentence1_word_tokenize):
    onehot_sentence1_word_tokenize[i, vocab_sentence1_word_tokenize.index(word)] = 1
for i, word in enumerate(sentence2_word_tokenize):
    onehot_sentence2_word_tokenize[i, vocab_sentence2_word_tokenize.index(word)] = 1

print("ΕΡΩΤΗΣΗ 1")
print("ΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence1_split")
print(onehot_sentence1_split)
print("\nΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence1_word_tokenize")
print(onehot_sentence1_word_tokenize)
print("\nΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence2_split")
print(onehot_sentence2_split)
print("\nΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence2_word_tokenize")
print(onehot_sentence2_word_tokenize)


# ΕΡΩΤΗΣΗ 2
print("\nΕΡΩΤΗΣΗ 2")
print("DATA FRAME ΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence1_split")
print(pd.DataFrame(onehot_sentence1_split, columns=vocab_sentence1_split))
print("\nDATA FRAME ΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence1_word_tokenize")
print(pd.DataFrame(onehot_sentence1_word_tokenize, columns=vocab_sentence1_word_tokenize))
print("\nDATA FRAME ΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence2_split")
print(pd.DataFrame(onehot_sentence2_split, columns=vocab_sentence2_split))
print("\nDATA FRAME ΠΙΝΑΚΑΣ ΣΥΜΠΤΩΣΗΣ sentence2_word_tokenize")
print(pd.DataFrame(onehot_sentence2_word_tokenize, columns=vocab_sentence2_word_tokenize))


# ΕΡΩΤΗΣΗ 3
sentence3 = "That was a sentence, it was not nice cause no imagination was used."
sentence4 = "It has been a pleasure dear friend, the fun we had was glorious."
sentence5 = "You have to create it yourself, now just go and use your imagination."

corpus1 = {}
corpus1['sent2'] = dict((tok, 1) for tok in cleanedText(sentence2))
corpus1['sent3'] = dict((tok, 1) for tok in cleanedText(sentence3))
corpus1['sent4'] = dict((tok, 1) for tok in cleanedText(sentence4))
corpus1['sent5'] = dict((tok, 1) for tok in cleanedText(sentence5))

corpus2 = {}
corpus2['text4'] = dict((tok, 1) for tok in cleanedText(text4[0:50]))
corpus2['text7'] = dict((tok, 1) for tok in cleanedText(text7[0:50]))

df1 = pd.DataFrame.from_records(corpus1).fillna(0).astype(int).T
df2 = pd.DataFrame.from_records(corpus2).fillna(0).astype(int).T

print("\nΕΡΩΤΗΣΗ 3")
print("\nα) Ομοιότητες μεταξύ sentence2,3,4,5 (ΧΩΡΙΣ ΣΗΜΕΙΑ ΣΤΙΞΗΣ)")
print(df1)
print("\nβ) Ομοιότητες μεταξύ text4 και text7 (ΧΩΡΙΣ ΣΗΜΕΙΑ ΣΤΙΞΗΣ)")
print(df2)
print("\nβ) Κοινές λέξεις μεταξύ text4 και text7 (ΧΩΡΙΣ ΣΗΜΕΙΑ ΣΤΙΞΗΣ)")
print([(k, v) for (k, v) in (df2.T.text4 & df2.T.text7).items() if v])


# ΕΡΩΤΗΣΗ 4
print("\nΕΡΩΤΗΣΗ 4")
print("Τρεις συχνότερα εμνφανιζόμενες λέξεις στο text4[0:50] (ΧΩΡΙΣ ΣΗΜΕΙΑ ΣΤΙΞΗΣ)")
print(postingLists(" ".join(text4[0:50])))
print("\nΤρεις συχνότερα εμνφανιζόμενες λέξεις στο text7[0:50] (ΧΩΡΙΣ ΣΗΜΕΙΑ ΣΤΙΞΗΣ)")
print(postingLists(" ".join(text7[0:50])))


# ΕΡΩΤΗΣΗ 5
print("\n\nbag_of_words_sentence2")
print(Counter(sentence2))
print("\nbag_of_words_text4")
print(Counter(text4[0:50]))
print("\nbag_of_words_text7")
print(Counter(text7[0:50]))

# ΕΡΩΤΗΣΗ 5
print("\nΕΡΩΤΗΣΗ 5")
print("Ομοιότητα συνημίτονων των δύο προτάσεων των δύο βιβλίων.")
vec_text50 = vectorize(text4[0:50], text7[0:50])
print(cosine_sim(vec_text50[0], vec_text50[1]))

# ΕΡΩΤΗΣΗ 6
print("\nΕΡΩΤΗΣΗ 6")
print("Ομοιότητα συνημίτονων των δύο βιβλίων.")
vec_text = vectorize(text4[:], text7[:])
print(cosine_sim(vec_text[0], vec_text[1]))