#=================================================================================
# This program selects only necessary variables for stata and renames for merge
# last update - 3/7/2020
# input       - _selected.csv annual data 2001-2018
# output      - _ana.csv annual data 2001-2018
# WORKFLOW    - get column names and store in a list
#             - write a function to check which column to rename
#             - rename (manually) and select only necessary variables
#             - merge and output as a single .dta file
#=================================================================================

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

library(readxl)
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
  rename(industry = newCategory,
         indus.original = ISIC) #295 unique codes

TSIC_match <- cbind(TSIC, newCat) %>%
  na.omit() %>%
  distinct() %>%
  rename(industry = newCategory,
         indus.original = TSIC) #1082 unique codes

LFS11_match <- cbind(LFS11, newCat) %>%
  na.omit %>%
  distinct() %>%
  rename(industry = newCategory,
         indus.original = LFS11) #440 unique codes

# check if there is one to many match
ISIC_match$dup <- duplicated(ISIC_match$indus.original)
TSIC_match$dup <- duplicated(TSIC_match$indus.original)
LFS11_match$dup <- duplicated(LFS11_match$indus.original)

ISIC_match[ISIC_match$dup == TRUE,]
LFS11_match[LFS11_match$dup == TRUE,]
TSIC_match[TSIC_match$dup == TRUE,]

matchList <- list(ISIC_match, LFS11_match, TSIC_match)

# recode 2001-2010, 2012-2018

for (year in 2001:2018) {
  input <- paste0("LFS_", year, "_ana.csv")
  data <- read.csv(input, header = TRUE)
  
  m <- ifelse(year <= 2010, 1,
              ifelse(year == 2011, 2, 3))
  
  data_indusRecode <- merge(data, matchList[[m]],
                            by.x = "INDUS", by.y = "indus.original",
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
LFS_all <- lapply(file_ana, read.csv, row.names=1) %>%
  bind_rows()

# Find pattern in industry data that could not be matched
errorData <- LFS_all[which(is.na(LFS_all$industry) == TRUE & 
                                 is.na(LFS_all$INDUS) == FALSE), ]


table(errorData$INDUS)
# 1599  3999  5299  8130  9304  9999 38221 47799 52214 58113 58122 58133 
# 2     7    86   149     1  3061     1     1   125     7     1    13 
# 58192 63990 64925 74101 74901 81300 96302 99999 
# 25    35   355   959   191  1622   229  2273 

# 1599  3999  5299  9304  9999 38221 47799 58113 58122 58133 58192 
# 2     7    86     1  3061     1     1     7     1    13    25 
# 63990 96302 99999 
# 35   229  2273 

# Issues
# no description available: 1599, 3999, 5299, 47799
# recode 9999, 99999 to NA

# Find if there is any jump in industry at 2010-2011, 2011-2012

jumpCheck <- function(x){
  jumpData <- LFS_all_ana[LFS_all_ana$industry == x,3] %>%
    table() %>%
    as.data.frame() %>%
    rename(year = ".")
  
  p <- plot(jumpData$year, jumpData$Freq)
  return(p)
}

jumpCheck(1) #2011-2012
jumpCheck(2) #ok
jumpCheck(3)
jumpCheck(4) #ok
jumpCheck(5) #2011-2012
jumpCheck(6) #2011-2012
jumpCheck(7)
jumpCheck(8) #2011-2012
jumpCheck(9) #2010-2011
jumpCheck(10) #2010-2011
jumpCheck(11) #ok
jumpCheck(12) #ok
jumpCheck(13) #2010-2011
jumpCheck(14)
jumpCheck(15)
jumpCheck(16) #ok
jumpCheck(17) #ok #too small can be combined with 13
jumpCheck(18) #ok

# output data
write_dta(LFS_all, 
          path = "/Data/LFS/LFS_all.dta")