# LFS
codes for cleaning Labor Force Survey

## WORKFLOW
- Rename .sav files and convert to .csv (Original file names contain space) **LFS_cleanscript.R**
- Rename columns to make it consistent within a year (Column names are mostly consistent within a year) **colname.R**
- Merge quarterly data to year data **colname.R**
- Filter individuals under 15 out (To reduce RAM's load) **filterage.R**
- Delete variables that NSO mistakenly supplied (To reduce RAM's load) **selectvar.R**
- Make column names consistent across years **LFS_outputdta.R**
- Select only necessary variables (To reduce the workload of stata) **LFS_outputdta.R**
- Recode industry variable according to the concordance table (see below) **LFS_outputdta.R**
- Merge year data from 2001-2018 and output as .dta **LFS_outputdta.R**

## INDUSTRY CONCORDANCE
| LFS        | industry code system         | Notes  |
| ------------- |:-------------:| -----|
| 2001-2010      | ISIC Rev.3.0 |  |
| 2011     | *ambiguous*      |   First 4 digits of TSIC 2009 |
| 2012-2018 | TSIC 2009      |    |

- First, I converted TSIC to ISIC using the [original concordance table](http://statstd.nso.go.th/classification/download.aspx) between ISIC Rev.3.0 and TSIC 2009.
- Based on ISIC, I classified the occupations into 17 one-digit industry levels.
- Next, I combined B (fishery) to A (agriculture), K (real estate) to F (construction) and Q (international organization) to L (public service)

#### Notes
- 98100 and 98200 of TSIC are newly established and the official concordance table does not provide any match. Since they are classified in the one-digit level that is equivalent to P of ISIC, I also classified them as P. 
- No description available: 1599, 3999, 5299, 9304, 47799. I recoded them as NA.
- Some correspondences are deleted to avoid one to many matches. The edited concordance table is uploaded in this repository.

| Industry     | Description  |       
| -----------|-------------|
| A| Agricultural and fishery |
|C|Mining|
|D|Manufacturing|
|E|Electricity|
|F|Construction and real estate|
|G|Retail|
|H|Hotel & restaurant|
|I|Transportation|
|J|Finance|
|L|Public & international organization|
|M|Education|
|N|Healthcare|
|O|Social service|
|P|Domestic|

For details see **LFS_concordance.xlsx**\
Source:\
[Description](http://statstd.nso.go.th/classification/search.aspx?class=1&act=change) of every industry code\

## FILES
- LFS_cleanscript.R : add year and quarter column, remove space in .sav file names
- colname.R : rename columns of quarterly data and merge by year *Codes here can be improved with for loops and automated*
- filterage.R : remove individuals under 15 since they are not asked about occupation
- selectvar.R : delete variables after 'quarter' or 'MONTH' (in thecase of year 2003)
- LFS_outputdta.R : *Codes here can be automated*

## ISSUES
- No month data for LFS 2003q1 but this is negligible (for now) since there is no policy change during 2003q1