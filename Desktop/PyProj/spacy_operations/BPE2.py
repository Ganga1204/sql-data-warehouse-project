from collections import Counter

# Toy corpus
corpus = [
    "low", "low", "low", "low", "low",
    "lowest", "lowest",
    "newer", "newer", "newer", "newer", "newer", "newer",
    "wider", "wider", "wider",
    "new", "new"
]

# Add end-of-word marker
corpus = [list(word) + ['_'] for word in corpus]

def get_bigrams(corpus):
    """Count bigrams in the corpus."""
    bigram_counts = Counter()
    for word in corpus:
        for i in range(len(word)-1):
            bigram_counts[(word[i], word[i+1])] += 1
    return bigram_counts

def learn_bpe(corpus, num_merges=10):
    """Learn BPE merges."""
    vocab = set(char for word in corpus for char in word)
    merges = []
    for step in range(num_merges):
        bigram_counts = get_bigrams(corpus)
        if not bigram_counts:
            break
        top_pair = bigram_counts.most_common(1)[0][0]
        new_token = ''.join(top_pair)
        merges.append(new_token)
        print(f"Step {step+1}: Top pair {top_pair} -> '{new_token}', Vocab size: {len(vocab)+1}")

        # Apply merge to corpus
        new_corpus = []
        for word in corpus:
            i = 0
            new_word = []
            while i < len(word):
                if i < len(word)-1 and (word[i], word[i+1]) == top_pair:
                    new_word.append(new_token)
                    i += 2
                else:
                    new_word.append(word[i])
                    i += 1
            new_corpus.append(new_word)
        corpus = new_corpus
        vocab.add(new_token)
    return merges, corpus, vocab

# Learn BPE
merges, final_corpus, final_vocab = learn_bpe(corpus, num_merges=10)

# Function to segment new words
def segment_word(word, merges):
    chars = list(word) + ['_']
    for merge in merges:
        i = 0
        while i < len(chars)-1:
            if chars[i] + chars[i+1] == merge:
                chars[i] = merge
                del chars[i+1]
            else:
                i += 1
    return chars

# Segment example words
words_to_segment = ["new", "newer", "lowest", "wider", "newestest"]
for w in words_to_segment:
    segmented = segment_word(w, merges)
    print(f"{w} -> {segmented}")

