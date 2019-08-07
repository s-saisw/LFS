# LFS
codes for cleaning Labor Force Survey

## WORKFLOW
- Rename .sav files and convert to .csv (Original file names contain space)
- Rename columns to make it consistent within a year (Column names are mostly consistent within a year) 
- Merge quarterly data to year data 
- Rename columns by year 
- Select only necessary variables (To reduce the workload of stata)
- Merge year data from 2001-2018 and output as .dta

## FILES
- LFS_cleanscript.R : add year and quarter column, remove space in .sav file names
- colname.R : rename columns of quarterly data and merge by year *Codes here can be improved with for loops and automated*
- LFS_outputdta.R : rename columns by year. This program requires a lot of RAM and may take longer than 20 minutes for 4GB RAM. *Codes here can be automated*
