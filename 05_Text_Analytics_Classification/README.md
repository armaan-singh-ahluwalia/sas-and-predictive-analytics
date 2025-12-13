# Text Analytics with Naive Bayes and SVM for advertisement classfification

## Business Problem
The objective of this project was to classify text-based advertisements into predefined categories using supervised learning models. The analysis demonstrates how unstructured textual data can be transformed into quantitative features and used to support automated classification tasks such as ad screening, content filtering, or marketing response prediction.

## Data Overview
- Dataset: Farm advertisement text data
- Data Type: Unstructured text
- Target Variable: `label`
- Characteristics:
  - High-dimensional and sparse text features
  - Vocabulary size substantially larger than the number of observations
- Data Preparation:
  - Text cleaning and normalization
  - Stemming using SnowballC
  - TF-IDF weighting to emphasize informative terms

## Methodology

### Text Preprocessing
The following preprocessing steps were applied using the `tm` package:
- Whitespace removal
- Punctuation removal
- Lowercasing
- Stopword removal
- Word stemming using SnowballC

### Feature Engineering
- Document–Term Matrix (DTM) construction
- Removal of sparse terms
- TF-IDF weighting to reduce the influence of common terms
- Conversion to a modeling-ready data frame

### Models Evaluated
- Naive Bayes (with Laplace smoothing and kernel options)
- Support Vector Machine (radial kernel)

### Validation Strategy
- 80/20 train–test split
- 10-fold cross-validation for hyperparameter tuning
- Model performance evaluated using confusion matrices

## Key Insights
- TF-IDF weighting improved class separation in sparse text data
- Naive Bayes performed efficiently and provided a strong baseline
- SVM demonstrated superior performance in capturing complex boundaries
- Text classification performance is sensitive to preprocessing and sparsity thresholds

## Business Recommendations
- Use Naive Bayes for fast, scalable baseline text classification
- Deploy SVM models when higher predictive accuracy is required
- Periodically retrain models to reflect changes in language usage
- Monitor vocabulary growth to maintain model performance

## Tools Used
- R
- Libraries: tm, SnowballC, caret, naivebayes

