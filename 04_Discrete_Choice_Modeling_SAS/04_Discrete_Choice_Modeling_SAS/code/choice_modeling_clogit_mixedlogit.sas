/**********************************************************
* Discrete Choice Modeling: Conditional and Mixed Logit
*
* Description:
* This program constructs choice sets from panel data and
* estimates conditional logit and mixed logit models using
* PROC MDC. Own- and cross-price elasticities are computed
* from predicted probabilities.
*
* Author: Armaan Singh Ahluwalia
**********************************************************/


/**********************************************************
* 1. Data Inspection
**********************************************************/

libname clp "C:\Users\PhotonUser\Downloads";

proc contents data = clp.panel_1; run;
proc contents data = clp.products_1; run;
proc contents data = clp.prodchars_1; run;


/**********************************************************
* 2. Product Identification and Choice Set Construction
**********************************************************/

proc sort data = clp.products_1;
by COLUPC;
run;

data choice;
set clp.products_1;
retain jid 0;
jid + 1;
run;

proc sort data = clp.prodchars_1;
by COLUPC;
run;

data choiceset;
merge choice clp.prodchars_1;
by COLUPC;
run;

proc sort data = choiceset;
by WEEK jid;
run;


/**********************************************************
* 3. Alternative-Specific Variables
**********************************************************/

data choiceset;
set choiceset;
J1 = (jid = 1);
J2 = (jid = 2);
J3 = (jid = 3);
J4 = (jid = 4);
J5 = (jid = 5);

LOWFAT = (FAT_CONTENT = "LOW FAT");
run;


/**********************************************************
* 4. Merge with Panel Decisions
**********************************************************/

proc sort data = clp.panel_1;
by WEEK PANID;
run;

data decision;
set clp.panel_1 (rename = (COLUPC = DCOLUPC));
CID = _N_;
run;

proc sql;
create table mdcready as
select d.*, c.*, (d.DCOLUPC = c.COLUPC) as bought
from decision as d
left join choiceset as c
on d.WEEK = c.WEEK;
quit;

proc sort data = mdcready;
by CID jid;
run;


/**********************************************************
* 5. Conditional Logit Models
**********************************************************/

/* Intercepts only */
proc mdc data = mdcready;
model bought = J1-J5 /
type = clogit choice = (jid 1 2 3 4 5 6);
id CID;
run;

/* Intercepts + Price */
proc mdc data = mdcready;
model bought = price J1-J5 /
type = clogit choice = (jid 1 2 3 4 5 6);
id CID;
run;

/* Intercepts + Price + Promotions */
proc mdc data = mdcready;
model bought = price J1-J5 display feature /
type = clogit choice = (jid 1 2 3 4 5 6);
id CID;
run;


/**********************************************************
* 6. Elasticity Computation
**********************************************************/

proc mdc data = mdcready outest = estimates;
model bought = price J1-J5 /
type = clogit choice = (jid 1 2 3 4 5 6);
id CID;
output out = pred p = prob;
run;

data _null_;
set estimates;
call symputx("beta_price", price);
run;

data probs;
set pred (keep = CID jid prob price);
run;

proc sql;
create table elas as
select a.CID, a.jid as alt_j, b.jid as alt_m,
       a.prob as p_j, b.prob as p_m,
       a.price as price_j, b.price as price_m
from probs as a inner join probs as b
on a.CID = b.CID;
quit;

data elasticities;
set elas;
beta_price = &beta_price.;

if alt_j = alt_m then
  elasticity = beta_price * price_j * (1 - p_j);
else
  elasticity = -beta_price * price_m * p_m;
run;

proc means data = elasticities noprint;
by alt_j alt_m;
var elasticity;
output out = elas_avg mean = avg_elasticity;
run;


/**********************************************************
* 7. Mixed Logit Models
**********************************************************/

libname cdc ".";

proc mdc data = cdcready nsimul = 200 maxiter = 200;
model bought = J1-J5 /
type = mixedlogit choice = (jid 1 2 3 4 5 6)
mixed = (normalparm = J1-J5);
id CID;
run;

proc mdc data = cdcready;
model bought = J1-J5 price /
type = mixedlogit choice = (jid 1 2 3 4 5 6)
mixed = (normalparm = J1-J5 price);
id CID;
run;

/* Comparison: Conditional Logit */
proc mdc data = cdcready;
model bought = J1-J5 price /
type = clogit choice = (jid 1 2 3 4 5 6);
id CID;
run;
