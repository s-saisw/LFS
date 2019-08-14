# ==============================================================================
# This program adds year and quarter to existing tables, output as csv
# details     - remove space in .sav file names
#             - write two new functions for Q and R
#             - process by quarter to reduce RAM's load
# input       - raw .sav files
# output      - raw .csv files
# Last update - 8/14/2019
# ==============================================================================

rm(list = ls(all.names = TRUE))
setwd("/Data/LFS")1

library(dplyr)

# ==============================================================================

datalist = list.files(path = "/Data/LFS/",
                      pattern = "above15.csv",
                      full.names = TRUE
                      )

allcol = list()

#The following line may take some time to run
for (i in 1:length(datalist)) {
  data = read.csv(datalist[i], row.names = 1)
  allcol[[i]] = colnames(data)
  message = paste0("Got colname of data no.", i)
  print(message)
  rm(data, message)
}

# For year 2003, MONTH is missing for only the first quarter.
# Therefore, we delete everything after MONTH instead
# Order of variables matters too much. Can be improved!


# The following line may take some time to run
for (i in 1:length(datalist)) {
  data = read.csv(datalist[i], row.names = 1)
  if (i==3){
    x= match("MONTH", allcol[[i]])
  }
  else {
    x= match("quarter", allcol[[i]])
  }
  newdata = select(data, c(1:x))
  year = newdata$year[1]
  outputname = paste0("LFS_", year, "_above15_selected.csv")
  write.csv(newdata, file = outputname)
  message = paste0("Successfully output data no.", i)
  print(message)
  rm(x, data, newdata, year, outputname, message, i)
}