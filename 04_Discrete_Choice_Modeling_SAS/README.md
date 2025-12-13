# Mixed and Conditional Logit Models in SAS for Yoghurt Marketing Stretgy Development

## Business Problem
The objective of this project was to model consumer product choice behavior using panel data and discrete choice models. The analysis focuses on understanding how product attributes such as price, promotions, and in-store features influence brand selection, and how consumer preferences vary across individuals.

This type of modeling supports pricing strategy, promotion planning, and product positioning decisions.

## Data Overview
- Dataset: Panel data on consumer purchases of packaged food products
- Structure:
  - Panel dataset: weekly purchase decisions at the household level
  - Product dataset: list of available products
  - Product characteristics dataset: prices and promotional attributes
- Key Variables:
  - Choice indicator: bought (1 if product chosen, 0 otherwise)
  - Price
  - Promotional attributes: display, feature
  - Alternative-specific indicators
- Data Preparation:
  - Long format choice set constructed for each decision occasion
  - Alternative-specific intercepts created
  - Choice sets merged with panel purchase data

## Methodology
Both Conditional Logit and Mixed Logit models were estimated using `PROC MDC` in SAS.

### Conditional Logit Models
- Baseline model with alternative-specific intercepts
- Extended models including price and promotional variables
- Used to assess average preferences across consumers

### Mixed Logit Models
- Random coefficients specified for alternative-specific intercepts and price
- Simulation-based estimation to capture preference heterogeneity
- Compared against Conditional Logit to evaluate improvements in model fit

### Elasticity Analysis
- Own-price and cross-price elasticities computed using predicted choice probabilities
- Elasticities calculated at the individual choice-set level and averaged across observations

## Key Insights
- Price has a statistically significant negative effect on choice probability
- Promotional variables (display and feature) positively influence purchase likelihood
- Mixed Logit models capture substantial heterogeneity in brand preferences
- Cross-price elasticities indicate substitution patterns between products

## Business Recommendations
- Avoid uniform pricing strategies across products due to heterogeneous price sensitivity
- Use targeted promotions to shift demand among substitutable products
- Leverage elasticity estimates to anticipate demand responses to price changes
- Use mixed logit models for strategic decisions requiring individual-level insights

## Tools Used
- SAS
- Procedures: PROC MDC, PROC SQL, DATA step

