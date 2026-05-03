from collections import defaultdict

# Training corpus
corpus = [
    ["<s>", "I", "love", "NLP", "</s>"],
    ["<s>", "I", "love", "deep", "learning", "</s>"],
    ["<s>", "deep", "learning", "is", "fun", "</s>"]
]

# Step 1: Count unigrams and bigrams
unigram_counts = defaultdict(int)
bigram_counts = defaultdict(int)

for sentence in corpus:
    for i, word in enumerate(sentence):
        unigram_counts[word] += 1
        if i < len(sentence) - 1:
            bigram = (word, sentence[i+1])
            bigram_counts[bigram] += 1

# Step 2: Compute bigram probabilities with MLE
def bigram_prob(w1, w2):
    if unigram_counts[w1] == 0:
        return 0.0
    return bigram_counts[(w1, w2)] / unigram_counts[w1]

# Step 3: Compute sentence probability
def sentence_prob(sentence):
    prob = 1.0
    for i in range(len(sentence)-1):
        p = bigram_prob(sentence[i], sentence[i+1])
        prob *= p
    return prob

# Test sentences
s1 = ["<s>", "I", "love", "NLP", "</s>"]
s2 = ["<s>", "I", "love", "deep", "learning", "</s>"]

p1 = sentence_prob(s1)
p2 = sentence_prob(s2)

# Print results
print("Sentence 1:", " ".join(s1), "Probability =", p1)
print("Sentence 2:", " ".join(s2), "Probability =", p2)

if p1 > p2:
    print("Model prefers Sentence 1 because it has a higher probability.")
elif p2 > p1:
    print("Model prefers Sentence 2 because it has a higher probability.")
else:
    print("Model is indifferent; both have the same probability.")