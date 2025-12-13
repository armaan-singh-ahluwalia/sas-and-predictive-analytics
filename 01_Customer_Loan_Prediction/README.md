# Customer Loan Acceptance Prediction

## Business Problem
The objective of this project was to predict whether a retail banking customer would accept a personal loan offer. The model is intended to support targeted marketing and credit decision-making by identifying customers with a high likelihood of loan acceptance, thereby improving campaign efficiency and reducing acquisition costs.

## Data Overview
- Dataset: Universal Bank customer dataset
- Observations: Customer-level records
- Target Variable: Personal.Loan (Yes / No)
- Key Predictors:
  - Demographics: Age, Experience, Education, Family
  - Financial attributes: Income, CCAvg, Mortgage
  - Account indicators: Securities Account, CD Account, Online Banking, Credit Card
- Data Preparation:
  - Identifier variables (ID, ZIP Code) removed
  - Categorical variables factorized
  - Class balance verified across train and test sets

## Methodology
The modeling strategy focused on comparing multiple supervised learning techniques to balance predictive performance and interpretability.

### Models Evaluated
- k-Nearest Neighbors (kNN)
- Naive Bayes
- Decision Trees (C5.0)
- Artificial Neural Networks (ANN)
- Support Vector Machines (SVM – radial kernel)

### Validation Strategy
- 80/20 train–test split
- 10-fold cross-validation for most models
- Kappa used as the primary tuning metric to account for class imbalance
- Feature scaling applied where required (kNN, ANN, SVM)

## Model Performance
Model performance was evaluated using confusion matrices, with emphasis on:
- Sensitivity (correctly identifying loan accepters)
- Specificity
- Overall classification accuracy

Key observations:
- Tree-based and linear probabilistic models offered interpretability but moderate predictive power
- ANN and SVM models demonstrated stronger performance in capturing nonlinear relationships
- kNN performance was sensitive to scaling and neighborhood size
- SVM provided a strong balance between generalization and robustness on unseen data

## Key Insights
- Income, average credit card spending (CCAvg), and possession of a CD account were consistently strong predictors of loan acceptance
- Customers with higher engagement across banking products showed a higher likelihood of accepting personal loan offers
- Complex nonlinear models improved accuracy but reduced interpretability
- Simpler models remain useful for explainability-driven decision contexts

## Business Recommendations
- Use predictive models to prioritize customers with high acceptance probability for loan campaigns
- Deploy interpretable models (e.g., decision trees or logistic regression) when regulatory transparency is required
- Use higher-performing nonlinear models (SVM or ANN) for internal targeting and marketing optimization
- Periodically retrain models to account for changes in customer behavior and macroeconomic conditions

## Tools Used
- R
- Libraries: caret, naivebayes, C50, NeuralNetTools, class
