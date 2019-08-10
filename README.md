# LFS
codes for cleaning Labor Force Survey

## WORKFLOW
- Rename .sav files and convert to .csv (Original file names contain space) **LFS_cleanscript.R**
- Rename columns to make it consistent within a year (Column names are mostly consistent within a year) **colname.R**
- Merge quarterly data to year data **colname.R**
- Filter individuals under 15 out (To reduce RAM's load) **filterage.R**
- Delete variables that NSO mistakenly supplied (To reduce RAM's load) **selectvar.R**
- Rename columns by year **LFS_outputdta.R**
- Select only necessary variables (To reduce the workload of stata) **LFS_outputdta.R**
- Merge year data from 2001-2018 and output as .dta **LFS_outputdta.R**

## FILES
- LFS_cleanscript.R : add year and quarter column, remove space in .sav file names
- colname.R : rename columns of quarterly data and merge by year *Codes here can be improved with for loops and automated*
- filterage.R : remove individuals under 15 since they are not asked about occupation
- selectvar.R : delete variables after 'quarter'
- LFS_outputdta.R : *Codes here can be automated*

## ISSUES
- No month data for LFS 2003q1 but this is negligible (for now) since there is no policy change during 2003q1
