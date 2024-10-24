
%let dsn=sashelp.cars;
%let obs=5;
options mcompilenote=all;

%macro printtable;
proc print data=&dsn(obs=&obs);
run;
%mend printtable;

%printtable

options mcompilenote=none;

/*Macro parameters */
%macro printtable(dsn,obs);
proc print data=&dsn(obs=&obs);
run;
%mend printtable;

%printtable(sashelp.cars,5)
/* Problem 25.1
Use the data in the file athlete.dat. Write a macro with inputs(arguments): Data set name, Y, and X to
(i) Create comparative boxplots of a variables, Y, among the levels of variable X
(ii) Perform two-sample t-test comparing the mean of Y among the two levels of the variable X
Run the macro with:
a) Y = systolic blood pressure and X = sex
b) Y = diastolic blood pressure and X = sex
c) Y = systolic blood pressure and X = lifestyle
d) Y = diastolic blood pressure and X = lifestyle*/

goptions csymbol = black htext = 2
proc format;
value lsfmt 1 = 'Athletic' 2 = 'Sedentary';
value $sfmt 'M'="Male" 'F'= 'Female';
run;

data athlete;
infile '/home/u62293126/datasetssas/athletedat.txt';
input sbp 1-3 dbp 6-7 sex $ 10 ls 13;
label sbp = 'Systolic Blood Pressure'
      dbp = 'Diastolic Blood Pressure'
      ls = 'Lifestyle';
format ls lsfmt. sex $sfmt.;
run;

%macro boxt(data,y,x);
proc sort data = &data;
by &x;
run;

proc boxplot data = &data;  *for (i);
plot &y * &x / boxstyle=schematic; * for (ii);
run;

proc ttest data = &data;
class &x;
var &y;
run;

%mend boxt;

%boxt(athlete,sbp,sex);
%boxt(athlete,dbp,sex);
%boxt(athlete,sbp,ls);
%boxt(athlete,dbp,ls);


/* global and local x */

%Let make_name = 'Audi';
%Let type_name = 'Sports';
proc print data = sashelp.cars;
where make = &make_name and type = &type_name;
title "Sales as of &sysday, &sysdate9";
run;


%macro outer(x);
%inner (&x)
%put _user_;
*/%put _local_;
*/%put _global_;
%mend outer;

%macro inner(y);
  %let x=2;
  %let z=1;
  %put _user_;
  %mend inner;
  
 %let x=1; 
 %outer(&x)


/************************************************
* Conditional Processing in Open Code: Examples *
************************************************/

/* Starter program */

data sports;
    set sashelp.cars;
    where Type="Sports";
    AvgMPG=mean(MPG_City, MPG_Highway);
run;

title "Sports Cars";
proc print data=sports noobs;	
    var Make Model AvgMPG MSRP EngineSize;
run;
title;
proc sgplot data=sports;
    scatter x=MSRP y=EngineSize;
run;

/* Program with macro conditional processing */

data sports;
    set sashelp.cars;
    where Type="Sports";
    AvgMPG=mean(MPG_City, MPG_Highway);
run;

%if &syserr ne 0 %then %do;
    %put ERROR: The rest of the program will not execute;
%end;

%else %do;
title "Sports Cars";
proc print data=sports noobs;	
    var Make Model AvgMPG MSRP EngineSize;
run;
title;
proc sgplot data=sports;
    scatter x=MSRP y=EngineSize;
run;
%end;
/*conditioning example  */
%macro avgfuel(loc);
%if &loc= %then %do;
    %put ERROR: Provide a value for Origin.;
    %put ERROR- Valid values: Asia, Europe, USA;
    %return;
%end;

%else %if &loc=USA %then %do;
	data fuel_&loc;
		set sashelp.cars;
		where Origin="&loc";
		AvgMPG=mean(MPG_City, MPG_Highway);
		keep Make Model Type AvgMPG;
	run;
%end;

%else %do;
	data fuel_&loc;
		set sashelp.cars;
		where Origin="&loc";
		AvgKmL=mean(MPG_City, MPG_Highway)*.425;
		keep Make Model Type AvgKmL;
	run;
%end;

title1 "Fuel Efficiency";
title2 "Origin: &loc";
proc print data=fuel_&loc;
run;
title;
%mend avgfuel;

options mprint mlogic;
%avgfuel(Europe)

options nomprint nomlogic;

