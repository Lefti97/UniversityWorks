import string
import nltk
from nltk.book import *
from nltk import tokenize
from nltk import stem
from nltk.stem import PorterStemmer
from nltk.stem import LancasterStemmer

nltk.download('wordnet')

# Βήμα 1 Απλά στατιστικά
def vocabularyRichness(text):
    return len(set(text)) / len(text)

def cleanedText(text):
    stopwordsEn = nltk.corpus.stopwords.words('english')
    stopwordsGr = nltk.corpus.stopwords.words('greek')
    cleaned_text = []
    for token in text:
        if token in string.punctuation:
            continue
        elif token in stopwordsEn:
            continue
        elif token in stopwordsGr:
            continue
        else:
            cleaned_text.append(token)
    return cleaned_text


# ΕΡΩΤΗΜΑ 1Α
print("VHMA 1")
print("\nERWTIMA 1A")
print("i)")
print("Monty Python and the Holy Grail:")
print("Vocabulary Richness: " + str(round(100 * vocabularyRichness(text6), 2)) + "%")
print("Word \"LAUNCELOT\" appearances: " + str(text6.count("LAUNCELOT")))
print("Word \"LAUNCELOT\" % of appearance: " + str(round(100 * text6.count("LAUNCELOT") / len(text6), 2)) + "%")

print("ii)")
print("Chat Corpus:")
print("Vocabulary Richness: " + str(round(100 * vocabularyRichness(text5), 2)) + "%")
print("Words \"omg\" appearances: " + str(text5.count("omg")))
print("Words \"OMG\" appearances: " + str(text5.count("OMG")))
print("Words \"lol\" appearances: " + str(text5.count("lol")))
print("Words \"omg\" percentage of appearance: " + str(round(100 * text5.count("omg") / len(text6), 2)) + "%")
print("Words \"OMG\" percentage of appearance: " + str(round(100 * text5.count("OMG") / len(text6), 2)) + "%")
print("Words \"lol\" percentage of appearance: " + str(round(100 * text5.count("lol") / len(text6), 2)) + "%")

# ΕΡΩΤΗΜΑ 1Β
print("\nERWTIMA 1B")
print("Monty Python and the Holy Grail:")
print("Word \"kill\" % of appearance: " + str(round(100 * text6.count("kill") / len(text6), 2)) + "%")
print("Word \"king\" % of appearance: " + str(round(100 * text6.count("king") / len(text6), 2)) + "%")
print("Word \"the\" % of appearance: " + str(round(100 * text6.count("the") / len(text6), 2)) + "%")

print("\nChat Corpus:")
print("Words \"talk\" percentage of appearance: " + str(round(100 * text5.count("talk") / len(text6), 2)) + "%")
print("Words \"man\" percentage of appearance: " + str(round(100 * text5.count("man") / len(text6), 2)) + "%")
print("Words \"one\" percentage of appearance: " + str(round(100 * text5.count("one") / len(text6), 2)) + "%")

# ΕΡΩΤΗΜΑ 3
fdist1 = FreqDist(text6)
fdist1.most_common(50)
fdist1.plot(50)

# Βήμα 2 Κανονικοποίηση κειμένου (normalization)
print("\nVHMA 2")

print("\nERWTIMA 4")
tokens1=sent1
normalized_sent1=[x.lower() for x in tokens1]
print(sent1)
print(normalized_sent1)

tokens1 = text2[0:200] # tokens1 = πρώτες 200 λεκτικές μονάδες του Sense and Sensibility
porter = PorterStemmer()
wnl = nltk.WordNetLemmatizer()

print("\nNormal text, Sense and Sensibility")
for x in tokens1:
    print(x, end=" ")
print("\n\nText using PorterStemmer, Sense and Sensibility")
for x in tokens1:
    print(porter.stem(x), end=" ")
print("\n\nText using WordNetLemmatizer, Sense and Sensibility")
for x in tokens1:
    print(wnl.lemmatize(x), end=" ")

print("\n\nERWTIMA 5")

myText1 = "Once upon a time, there was a big frog in the lake. Then the frog died."
print("\n\tText, myText1")
for x in myText1.split():
    print(x, end=" ")
print("\n\tNormalized text, myText1")
for x in myText1.split():
    print(x.lower(), end=" ")
print("\n\tText using PorterStemmer, myText1")
for x in myText1.split():
    print(porter.stem(x), end=" ")
print("\n\tText using WordNetLemmatizer, myText1")
for x in myText1.split():
    print(wnl.lemmatize(x), end=" ")
print()
myText2 = "Περπατούσα στον δρόμο με ένα σκυλί, και πέρασε από μπροστά μας ένα γατί. Το σκυλί μου κυνήγησε το γατί."
print("\n\tText, myText2")
for x in myText2.split():
    print(x, end=" ")
print("\n\tNormalized text, myText2")
for x in myText2.split():
    print(x.lower(), end=" ")
print("\n\tText using PorterStemmer, myText2")
for x in myText2.split():
    print(porter.stem(x), end=" ")
print("\n\tText using WordNetLemmatizer, myText2")
for x in myText2.split():
    print(wnl.lemmatize(x), end=" ")

print("VHMA 3")

sentence = "Monticello wasn't designated as UNESCO World Heritage Site until 1987."
print(sentence.split())
print(nltk.word_tokenize(sentence))

print("\n\nERWTIMA 6\n")

text2_200first = " ".join(text2[0:200])
print("\nSense and Sensibility, .split()")
print(text2_200first.split())
print("\nSense and Sensibility, .word_tokenize()")
print(nltk.word_tokenize(text2_200first))
print("\nmyText1, .split()")
print(myText1.split())
print("\nmyText1, .word_tokenize()")
print(nltk.word_tokenize(myText1))
print("\nmyText2, .split()")
print(myText2.split())
print("\nmyText2, .word_tokenize()")
print(nltk.word_tokenize(myText2))

print("VHMA 4")

print()
cleaned_tokens = []
for token in tokens1:
    if token not in string.punctuation:
        cleaned_tokens.append(token )
print(cleaned_tokens)

print("\nEnglish stopwords")
stopwordsEn = nltk.corpus.stopwords.words('english')
print(stopwordsEn)
print("\nGreek stopwords")
stopwordsGr = nltk.corpus.stopwords.words('greek')
print(stopwordsGr)

print("\nERWTIMA 7")
print("Number of English Stopwords: " + str(len(stopwordsEn)) + "\tof Greek Stopwords: " + str(len(stopwordsGr)))

print("\nERWTIMA 8\n")
print(cleanedText(tokens1), "\n")
print(cleanedText(nltk.word_tokenize(myText1)), "\n")
print(cleanedText(nltk.word_tokenize(myText2)), "\n")

# ΕΡΩΤΗΜΑ 9
fdist2 = FreqDist(tokens1)
fdist2.most_common(50)
fdist2.plot(50)

fdist3 = FreqDist(cleanedText(tokens1))
fdist3.most_common(50)
fdist3.plot(50)
