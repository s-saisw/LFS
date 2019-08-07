# LFS
codes for cleaning Labor Force Survey

## WORKFLOW
- Rename .sav files and convert to .csv (Original file names contain space) **LFS_cleanscript.R**
- Rename columns to make it consistent within a year (Column names are mostly consistent within a year) **colname.R**
- Merge quarterly data to year data **colname.R**
- Filter individuals under 15 out (To reduce RAM's load) **filterage.R**
- Delete variables that NSO mistakenly supplied (To reduce RAM's load) **selectvar.R**
- Rename columns by year **LFS_outputdta.R**
- Select only necessary variables (To reduce the workload of stata)
- Merge year data from 2001-2018 and output as .dta

## FILES
- LFS_cleanscript.R : add year and quarter column, remove space in .sav file names
- colname.R : rename columns of quarterly data and merge by year *Codes here can be improved with for loops and automated*
- filterage.R : remove individuals under 15 since they are not asked about occupation
- selectvar.R : delete variables after 'quarter'
- LFS_outputdta.R : rename columns by year. This program requires a lot of RAM and may take longer than 20 minutes for 4GB RAM. *Codes here can be automated*
