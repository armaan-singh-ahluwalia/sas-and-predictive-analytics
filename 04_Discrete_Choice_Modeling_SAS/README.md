# Mixed and Conditional Logit Models in SAS for Yogurt Marketing Strategy Development

## Business Problem
The objective of this project was to model consumer product choice behavior in the yogurt category using panel data and discrete choice models. The analysis focuses on understanding how product attributes—particularly price and in-store promotions—influence brand selection, and how consumer preferences vary across individuals.

This type of modeling supports pricing strategy, promotion planning, and competitive positioning decisions in categories characterized by frequent purchase and close substitutes.

## Data Overview
- Dataset: Panel data on consumer purchases of packaged yogurt products
- Structure:
  - Panel dataset: weekly purchase decisions at the household level
  - Product dataset: list of available products
  - Product characteristics dataset: prices and promotional attributes
- Key Variables:
  - Choice indicator: `bought` (1 if product chosen, 0 otherwise)
  - Price
  - Promotional attributes: display, feature
  - Alternative-specific indicators
- Data Preparation:
  - Long-format choice sets constructed for each decision occasion
  - Alternative-specific intercepts created for each product
  - Choice sets merged with panel purchase data to identify chosen alternatives

## Methodology
Both Conditional Logit and Mixed Logit models were estimated using `PROC MDC` in SAS to capture consumer choice behavior.

### Conditional Logit Models
- Baseline model with alternative-specific intercepts
- Extended models including price and promotional variables
- Used to estimate average preferences and overall price sensitivity across consumers

### Mixed Logit Models
- Random coefficients specified for alternative-specific intercepts and price
- Simulation-based estimation to capture heterogeneity in consumer preferences
- Compared against Conditional Logit models to assess improvements in model fit and behavioral realism

### Elasticity Analysis
- Own-price and cross-price elasticities computed using predicted choice probabilities
- Elasticities calculated at the individual choice-set level and averaged across observations
- Used to assess price sensitivity and substitution patterns among competing products

## Key Insights
- Price has a statistically significant negative effect on choice probability, indicating strong price sensitivity in the yogurt category.
- Promotional variables such as display and feature significantly increase purchase likelihood.
- Mixed Logit models reveal substantial heterogeneity in price sensitivity and brand preferences across consumers.
- Cross-price elasticities indicate strong substitution effects, reflecting low switching costs between competing yogurt products.

## Business Recommendations
- Given highly elastic demand, aggressive price increases are likely to result in meaningful volume and market share losses.
- Competitive pricing should remain a central strategic lever, particularly in price-sensitive segments.
- Promotions such as displays and features are effective tools for temporarily shifting demand but should be used to complement, not replace, competitive pricing.
- Pricing and promotion strategies should account for consumer heterogeneity and strong substitution effects rather than applying uniform actions across all products.
- Mixed Logit models should be preferred for strategic decisions where understanding individual-level response and substitution behavior is critical.

## Tools Used
- SAS
- Procedures: PROC MDC, PROC SQL, DATA step


