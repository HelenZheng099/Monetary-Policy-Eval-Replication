rename A cname
rename B year
rename C it_intro
rename D ycpi
drop E F G
drop in 1
label variable cname "CountryName"
label variable ycpi "CPI Inflation"

**it = 1: countries which adopted the inflation targeting policy during 1985 to 2000
gen it = 0
replace it =1 if cname=="Australia" | cname== "Canada"| cname== "New Zealand" | cname== "Sweden" | cname== "United Kingdom" | cname=="Finland" | cname=="Spain"

keep if year>=1985
gen period2=0

destring year, replace
destring ycpi, replace


**period2 = 1: pre policy period
replace period2 = 1 if cname=="Australia" & year>=1985 & year<1994
replace period2 = 1 if cname=="Canada" & year>=1985 & year<1991
replace period2 = 1 if cname=="Finland" & year>=1985 & year<1993
replace period2 = 1 if cname=="New Zealand" & year>=1985 & year<1990
replace period2 = 1 if cname=="Spain" & year>=1985 & year<1995
replace period2 = 1 if cname=="Sweden" & year>=1985 & year<1994
replace period2 = 1 if cname=="United Kingdom" & year>=1985 & year<1992
replace period2 = 1 if cname=="United States of America" & year>=1985 & year<1993
replace period2 = 1 if cname=="Japan" & year>=1985 & year<1993
replace period2 = 1 if cname=="Denmark" & year>=1985 & year<1993
replace period2 = 1 if cname=="Austria" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Belgium" & year>=1985 & year<1993 
replace period2 = 1 if cname=="France" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Germany" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Ireland" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Italy" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Netherlands" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Portugal" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Norway" & year>=1985 & year<1993
replace period2 = 1 if cname=="Switzerland" & year>=1985 & year<1993

**period2 =2: post policy period
replace period2 = 2 if cname=="Australia" & year>=1992 & year<2001
replace period2 = 2 if cname=="Canada" & year>=1994 & year<2001
replace period2 = 2 if cname=="Finland" & year>=1994 & year<1998
replace period2 = 2 if cname=="New Zealand" & year>=1990 & year<2001
replace period2 = 2 if cname=="Spain" & year>=1995 & year<1998
replace period2 = 2 if cname=="Sweden" & year>=1995 & year<2001
replace period2 = 2 if cname=="United Kingdom" & year>=1993& year<2001
replace period2 = 2 if cname=="United States of America" & year>=1993 & year<2001
replace period2 = 2 if cname=="Japan" & year>=1993 & year<2001
replace period2 = 2 if cname=="Denmark" & year>=1993 & year<2001
replace period2 = 2 if cname=="Austria" & year>=1993 & year<1998 
replace period2 = 2 if cname=="Belgium" & year>=1993 & year<1998
replace period2 = 2 if cname=="France" & year>=1993 & year<1998
replace period2 = 2 if cname=="Germany" & year>=1993 & year<1998
replace period2 = 2 if cname=="Ireland" & year>=1993 & year<1998
replace period2 = 2 if cname=="Italy" & year>=1993 & year<1998
replace period2 = 2 if cname=="Netherlands" & year>=1993 & year<1998
replace period2 = 2 if cname=="Portugal" & year>=1993 & year<1998
replace period2 = 2 if cname=="Norway" & year>=1993 & year<2000
replace period2 = 2 if cname=="Switzerland" & year>=1993 & year<1999


tab period2
drop if period2==0
collapse (mean) ycpi it, by (cname period2)
tab period2

encode cname, gen(cty)

xtset cty period2

by cty: gen dycpi=ycpi-l.ycpi

**Model1: Xpost - Xpre = a + bDummy + e
reg dycpi it, robust 
estimates store m1, title(Model 1)
**Model2: Xpost - Xpre = a + bDummy + cXpre + e
reg dycpi it l.ycpi, robust
estimates store m2, title(Model 2)

esttab m1 m2, cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons constant) stats(r2 df_r N, fmt(3 2 0) labels("R-squared" "Degrees of freedom" "Number of obs"))



***Extend the second period from 2000 to 2018
rename A cname
rename B year
rename C it_intro
rename D ycpi
drop E F G
drop in 1

**it = 1: countries adopted the inflation targeting policy during 1985 to 2000
gen it = 0
replace it =1 if cname=="Australia" | cname== "Canada"| cname== "New Zealand" | cname== "Sweden" | cname== "United Kingdom" | cname=="Finland" | cname=="Spain"

keep if year>=1985
gen period2=0

destring year, replace
destring ycpi, replace

**period2 = 1: pre policy period
replace period2 = 1 if cname=="Australia" & year>=1985 & year<1994
replace period2 = 1 if cname=="Canada" & year>=1985 & year<1991
replace period2 = 1 if cname=="Finland" & year>=1985 & year<1993
replace period2 = 1 if cname=="New Zealand" & year>=1985 & year<1990
replace period2 = 1 if cname=="Spain" & year>=1985 & year<1995
replace period2 = 1 if cname=="Sweden" & year>=1985 & year<1994
replace period2 = 1 if cname=="United Kingdom" & year>=1985 & year<1992
replace period2 = 1 if cname=="United States of America" & year>=1985 & year<1993
replace period2 = 1 if cname=="Japan" & year>=1985 & year<1993
replace period2 = 1 if cname=="Denmark" & year>=1985 & year<1993
replace period2 = 1 if cname=="Austria" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Belgium" & year>=1985 & year<1993 
replace period2 = 1 if cname=="France" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Germany" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Ireland" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Italy" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Netherlands" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Portugal" & year>=1985 & year<1993 
replace period2 = 1 if cname=="Norway" & year>=1985 & year<1993
replace period2 = 1 if cname=="Switzerland" & year>=1985 & year<1993

**period2 =2: post policy period
replace period2 = 2 if cname=="Australia" & year>=1992 & year<=2018
replace period2 = 2 if cname=="Canada" & year>=1994 & year<=2018
replace period2 = 2 if cname=="Finland" & year>=1994 & year<=2018
replace period2 = 2 if cname=="New Zealand" & year>=1990 & year<=2018
replace period2 = 2 if cname=="Spain" & year>=1995 & year<=2018
replace period2 = 2 if cname=="Sweden" & year>=1995 & year<=2018
replace period2 = 2 if cname=="United Kingdom" & year>=1993& year<=2018
replace period2 = 2 if cname=="United States of America" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Japan" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Denmark" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Austria" & year>=1993 & year<=2018 
replace period2 = 2 if cname=="Belgium" & year>=1993 & year<=2018
replace period2 = 2 if cname=="France" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Germany" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Ireland" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Italy" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Netherlands" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Portugal" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Norway" & year>=1993 & year<=2018
replace period2 = 2 if cname=="Switzerland" & year>=1993 & year<=2018



tab period2
drop if period2==0
collapse (mean) ycpi it, by (cname period2)
tab period2

encode cname, gen(cty)

xtset cty period2

by cty: gen dycpi=ycpi-l.ycpi

**Model1: Xpost - Xpre = a + bDummy + e
reg dycpi it, robust 
estimates store m1, title(Model 1)
**Model2: Xpost - Xpre = a + bDummy + cXpre + e
reg dycpi it l.ycpi, robust
estimates store m2, title(Model 2)


esttab m1 m2, cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons constant) stats(r2 df_r N, fmt(3 2 0) labels("R-squared" "Degrees of freedom" "Number of obs"))








