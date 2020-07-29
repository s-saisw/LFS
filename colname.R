#===========================================================================
# This program rename columns and merge quarterly data together
# last update - 8/14/2019
# input       - .csv quarterly data 1993-2018
# output      - annual LFS
#===========================================================================

rm(list = ls(all.names = TRUE))
setwd("/Data/LFS")

library(tidyverse)

# =====================================================================================

for (i in 1998:2018){
  pat = paste0("LFS_", i, "_Q[1234].csv")
  filelist = list.files("/Data/LFS/rawcsv", pattern = pat)
  collist = list()
  for (j in 1:length(filelist)) {
    data = read.csv(filelist[j], row.names = 1)
    collist[[j]] = colnames(data)
  }
  for (k in 2:4){
    detail = setdiff(union(collist[1],collist[k]), 
                     intersect(collist[1],collist[k])
                     )
    x = length(detail)
    if(x == 0){
      msg = paste0("No need to change for year", i, "quarter", k)
      print(msg)
    }
    else {
      msg = paste0("Warning for year", i, "quarter", k, "as follows")
      print(msg)
      print(detail)
    }
  }
  }

# =====================================================================================

for (i in 1:n) {
  data = read.csv(fileq1[i], row.names = 1)
  allcol[[i]] = colnames(data)
  message = paste0("Got colname of data no.", i)
  print(message)
  rm(data, message, i)
}

allcol = list()

#The following line may take some time to run
for (i in 1:length(fileq1)) {
  data = read.csv(fileq1[i], row.names = 1)
  allcol[[i]] = colnames(data)
  message = paste0("Got colname of data no.", i)
  print(message)
  rm(data, message, i)
}

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