############################################################
# Airline Customer Segmentation
#
# Description:
# This script performs customer segmentation for an airline
# loyalty dataset using hierarchical clustering and k-means.
# The analysis includes normalization, cluster profiling,
# and a stability test using a reduced dataset.
#
# Methods:
# - Hierarchical Clustering (Ward.D)
# - K-Means Clustering
# - Elbow Method
# - Stability Test (5% data removal)
#
# Author: Armaan Singh Ahluwalia
############################################################


############################################################
# 1. Library Imports
############################################################

library(ggdendro)
library(tidyverse)
library(dplyr)


############################################################
# 2. Data Loading and Preparation
############################################################

set.seed(1947)

# Dataset expected in working directory
clus.df <- read.csv("EastWestAirlines_1.csv")

# Remove identifier variables
clus.df <- column_to_rownames(clus.df, "ID.")
clus.df$X <- NULL

str(clus.df)
summary(clus.df)


############################################################
# 3. Distance Matrix and Normalization
############################################################

# Pre-normalization distance
d <- dist(clus.df, method = "euclidean")

# Normalize variables
clus.df.norm <- scale(clus.df)

# Distance matrix on normalized data
d.norm <- dist(clus.df.norm, method = "euclidean")


############################################################
# 4. Hierarchical Clustering
############################################################

hcl_wd <- hclust(d.norm, method = "ward.D")
ggdendrogram(hcl_wd)

# Cut dendrogram into 6 clusters
memb <- cutree(hcl_wd, k = 6)

# Characterize hierarchical clusters
hclwd.meansHC <- data.frame(memb, clus.df) %>%
  group_by(memb) %>%
  summarize(
    BL  = mean(Balance),
    QM  = mean(Qual_miles),
    CC1 = mean(cc1_miles),
    CC2 = mean(cc2_miles),
    CC3 = mean(cc3_miles),
    BM  = mean(Bonus_miles),
    BT  = mean(Bonus_trans),
    FM  = mean(Flight_miles_12mo),
    FT  = mean(Flight_trans_12),
    DSC = mean(Days_since_enroll),
    AD  = mean(Award.)
  )

hclwd.meansHC


############################################################
# 5. K-Means Clustering
############################################################

kmclust <- kmeans(clus.df.norm, centers = 6, nstart = 25)

kmclust$size
kmclust$withinss
kmclust$centers

# Characterize k-means clusters
km.meanskm <- data.frame(kmclust$cluster, clus.df) %>%
  group_by(kmclust$cluster) %>%
  summarize(
    BL  = mean(Balance),
    QM  = mean(Qual_miles),
    CC1 = mean(cc1_miles),
    CC2 = mean(cc2_miles),
    CC3 = mean(cc3_miles),
    BM  = mean(Bonus_miles),
    BT  = mean(Bonus_trans),
    FM  = mean(Flight_miles_12mo),
    FT  = mean(Flight_trans_12),
    DSC = mean(Days_since_enroll),
    AD  = mean(Award.)
  )

km.meanskm


############################################################
# 6. Elbow Method for Optimal K
############################################################

elb <- numeric(15)

for (k in 1:15) {
  km_tmp <- kmeans(clus.df.norm, centers = k, nstart = 25)
  elb[k] <- km_tmp$tot.withinss
}

plot(
  1:15, elb,
  type = "b",
  xlab = "Number of Clusters (k)",
  ylab = "Total Within-Cluster Sum of Squares",
  main = "Elbow Method for Optimal Number of Clusters"
)


############################################################
# 7. Stability Test (Remove 5% of Data)
############################################################

set.seed(1947)

# Remove 5% of observations
clidx <- sample(1:nrow(clus.df), size = 0.95 * nrow(clus.df))
clus.df.small <- clus.df[clidx, ]

# Normalize reduced dataset
clus.df.small.norm <- scale(clus.df.small)

# Hierarchical clustering on reduced data
d.small <- dist(clus.df.small.norm, method = "euclidean")
hcl_wd_small <- hclust(d.small, method = "ward.D")

memb.small <- cutree(hcl_wd_small, k = 6)

# Characterize reduced hierarchical clusters
hclwd.means.small <- data.frame(memb.small, clus.df.small) %>%
  group_by(memb.small) %>%
  summarize(
    BL  = mean(Balance),
    QM  = mean(Qual_miles),
    CC1 = mean(cc1_miles),
    CC2 = mean(cc2_miles),
    CC3 = mean(cc3_miles),
    BM  = mean(Bonus_miles),
    BT  = mean(Bonus_trans),
    FM  = mean(Flight_miles_12mo),
    FT  = mean(Flight_trans_12),
    DSC = mean(Days_since_enroll),
    AD  = mean(Award.)
  )

hclwd.means.small


# K-means on reduced dataset
kmclust.small <- kmeans(clus.df.small.norm, centers = 6, nstart = 25)

km.means.small <- data.frame(kmclust.small$cluster, clus.df.small) %>%
  group_by(kmclust.small$cluster) %>%
  summarize(
    BL  = mean(Balance),
    QM  = mean(Qual_miles),
    CC1 = mean(cc1_miles),
    CC2 = mean(cc2_miles),
    CC3 = mean(cc3_miles),
    BM  = mean(Bonus_miles),
    BT  = mean(Bonus_trans),
    FM  = mean(Flight_miles_12mo),
    FT  = mean(Flight_trans_12),
    DSC = mean(Days_since_enroll),
    AD  = mean(Award.)
  )

km.means.small
