"""Generate the example figures used in the template guide.

Keeping the scripts that produce your figures next to the thesis makes them
reproducible: if the data change, run the script again and recompile.

    python figures/src/example_figures.py

Requires numpy and matplotlib. The figures are saved as vector PDFs in figures/.
"""
from pathlib import Path

import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np

OUT = Path(__file__).resolve().parents[1]
ACCENT = "#1F4E79"
SECOND = "#C0504D"

mpl.rcParams.update({
    "pdf.fonttype": 42,          # embed TrueType fonts (selectable text in the PDF)
    "font.size": 10,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "axes.grid": True,
    "grid.alpha": 0.25,
    "legend.frameon": False,
    "savefig.bbox": "tight",
})

rng = np.random.default_rng(2026)


def learning_curves() -> None:
    epochs = np.arange(1, 51)
    train = 0.9 * np.exp(-epochs / 9) + 0.08 + rng.normal(0, 0.008, epochs.size)
    val = 0.85 * np.exp(-epochs / 11) + 0.15 + 0.0016 * np.clip(epochs - 25, 0, None) ** 1.3 \
        + rng.normal(0, 0.012, epochs.size)
    best = int(np.argmin(val))
    fig, ax = plt.subplots(figsize=(6, 3.2))
    ax.plot(epochs, train, color=ACCENT, lw=1.8, label="Training")
    ax.plot(epochs, val, color=SECOND, lw=1.8, label="Validation")
    ax.axvline(epochs[best], color="0.4", ls="--", lw=1)
    ax.annotate("Best model", xy=(epochs[best], val[best]), xytext=(epochs[best] + 4, val[best] + 0.25),
                arrowprops=dict(arrowstyle="->", color="0.3"), color="0.2")
    ax.set_xlabel("Epoch")
    ax.set_ylabel("Loss")
    ax.legend()
    fig.savefig(OUT / "example-learning-curves.pdf")
    plt.close(fig)


def roc_curve() -> None:
    fpr = np.linspace(0, 1, 200)
    fig, ax = plt.subplots(figsize=(3.2, 3.2))
    for a, colour, name in [(0.18, ACCENT, "Proposed (AUC = 0.91)"), (0.35, SECOND, "Baseline (AUC = 0.82)")]:
        ax.plot(fpr, fpr ** a, color=colour, lw=1.8, label=name)
    ax.plot([0, 1], [0, 1], color="0.6", ls=":", lw=1)
    ax.set_xlabel("False positive rate")
    ax.set_ylabel("True positive rate")
    ax.set_aspect("equal")
    ax.legend(loc="lower right", fontsize=8)
    fig.savefig(OUT / "example-roc-curve.pdf")
    plt.close(fig)


def confusion_matrix() -> None:
    cm = np.array([[412, 38], [27, 223]])
    fig, ax = plt.subplots(figsize=(3.2, 3.2))
    ax.imshow(cm, cmap="Blues")
    ax.grid(False)
    for (i, j), v in np.ndenumerate(cm):
        ax.text(j, i, str(v), ha="center", va="center", color="white" if v > 200 else "black", fontsize=12)
    ax.set_xticks([0, 1], ["Negative", "Positive"])
    ax.set_yticks([0, 1], ["Negative", "Positive"])
    ax.set_xlabel("Predicted class")
    ax.set_ylabel("True class")
    for s in ax.spines.values():
        s.set_visible(False)
    fig.savefig(OUT / "example-confusion-matrix.pdf")
    plt.close(fig)


if __name__ == "__main__":
    learning_curves()
    roc_curve()
    confusion_matrix()
    print(f"Figures written to {OUT}")
