############################################################
# Customer Loan Acceptance Prediction
#
# Description:
# This script builds and compares multiple supervised
# learning models to predict customer acceptance of
# personal loan offers using the Universal Bank dataset.
#
# Models Included:
# - k-Nearest Neighbors (kNN)
# - Naive Bayes
# - Decision Trees (C5.0)
# - Artificial Neural Networks (ANN)
# - Support Vector Machines (SVM)
#
# Validation:
# - 80/20 Train-Test Split
# - k-Fold Cross-Validation
# - Kappa and repsctive model tuning parameters used for model tuning
#
# Author: Armaan Singh Ahluwalia
############################################################


############################################################
# 1. Library Imports
############################################################

library(caret)
library(naivebayes)
library(class)
library(C50)
library(NeuralNetTools)
library(fastDummies)


############################################################
# 2. Data Loading and Preparation
############################################################

# Dataset expected in working directory
bank_df <- read.csv("UniversalBank_2.csv")

# Drop identifiers
bank_df$ID <- NULL
bank_df$ZIP.Code <- NULL

# Factorization of categorical variables
bank_df$Education <- factor(bank_df$Education)
bank_df$Family <- factor(bank_df$Family)
bank_df$Personal.Loan <- factor(bank_df$Personal.Loan)
bank_df$Securities.Account <- factor(bank_df$Securities.Account)
bank_df$CD.Account <- factor(bank_df$CD.Account)
bank_df$Online <- factor(bank_df$Online)
bank_df$CreditCard <- factor(bank_df$CreditCard)

str(bank_df)
summary(bank_df)


############################################################
# 3. Train-Test Split and Class Balance Check
############################################################

set.seed(1948)

train_index <- createDataPartition(
  y = bank_df$Personal.Loan,
  p = 0.8,
  list = FALSE
)

train_df <- bank_df[train_index, ]
test_df  <- bank_df[-train_index, ]

# Class proportions
proportions(table(bank_df$Personal.Loan))
proportions(table(train_df$Personal.Loan))
proportions(table(test_df$Personal.Loan))


############################################################
# 4. Model Training and Evaluation
############################################################

# Common cross-validation control
cv_ctrl <- trainControl(method = "cv", number = 10)


############################
# k-Nearest Neighbors (kNN)
############################

knn_model <- train(
  Personal.Loan ~ .,
  data = train_df,
  method = "knn",
  metric = "Kappa",
  preProcess = c("center", "scale"),
  tuneLength = 10,
  trControl = cv_ctrl
)

knn_model
plot(knn_model)

knn_pred <- predict(knn_model, test_df)
confusionMatrix(knn_pred, test_df$Personal.Loan, positive = "1")


############################
# Naive Bayes
############################

nb_grid <- expand.grid(
  laplace = c(0, 1),
  usekernel = c(TRUE, FALSE),
  adjust = c(1, 1.5, 2)
)

nb_model <- train(
  Personal.Loan ~ .,
  data = train_df,
  method = "naive_bayes",
  metric = "Kappa",
  tuneGrid = nb_grid,
  trControl = cv_ctrl
)

nb_model
plot(nb_model)

nb_pred <- predict(nb_model, test_df)
confusionMatrix(nb_pred, test_df$Personal.Loan, positive = "1")


############################
# Decision Tree (C5.0)
############################

dt_grid <- expand.grid(
  model = c("rules", "tree"),
  winnow = c(TRUE, FALSE),
  trials = seq(1, 9, 2)
)

dt_model <- train(
  Personal.Loan ~ Age + Experience + Income + Family + CCAvg +
    Education + Mortgage + Securities.Account + CD.Account +
    Online + CreditCard,
  data = train_df,
  method = "C5.0",
  tuneGrid = dt_grid,
  trControl = cv_ctrl
)

dt_model

dt_pred <- predict(dt_model, test_df)
confusionMatrix(dt_pred, test_df$Personal.Loan, positive = "1")


############################
# Artificial Neural Network (ANN)
############################

ann_grid <- expand.grid(
  size = seq(5, 15, 5),
  decay = seq(0.1, 0.7, 0.2)
)

ann_model <- train(
  Personal.Loan ~ Age + Experience + Income + Family + CCAvg +
    Education + Mortgage + Securities.Account + CD.Account +
    Online + CreditCard,
  data = train_df,
  method = "nnet",
  metric = "Kappa",
  maxit = 500,
  preProcess = c("center", "scale"),
  trace = FALSE,
  tuneGrid = ann_grid,
  trControl = trainControl(method = "cv", number = 5)
)

ann_model

ann_pred <- predict(ann_model, test_df)
confusionMatrix(ann_pred, test_df$Personal.Loan, positive = "1")


############################
# Support Vector Machine (SVM)
############################

svm_grid <- expand.grid(
  C = c(0.25, 0.5, 1, 2),
  sigma = c(0.01, 0.025, 0.05, 0.1)
)

svm_model <- train(
  Personal.Loan ~ Age + Experience + Income + Family + CCAvg +
    Education + Mortgage + Securities.Account + CD.Account +
    Online + CreditCard,
  data = train_df,
  method = "svmRadial",
  preProcess = c("center", "scale"),
  tuneGrid = svm_grid,
  trControl = cv_ctrl
)

svm_model

svm_pred <- predict(svm_model, test_df)
confusionMatrix(svm_pred, test_df$Personal.Loan, positive = "1")


