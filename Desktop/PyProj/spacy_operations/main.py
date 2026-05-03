# main.py

import spacy

# Step 1: Define text
text = "Students often struggle with managing their time effectively. Sometimes, they procrastinate, which leads to stress. However, with practice, they can develop better habits."

# Step 2: Naïve space-based tokenization
naive_tokens = text.split(" ")

# Step 3: Manual correction (separate punctuation manually)
manual_tokens = [
    "Students", "often", "struggle", "with", "managing", "their", "time", "effectively", ".",
    "Sometimes", ",", "they", "procrastinate", ",", "which", "leads", "to", "stress", ".",
    "However", ",", "with", "practice", ",", "they", "can", "develop", "better", "habits", "."
]

# Step 4: spaCy tokenization
nlp = spacy.load("en_core_web_sm")
doc = nlp(text)
spacy_tokens = [token.text for token in doc]

# Step 5: Print results
print("Original Text:\n", text, "\n")
print("Naïve space-based tokens:\n", naive_tokens, "\n")
print("Manual corrected tokens:\n", manual_tokens, "\n")
print("spaCy tokens:\n", spacy_tokens, "\n")

# Step 6: Compare differences
print("Differences between Naïve and Manual:")
for i, token in enumerate(naive_tokens):
    if i < len(manual_tokens) and token != manual_tokens[i]:
        print(f"Naïve: {token}  |  Manual: {manual_tokens[i]}")

print("\nDifferences between Manual and spaCy:")
for i, token in enumerate(manual_tokens):
    if i < len(spacy_tokens) and token != spacy_tokens[i]:
        print(f"Manual: {token}  |  spaCy: {spacy_tokens[i]}")
