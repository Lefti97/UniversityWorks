from nltk.corpus import words

# ΑΣΚΗΣΗ Α function
mem = {}
def levenshtein(str1, str2):
    if str1 == "":
        return len(str2)
    if str2 == "":
        return len(str1)
    cost = 0 if str1[-1] == str2[-1] else 1
       
    i1 = (str1[:-1], str2)
    if not i1 in mem:
        mem[i1] = levenshtein(*i1)
    i2 = (str1, str2[:-1])
    if not i2 in mem:
        mem[i2] = levenshtein(*i2)
    i3 = (str1[:-1], str2[:-1])
    if not i3 in mem:
        mem[i3] = levenshtein(*i3)
    res = min([mem[i1]+1, mem[i2]+1, mem[i3]+cost])
    
    return res

# ΑΣΚΗΣΗ Β function
def levenshtein_correction(incorrect_words):
    correct_words = words.words()
    for word in incorrect_words:
        temp = [(levenshtein(word, w),w) 
            for w in correct_words if w[0]==word[0]]
        print(word + " -> " + sorted(temp, key = lambda val:val[0])[0][1])


# ΑΣΚΗΣΗ Α
print("\nΑΣΚΗΣΗ Α - Levenshtein distance")
print("\"Giwrgos\" , \"Kwstas\" = " + str(levenshtein("Giwrgos","Kwstas")))
print("\"One baloon\" , \"for you\" = " + str(levenshtein("One baloon","for you")))
print("\"he was very fast\" , \"like a cheetah\" = " + str(levenshtein("he was very fast","like a cheetah")))
print("\"Πύθωνας\" , \"Φίδι\" = " + str(levenshtein("Πύθωνας","Φίδι")))
print("\"Μανιτάρια\" , \"Γάλα\" = " + str(levenshtein("Μανιτάρια","Γάλα")))
print("\"Περπάταγα στο βουνό\" , \"και είδα έναν εξωγήινο\" = " 
    + str(levenshtein("Περπάταγα στο βουνό","και είδα έναν εξωγήινο")))

# ΑΣΚΗΣΗ Β
print("\nΑΣΚΗΣΗ Β - Correcting words with Levenshtein distance")
levenshtein_correction(['sourprise', 'saed', 'pastaa', 'mortali', 'disc'])
