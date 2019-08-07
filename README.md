# LFS
codes for cleaning Labor Force Survey

## WORKFLOW
- Rename .sav files and convert to .csv (Original file names contain space)
- Rename columns to make it consistent within a year (Column names are mostly consistent within a year) *Codes here can be improved with for loops and automated*
- Merge quarterly data to year data 
- Rename columns by year *Codes here can be automated*
- Select only necessary variables (To reduce the workload of stata)
- Merge year data from 2001-2018 and output as .dta

## FILES
- LFS_outputdta.R : rename columns by year. This program requires a lot of RAM and may take longer than 20 minutes for 4GB RAM.
