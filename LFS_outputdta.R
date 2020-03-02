#=================================================================================
# This program selects only necessary variables for stata and renames for merge
# last update - 11/21/2019
# input       - _selected.csv annual data 2001-2018
# output      - _ana.csv annual data 2001-2018
# WORKFLOW    - get column names and store in a list
#             - write a function to check which column to rename
#             - rename (manually) and select only necessary variables
#             - merge and output as a single .dta file
#=================================================================================

library(dplyr)
library(haven)
library(tidyverse)

rm(list = ls(all.names = TRUE))
setwd("T:/Data/LFS")

# =============================================================================

file <- list.files(path = "/Data/LFS/",
                  "_selected.csv",
                  full.names = TRUE) #This is LFS by year

collist <- list()

for (i in 1:length(file)) {
  temp <- read.csv(file[i], row.names = 1)
  collist[[i]] <- colnames(temp)
  message <- paste0("Obtained colname of data no. ", i)
  print(message)
  rm(temp, message, i)
}

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

for (i in 1: length(file)){
  data = read.csv(file[i], row.names = 1)
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
  } else if (i==13){
    newdata = rename(data,
                     STATUS = status,
                     INDUS = indus,
                     SIZE_ = size,
                     MAIN_HR = main_hr,
                     OTHER_HR = other_hr,
                     TOTAL_HR = total_hr)
  } else {
    newdata = data
  }
  rm(data)
  msg1 = paste0("Successfully renamed data no.", i)
  print(msg1)
  output = select(newdata, 
                  year, quarter, CWT, MONTH,
                  SEX, AGE, MARITAL,
                  STATUS, INDUS, SIZE_, OCCUP,
                  RE_ED,
                  WAGE_TYPE, AMOUNT, APPROX,
                  RE_WK,
                  MAIN_HR, OTHER_HR, TOTAL_HR,
                  BONUS, OT, OTH_MONEY
                  )
  year = output$year[1]
  outputname = paste0("LFS_",year, "_ana.csv")
  write.csv(output, file = outputname)
  msg2 = paste0("Successfully output data no.", i)
  print(msg2)
  rm(newdata, output, outputname, msg1, msg2, i, year)
}

rm(collist, varneed, file)

# recode industry ==============================================================

concordance <- read_excel("LFS_concordance.xlsx") #1389 obs

ISIC <- concordance[,2] %>%
  as.matrix() %>%
  as.numeric()
TSIC <- concordance[,4] %>%
  as.matrix() %>%
  as.numeric()
LFS11 <- concordance[,5] %>%
  as.matrix() %>%
  substring(1, 4) %>%
  as.numeric()

newCat <- concordance[,8]

ISIC_match <- cbind(ISIC, newCat) %>%
  na.omit() %>%
  distinct() %>%
  rename(industry = newCategory) #295 unique codes

TSIC_match <- cbind(TSIC, newCat) %>%
  na.omit() %>%
  distinct() %>%
  rename(industry = newCategory) #1077 unique codes

LFS11_match <- cbind(LFS11, newCat) %>%
  na.omit %>%
  distinct() %>%
  rename(industry = newCategory) #439 unique codes

# check if there is one to many match
ISIC_match$dup <- duplicated(ISIC_match$ISIC)
TSIC_match$dup <- duplicated(TSIC_match$TSIC)
LFS11_match$dup <- duplicated(LFS11_match$LFS11)

ISIC_match[ISIC_match$dup == TRUE,]
TSIC_match[TSIC_match$dup == TRUE,]
LFS11_match[LFS11_match$dup == TRUE,]

# recode 2001-2010, 2012-2018

for (year in 2001:2010) {
  input <- paste0("LFS_", year, "_ana.csv")
  data <- read.csv(input, header = TRUE)
  data_indusRecode <- merge(data, ISIC_match,
                            by.x = "INDUS", by.y = "ISIC",
                            all.x = TRUE, all.y = FALSE)
  if (nrow(data) == nrow(data_indusRecode)) {
    outputname <- paste0("LFS_",year, "_indusRecode.csv")
    write.csv(data_indusRecode, file = outputname)
    msg <- paste0("output year ", year)
    print(msg)
    
  } else {
    msg <- paste0("error for year ", year)
    print(msg)
  }
  
  if (year == 2010) {
    rm(input, data, data_indusRecode, outputname, msg)
  }
}

for (year in 2011:2011) {
  input <- paste0("LFS_", year, "_ana.csv")
  data <- read.csv(input, header = TRUE)
  data_indusRecode <- merge(data, LFS11_match,
                            by.x = "INDUS", by.y = "LFS11",
                            all.x = TRUE, all.y = FALSE)
  if (nrow(data) == nrow(data_indusRecode)) {
    outputname <- paste0("LFS_",year, "_indusRecode.csv")
    write.csv(data_indusRecode, file = outputname)
    msg <- paste0("output year ", year)
    print(msg)
    
  } else {
    msg <- paste0("error for year ", year)
    print(msg)
  }
  
  if (year == 2011) {
    rm(input, data, data_indusRecode, outputname, msg)
  }
}

for (year in 2012:2018) {
  input <- paste0("LFS_", year, "_ana.csv")
  data <- read.csv(input, header = TRUE)
  data_indusRecode <- merge(data, TSIC_match,
                            by.x = "INDUS", by.y = "TSIC",
                            all.x = TRUE, all.y = FALSE)
  if (nrow(data) == nrow(data_indusRecode)) {
    outputname <- paste0("LFS_",year, "_indusRecode.csv")
    write.csv(data_indusRecode, file = outputname)
    msg <- paste0("output year ", year)
    print(msg)
    
  } else {
    msg <- paste0("error for year ", year)
    print(msg)
  }
  
  if (year == 2018) {
    rm(input, data, data_indusRecode, outputname, msg)
  }
}

# ==============================================================================

file_ana = list.files("/Data/LFS",
                      pattern = "_indusRecode.csv",
                      full.names = TRUE)

# This line may take some time to run
allLFS_ana = lapply(file_ana, read.csv, row.names=1)
LFS_all_ana = bind_rows(allLFS_ana)

write_dta(LFS_all_ana, 
          path = "/Data/LFS/LFS_all.dta")

rm(allLFS_ana, file_ana)