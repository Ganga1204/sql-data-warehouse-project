import numpy as np

# Confusion matrix: rows = predicted, columns = actual
cm = np.array([[5, 10, 5],
               [15, 20, 10],
               [0, 15, 10]])

classes = ['Cat', 'Dog', 'Rabbit']

# True Positives, False Positives, False Negatives
TP = np.diag(cm)
FP = np.sum(cm, axis=0) - TP  # sum of column minus TP
FN = np.sum(cm, axis=1) - TP  # sum of row minus TP

# Per-class precision and recall
precision = TP / (TP + FP)
recall = TP / (TP + FN)

# Macro-averaged precision and recall
macro_precision = np.mean(precision)
macro_recall = np.mean(recall)

# Micro-averaged precision and recall
total_TP = np.sum(TP)
total_FP = np.sum(FP)
total_FN = np.sum(FN)
micro_precision = total_TP / (total_TP + total_FP)
micro_recall = total_TP / (total_TP + total_FN)

# Print per-class metrics
print("Per-Class Metrics:")
for i, cls in enumerate(classes):
    print(f"{cls} -> Precision: {precision[i]:.3f}, Recall: {recall[i]:.3f}")

# Print macro and micro metrics
print("\nMacro-Averaged Metrics:")
print(f"Precision: {macro_precision:.3f}, Recall: {macro_recall:.3f}")

print("\nMicro-Averaged Metrics:")
print(f"Precision: {micro_precision:.3f}, Recall: {micro_recall:.3f}")
