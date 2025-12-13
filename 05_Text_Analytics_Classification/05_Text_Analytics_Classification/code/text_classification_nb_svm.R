############################################################
# Text Analytics and Document Classification
#
# Description:
# This script performs text preprocessing, TF-IDF feature
# engineering, and supervised text classification using
# Naive Bayes and Support Vector Machines.
#
# Author: Armaan Singh Ahluwalia
############################################################


############################################################
# 1. Library Imports
############################################################

library(tm)
library(SnowballC)
library(caret)
library(naivebayes)
library(class)


############################################################
# 2. Data Loading
############################################################

# Dataset expected in working directory
ta <- read.csv("FarmAds_1.csv", stringsAsFactors = FALSE)

ta$label <- factor(ta$label)


############################################################
# 3. Corpus Creation and Preprocessing
############################################################

corp_ta <- VCorpus(DataframeSource(ta))

# Text cleaning
corp_ta <- tm_map(corp_ta, stripWhitespace)
corp_ta <- tm_map(corp_ta, removePunctuation)
corp_ta <- tm_map(corp_ta, content_transformer(tolower))

# Stopword removal and stemming
corp_ta <- tm_map(corp_ta, stemDocument)
corp_ta <- tm_map(corp_ta, removeWords, stopwords("english"))


############################################################
# 4. Document-Term Matrix and TF-IDF
############################################################

dtm_ta <- DocumentTermMatrix(corp_ta)

# Remove sparse terms
dtm_ta_small <- removeSparseTerms(dtm_ta, 0.99)

# TF-IDF weighting
tfidf_ta_small <- weightTfIdf(dtm_ta_small)

# Convert to data frame
tfidf_mat <- as.matrix(tfidf_ta_small)
tfidf_df <- as.data.frame(tfidf_mat)

# Add target variable
tfidf_df$label <- ta$label


############################################################
# 5. Train-Test Split
############################################################

set.seed(1947)

idx_ta <- createDataPartition(
  y = tfidf_df$label,
  p = 0.8,
  list = FALSE
)

tr_ta_df  <- tfidf_df[idx_ta, ]
tes_ta_df <- tfidf_df[-idx_ta, ]

# Class balance check
proportions(table(tr_ta_df$label))
proportions(table(tes_ta_df$label))
proportions(table(tfidf_df$label))


############################################################
# 6. Naive Bayes Model
############################################################

nb_grid <- expand.grid(
  laplace = c(0, 1),
  usekernel = c(TRUE, FALSE),
  adjust = c(1, 1.5, 2)
)

nb_model <- train(
  label ~ .,
  data = tr_ta_df,
  method = "naive_bayes",
  tuneGrid = nb_grid,
  trControl = trainControl(method = "cv", number = 10)
)

nb_model

nb_pred <- predict(nb_model, tes_ta_df)
confusionMatrix(nb_pred, tes_ta_df$label, positive = "1")


############################################################
# 7. Support Vector Machine (Radial Kernel)
############################################################

svm_grid <- expand.grid(
  C = c(0.25, 0.5, 1, 2),
  sigma = c(0.01, 0.025, 0.05, 0.1)
)

svm_model <- train(
  label ~ .,
  data = tr_ta_df,
  method = "svmRadial",
  preProcess = c("center", "scale"),
  tuneGrid = svm_grid,
  trControl = trainControl(method = "cv", number = 10)
)

svm_model

svm_pred <- predict(svm_model, tes_ta_df)
confusionMatrix(svm_pred, tes_ta_df$label, positive = "1")
