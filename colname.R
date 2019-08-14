#===========================================================================
# This program rename columns and merge quarterly data together
# last update - 8/14/2019
# input       - .csv quarterly data 1993-2018
# output      - annual LFS
#===========================================================================

rm(list = ls(all.names = TRUE))
setwd("/Data/LFS")

library(tidyverse)

# get base column from the 1st quarter
fileq1= list.files("/Data/LFS/rawcsv", 
                 pattern = "_Q1.csv", full.names = TRUE)

allcol = list()

#The following line may take some time to run
for (i in 1:length(fileq1)) {
  data = read.csv(fileq1[i], row.names = 1)
  allcol[[i]] = colnames(data)
  message = paste0("Got colname of data no.", i)
  print(message)
  rm(data, message, i)
}

# write a function to check which year to change

# Change for every year
for (i in 1998:2018){
  pat = paste0("LFS_", i,"_Q[1234].csv")
  filelist = list.files("/Data/LFS/rawcsv",
                        pattern = pat)
  temp = lapply(filelist, read.csv, row.names=1)
  if(i==2009){
    temp[[3]] = rename(temp[[3]],
                           MEMBERS = MEMBERS_,
                           AMOUMT = AMOUNT,
                           WEIGHT = Weight
    )
    temp[[4]] = rename(temp[[4]],
                           MEMBERS = MEMBERS_,
                           AMOUMT = AMOUNT,
                           WEIGHT = Weight
    )
    msg = paste0("Renamed var for year ", i)
    print(msg)
  } else if(i==2011){
    temp[[4]] = rename(temp[[4]],
                        RETURN =  RETURN_
                        )
    msg = paste0("Renamed var for year ", i)
    print(msg)
  } else if(i==2012){
    temp[[4]] = rename(temp[[4]],
                      MEMBERS =  MEMBERS_)
    msg = paste0("Renamed var for year ", i)
    print(msg)
    } else if(i==2016){
    temp[[2]] = rename(temp[[2]], 
                       RETURN_ = RETURN)
    msg = paste0("Renamed var for year ", i)
    print(msg)
  }
  else{
    msg = paste0("Skip renaming for year ", i)
    print(msg)
  }
  yearlyLFS = bind_rows(temp)
  outputname = paste0("LFS_", i, ".csv")
  write.csv(yearlyLFS, file = outputname)
  msg2 = paste0("Binded rows for year", i)
  print(msg2)
  rm(pat, filelist, temp, yearlyLFS, outputname, msg, msg2, i)
}




