# ==============================================================================
# This program adds year and quarter to existing tables, output as csv
# details     - remove space in .sav file names
#             - write two new functions for Q and R
#             - process by quarter to reduce RAM's load
# input       - raw .sav files
# output      - raw .csv files
# Last update - 8/7/2019
# ==============================================================================

library(dplyr)

datalist = list.files(path = "/Data/LFS/",
                      pattern = "above15.csv",
                      full.names = TRUE
                      )

#The following line may take some time to run
for (i in 1:length(datalist)) {
  data = read.csv(datalist[i], row.names = 1)
  year = data$year[1]
  assign(paste0("col_",year), colnames(data))
  message = paste0("Succesfully processed data no. ", i)
  print(message)
  rm(data, year, message)
}

allcol = list(col_2001, col_2002, col_2003, col_2004, col_2005, col_2006, 
              col_2007, col_2008, col_2009, col_2010, col_2011, col_2012, 
              col_2013, col_2014, col_2015, col_2016, col_2017, col_2018)

#The following line may take some time to run
for (i in 1:length(datalist)) {
  x= match("quarter", allcol[[i]])
  data = read.csv(datalist[i], row.names = 1)
  newdata = select(data, c(1:x))
  year = newdata$year[1]
  outputname = paste0("LFS_", year, "_above15_selected.csv")
  write.csv(newdata, file = outputname)
  message = paste0("Successfully output data no.", i)
  print(message)
  rm(x, data, newdata, year, outputname, message)
}
