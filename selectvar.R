# ==============================================================================
# This program adds year and quarter to existing tables, output as csv
# details     - Delete variables that NSO mistakenly supplied 
#               (To reduce RAM's load)
# input       - LFS_20XX.csv
# output      - LFS_20XX_selected.csv
# Last update - 3/3/2021
# ==============================================================================

rm(list = ls(all.names = TRUE))
setwd("C:\\Users\\81804\\Desktop\\Data\\LFS")

library(tidyverse)

# ==============================================================================

datalist <- list.files(pattern = "LFS_[12][09][019][0123456789].csv",
                 full.names = TRUE)[-c(1:8)]

# datalist = list.files(path = "/Data/LFS/",
#                       pattern = "above15.csv",
#                       full.names = TRUE
#                       )

allcol = list()

#The following line may take some time to run
for (i in 1:length(datalist)) {
  data = read.csv(datalist[i], row.names = 1)
  allcol[[i]] = colnames(data)
  message = paste0("Got colname of data no.", i)
  print(message)
  rm(data, message)
}

# Delete all variables after "quarter", the new variable I added
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
  outputname = paste0("LFS_", year, "_selected.csv")
  write.csv(newdata, file = outputname)
  message = paste0("Successfully output data no.", i)
  print(message)
  rm(x, data, newdata, year, outputname, message, i)
}
