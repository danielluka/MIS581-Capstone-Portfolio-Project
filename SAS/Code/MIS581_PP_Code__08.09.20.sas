* define output destination *;
libname out '/folders/myfolders/data/';
* Import and convert CSV data *;
data mpower;
    length Country $100;
    infile '/folders/myfolders/data/Tobacco Prevalence MPOWER Final.csv' 
    dlm=',' 
    firstobs=2;
    input Country $ Year Monitor Protect Offer Warn Enforce Raise mass_media_campaigns MPOWER Tobacco_use_prevalence Tobacco_use_prevalence_Male Tobacco_use_prevalence_Female Cigarette_smoking_prevalence Cigarette_smoking_prevalence_M Cigarette_smoking_prevalence_F Tobacco_smoking_prevalence Tobacco_smoking_prevalence_M Tobacco_smoking_prevalence_F 
;
/* DESCRIPTIVE STATISTICS */
/* summary statistics and correlation matrix for continuous variables */
* define output destination *;
libname out '/folders/myfolders/data/';
* Import and convert CSV data *;
data mpower;
    length Country $100;
    infile '/folders/myfolders/data/Tobacco Prevalence MPOWER Final.csv' 
    dlm=',' 
    firstobs=2;
    input Country $ Year Monitor Protect Offer Warn Enforce Raise mass_media_campaigns MPOWER Tobacco_use_prevalence Tobacco_use_prevalence_Male Tobacco_use_prevalence_Female Cigarette_smoking_prevalence Cigarette_smoking_prevalence_M Cigarette_smoking_prevalence_F Tobacco_smoking_prevalence Tobacco_smoking_prevalence_M Tobacco_smoking_prevalence_F 
;
/* DESCRIPTIVE STATISTICS */
/* summary statistics and correlation matrix for continuous variables */
proc corr data = work.mpower;
/* exclude customer_id variable as it's unique and text */
var Year Monitor Protect Offer Warn Enforce Raise mass_media_campaigns MPOWER Tobacco_use_prevalence Cigarette_smoking_prevalence Tobacco_smoking_prevalence;
run;
/* detailed distribution statistics */
proc univariate data=work.mpower;
histogram Year Monitor Protect Offer Warn Enforce Raise mass_media_campaigns MPOWER Tobacco_use_prevalence Cigarette_smoking_prevalence Tobacco_smoking_prevalence / vaxislabel="Percent of Observations";
run;
/* PREDICTIVE STATISTICS */
/* regression for continuous */
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs monitor";
    model tobacco_use_prevalence = monitor;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs protect";
    model tobacco_use_prevalence = protect;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs offer";
    model tobacco_use_prevalence = offer;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs warn";
    model tobacco_use_prevalence = warn;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs enforce";
    model tobacco_use_prevalence = enforce;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs raise";
    model tobacco_use_prevalence = raise;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs mm";
    model tobacco_use_prevalence = mass_media_campaigns;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs MPOWER";
    model tobacco_use_prevalence = MPOWER;
run;
proc reg data=work.mpower ;
    title "Linear Regression use prevalence vs year monitor raise";
    model tobacco_use_prevalence = Year monitor raise;
run;
proc reg data=work.mpower ;
    title "Linear Regression MPOWER vs time";
    model MPOWER = Year;
run;
    
/* r squared analysis */
proc rsquare data=work.mpower;
title "r squared prevalence analysis";
    model tobacco_use_prevalence = Year Monitor Protect Offer Warn Enforce Raise mass_media_campaigns MPOWER;
run;
/* Save sas7bdat dataset to destination */
data out.mpower;
    set work.mpower;
run;