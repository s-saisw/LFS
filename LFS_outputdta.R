#=================================================================================
# This program selects only necessary variables for stata and renames for merge
# last update - 7/28/2020
# input       - _selected.csv annual data 2001-2018
# output      - _ana.csv annual data 2001-2018
# WORKFLOW    - get column names and store in a list
#             - write a function to check which column to rename
#             - rename (manually) and select only necessary variables
#             - merge and output as a single .dta file
#=================================================================================

library(dplyr)
library(haven)

rm(list = ls(all.names = TRUE))
setwd("C:\\Users\\81804\\Desktop\\Data\\LFS")

# =============================================================================

file <- list.files(path = getwd(),
                   "_selected.csv",
                  full.names = TRUE) #This is LFS by year

collist <- list()

for (i in 1:length(file)) {
  temp = read.csv(file[i], row.names = 1)
  collist[[i]] = colnames(temp)
  message = paste0("Obtained colname of data no. ", i)
  print(message)
  rm(temp, message, i)
}

save(collist, file = "collist.Rdata")

# drop 2001-2002 because there is no HH no

# =============================================================================

checkvar = function(v){
  for (i in 1:length(collist)) {
    x = v %in% collist[[i]]
    if (x == FALSE) {
      originalvar = x
      instruc = paste0("Change variable to ",v, " for year")
      print(paste0(instruc, " ", i+2000))}
  }
}

varneed = list("year", "quarter", "CWT", "MONTH",
               "HH_NO", "MEMBERS",
               "SEX", "AGE", "MARITAL",
               "STATUS", "INDUS", "SIZE_", "OCCUP",
               "RE_ED",
               "WAGE_TYPE", "AMOUNT", "APPROX",
               "RE_WK",
               "MAIN_HR", "OTHER_HR", "TOTAL_HR",
               "BONUS", "OT", "OTH_MONEY")

for (i in 1: length(varneed)) {
  checkvar(varneed[[i]])
}

# [1] "Change variable to CWT for year 2001"
# [1] "Change variable to CWT for year 2002"
# [1] "Change variable to CWT for year 2003"
# [1] "Change variable to HH_NO for year 2001"
# [1] "Change variable to HH_NO for year 2002"
# [1] "Change variable to MEMBERS for year 2010"
# [1] "Change variable to MEMBERS for year 2013"
# [1] "Change variable to MEMBERS for year 2014"
# [1] "Change variable to MEMBERS for year 2015"
# [1] "Change variable to MEMBERS for year 2016"
# [1] "Change variable to MEMBERS for year 2017"
# [1] "Change variable to MEMBERS for year 2018"
# [1] "Change variable to STATUS for year 2013"
# [1] "Change variable to INDUS for year 2013"
# [1] "Change variable to SIZE_ for year 2013"
# [1] "Change variable to AMOUNT for year 2001"
# [1] "Change variable to AMOUNT for year 2002"
# [1] "Change variable to AMOUNT for year 2003"
# [1] "Change variable to AMOUNT for year 2004"
# [1] "Change variable to AMOUNT for year 2005"
# [1] "Change variable to AMOUNT for year 2006"
# [1] "Change variable to AMOUNT for year 2007"
# [1] "Change variable to AMOUNT for year 2008"
# [1] "Change variable to AMOUNT for year 2009"
# [1] "Change variable to RE_WK for year 2006"
# [1] "Change variable to RE_WK for year 2007"
# [1] "Change variable to MAIN_HR for year 2013"
# [1] "Change variable to OTHER_HR for year 2013"
# [1] "Change variable to TOTAL_HR for year 2013"

# =============================================================================

for (i in 3: length(file)){
  data <- read.csv(file[i], row.names = 1)
  if(i %in% 1:2){
    newdata = rename(data,
                     CWT = CWD,
                     AMOUNT = AMOUMT)
  }  else if (i == 3) {
    newdata = rename(data,
                     CWT = CWD,
                     AMOUNT = AMOUMT)
  } else if (i %in% c(4,5,8,9)){
    newdata = rename(data,
                     AMOUNT = AMOUMT)
  } else if (i %in% 6:7){
    newdata = rename(data,
                     RE_WK = RE_MK,
                     AMOUNT = AMOUMT)
  } else if (i==10) {
    newdata = rename(data,
                     MEMBERS = MEMBERS_)
  } else if (i==13){
    newdata = rename(data,
                     STATUS = status,
                     INDUS = indus,
                     SIZE_ = size,
                     MAIN_HR = main_hr,
                     OTHER_HR = other_hr,
                     TOTAL_HR = total_hr,
                     MEMBERS = MEMBERS_)
  } else if (i %in% 14:18){
    newdata = rename(data,
                     MEMBERS = MEMBERS_)
  } else {
    newdata = data
  }
  rm(data)
  msg1 <- paste0("Successfully renamed data no.", i)
  print(msg1)
  output <- select(newdata, 
                  year, quarter, CWT, MONTH,
                  HH_NO, MEMBERS,
                  SEX, AGE, MARITAL,
                  STATUS, INDUS, SIZE_, OCCUP,
                  RE_ED,
                  WAGE_TYPE, AMOUNT, APPROX,
                  RE_WK,
                  MAIN_HR, OTHER_HR, TOTAL_HR,
                  BONUS, OT, OTH_MONEY
                  )
  year <- output$year[1]
  outputname <- paste0("LFS_",year, "_ana.csv")
  write.csv(output, file = outputname)
  msg2 <- paste0("Successfully output data no.", i)
  print(msg2)
  rm(newdata, output, outputname, msg1, msg2, i, year)
}

# ==============================================================================

file_ana <- list.files(pattern = "_ana.csv",
                      full.names = TRUE)

# This line may take some time to run
allLFS_ana <- lapply(file_ana[3:18], read.csv, row.names=1)
LFS_all_ana <- bind_rows(allLFS_ana)

write_dta(LFS_all_ana, 
          path = "./LFS_all.dta")

rm(allLFS_ana, file_ana)
