# Airline Customer Segmentation

## Business Problem
The objective of this project was to segment airline customers based on their travel behavior, loyalty metrics, and engagement attributes. The goal was to identify distinct customer groups that could support targeted marketing, loyalty program design, and differentiated service strategies.

## Data Overview
- Dataset: East–West Airlines customer data
- Observations: Customer-level frequent flyer records
- Key Variables:
  - Flight activity: Flight miles, flight transactions
  - Loyalty metrics: Bonus miles, bonus transactions, award usage
  - Engagement indicators: Days since enrollment, qualifying miles
- Data Preparation:
  - Customer identifiers removed
  - Variables normalized prior to distance-based clustering

## Methodology
Two unsupervised learning approaches were applied and compared:

### 1. Hierarchical Clustering
- Distance metric: Euclidean distance
- Linkage method: Ward’s method
- Dendrogram analysis used to assess cluster structure
- Final solution selected with six clusters

### 2. K-Means Clustering
- Performed on normalized data
- Number of clusters selected using the elbow method
- Multiple random starts used to improve solution stability

### Cluster Validation
- A stability test was conducted by removing 5% of observations at random
- Both hierarchical and k-means clustering were re-estimated
- Cluster profiles remained largely consistent, indicating robust segmentation

## Key Insights
- Clear differentiation emerged between high-engagement frequent flyers and low-activity customers
- Certain clusters exhibited high bonus mile accumulation but relatively low flight activity
- Long-tenured customers showed heterogeneous engagement patterns
- Similar cluster characteristics were observed across both clustering techniques

## Business Recommendations
- Design premium loyalty offerings for high-value, high-engagement segments
- Use targeted promotions to activate low-activity but long-tenured customers
- Align marketing spend with clusters demonstrating high award redemption potential
- Periodically re-run clustering to capture shifts in travel behavior

## Tools Used
- R
- Libraries: tidyverse, dplyr, ggdendro

