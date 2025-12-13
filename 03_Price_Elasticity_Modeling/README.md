# Vodka Aggregate Demand Analysis and Elasticity Modeling using Linear Regression

## Business Problem
The objective of this project was to estimate the price elasticity of demand for SVEDKA vodka using aggregate sales data. The analysis was designed to quantify consumer price sensitivity and assess the role of advertising expenditures in driving sales, thereby supporting pricing and promotional strategy decisions.

## Data Overview
- Dataset: SVEDKA vodka sales and marketing data
- Observations: Aggregate market-level records
- Key Variables:
  - Demand: TotalSales
  - Price: PricePerUnit
  - Advertising: Magazine, Newspaper, Outdoor, Broadcast, Print
  - Market attributes: Market share, brand characteristics, time indicators
- Data Preparation:
  - Data imported into SAS and reviewed using summary statistics and frequency tables
  - Mean values computed to support elasticity calculation

## Methodology
A sequence of linear regression models was estimated to evaluate the relationship between sales, price, and advertising.

### Model Specification Strategy
- Baseline model: Sales regressed on price only
- Extended models: Sales regressed on price and alternative advertising variables
- Multiple advertising specifications were tested to assess robustness and avoid overfitting
- Final elasticity calculation was based on the price-only model for interpretability

### Elasticity Computation
Price elasticity of demand was computed using the standard point elasticity formula:

Elasticity = β_price × (Average Price / Average Sales)

where β_price is the estimated price coefficient from the regression model.

## Key Insights
- The estimated price coefficient was negative but of a very low magnitude close to 0, indicating a relatively inelastic relationship between price and sales
- Advertising variables showed mixed effects across specifications, with some such as Radio and TV showing matrial effects on increasing sales, whereas others such as Print and News not being as significant
- Price elasticity magnitude suggested that demand for vodka is not price-sensitive
- The results imply that advertising decisions have a material impact on total sales volume

## Business Recommendations
- Exploit the relatively inelastic demand and raise prices to boost margins, as demand is relatively unresponsive to price changes
- Invest heavily in TV and Radio advertising and use it strategically to complement pricing increases
- Periodically re-estimate elasticity as market conditions and competitive dynamics evolve

## Tools Used
- SAS
- Procedures: DATA step, PROC MEANS, PROC FREQ, PROC REG
