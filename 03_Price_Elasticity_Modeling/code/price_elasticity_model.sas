/*******************************************************
* Price Elasticity Modeling – SVEDKA Vodka
*
* Description:
* This program estimates demand models for SVEDKA vodka
* using linear regression and computes price elasticity
* of demand based on regression estimates.
*
* Author: Armaan Singh Ahluwalia
*******************************************************/


/*******************************************************
* 1. Data Import and Exploration
*******************************************************/

libname ass1 "C:\Users\PhotonUser\Downloads";

/* Import CSV file */
proc import out = ass1.svedka
    datafile = "svedka.csv"
    dbms = csv
    replace;
    getnames = yes;
    datarow = 2;
run;

/* Dataset structure */
proc contents data = ass1.svedka;
run;

/* Preview observations */
proc print data = ass1.svedka (obs = 10);
run;


/*******************************************************
* 2. Descriptive Statistics
*******************************************************/

/* Summary statistics */
proc means data = ass1.svedka maxdec = 2;
    var TotalSales PricePerUnit
        Mag News Outdoor Broad Print
        TotalMinusSales Marketshare;
run;

/* Frequency distributions */
proc freq data = ass1.svedka;
    tables BrandName Brand_ID Year Domestic Tier FirstIntro;
run;


/*******************************************************
* 3. Mean Values for Elasticity Calculation
*******************************************************/

proc means data = ass1.svedka mean;
    var TotalSales PricePerUnit;
    output out = means_all mean = / autoname;
run;


/*******************************************************
* 4. Regression Analysis
*******************************************************/

/* Baseline: Sales on Price */
proc reg data = ass1.svedka plots = none outest = linreg_final;
    model TotalSales = PricePerUnit;
run; quit;

/* Price + Advertising Specifications */
proc reg data = ass1.svedka plots = none;
    model TotalSales = PricePerUnit Mag;
run; quit;

proc reg data = ass1.svedka plots = none;
    model TotalSales = PricePerUnit Print;
run; quit;

proc reg data = ass1.svedka plots = none;
    model TotalSales = PricePerUnit News;
run; quit;

proc reg data = ass1.svedka plots = none;
    model TotalSales = PricePerUnit Outdoor Broad;
run; quit;

proc reg data = ass1.svedka plots = none;
    model TotalSales = PricePerUnit Print Outdoor Broad;
run; quit;


/*******************************************************
* 5. Price Elasticity Calculation
*******************************************************/

data elasticity;
    merge linreg_final (drop = _TYPE_)
          means_all (drop = _TYPE_);

    /* Price elasticity of demand */
    Elasticity_Price =
        PricePerUnit * (PricePerUnit_mean / TotalSales_mean);
run;

proc print data = elasticity;
run;


