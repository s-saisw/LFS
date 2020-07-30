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

# create household id ======================================

for (y in 4:18) {
  data <- read.csv(file_addhhid[y])
  unique(data$MONTH) %>% print()
}


file_addhhid <- list.files(pattern = "_ana.csv",
                          full.names = TRUE)

for (f in 4:18) {
  data <- read.csv(file_addhhid[f])
  month <- unique(data$MONTH)
  
  for (q in 1:length(month)) {
    prov <- data[data$MONTH==month[q],]$CWT %>%
      unique() 
    
    for (p in 1:length(prov)) {
      data.pq <- data[data$MONTH==month[q] & data$CWT == prov[p],]
      n <-  nrow(data.pq)
      hhno <- data.pq$HH_NO
      hhid <- rep(NA,n)
      hhid[1] <- 1
      
      for (i in 2:n) {
        if (hhno[i]==hhno[i-1]) {
          hhid[i] <- hhid[i-1]
        } else {
          hhid[i] <- hhid[i-1]+1
        }
      }
      
      data.pq$hhid <- hhid
      
      if (p == 1) {
        pdata <- data.pq
      } else if (p>1){
        pdata <- rbind.data.frame(pdata, data.pq) #rbind all provinces
      }
    }
    
    if (q==1) {
      ydata <- pdata
    } else if (q>1){
      ydata <- rbind.data.frame(ydata, pdata)
    }
  }
  
  year <- 2000+f
  outputname <- paste0("LFS_",year,"_hhid.csv")
  write.csv(ydata, file = outputname)
  
  msg <- paste("Output data of year", year)
  print(msg)
}

# recode industry ==========================================
concordance <- read.csv("TSIC_to_ISIC_edited.csv") %>%
  select(-c(oneDigit))

ISIC_match <- concordance %>%
  select(c(ISIC, bigGroup)) %>%
  na.omit() %>%
  distinct() %>%
  rename(indus.original = ISIC) %>%
  mutate(indus.original = as.numeric(indus.original)) #296 unique correspondence

LFS11_match <- concordance %>%
  select(c(LFS11, bigGroup))  %>%
  na.omit() %>%
  distinct() %>%
  rename(indus.original = LFS11) %>%
  mutate(indus.original = as.numeric(indus.original)) #441 unique correspondence

TSIC_match <- concordance %>%
  select(c(TSIC, bigGroup))  %>%
  na.omit() %>%
  distinct() %>%
  rename(indus.original = TSIC) %>%
  mutate(indus.original = as.numeric(indus.original))

# check if there is one to many match

ISIC_match$dup <- duplicated(ISIC_match$indus.original)
LFS11_match$dup <- duplicated(LFS11_match$indus.original)
TSIC_match$dup <- duplicated(TSIC_match$indus.original)

ISICerror <- ISIC_match[ISIC_match$dup == TRUE,] #0 errors
LFS11error <- LFS11_match[LFS11_match$dup == TRUE,] #0 errors
TSICerror <- TSIC_match[TSIC_match$dup == TRUE,] #0 errors

matchList <- list(ISIC_match, LFS11_match, TSIC_match)

# recode industry variable
for (year in 2004:2018) {
  input <- paste0("LFS_", year, "_hhid.csv")
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

file_recode <- list.files(pattern = "_indusRecode.csv",
                         full.names = TRUE)

# This line may take some time to run
LFS_all <- lapply(file_recode, read.csv, row.names=1) %>%
  bind_rows() %>%
  rename(industry = bigGroup) %>%
  select(-c(dup, X.1))

# Find pattern in industry data that could not be matched
errorData <- LFS_all[which(is.na(LFS_all$industry) == TRUE & 
                             is.na(LFS_all$INDUS) == FALSE), ]

table(errorData$INDUS)
# 1599  3999  5299  9999 47799 99999 
# 1     2    82  2699     1  2273 

write_dta(LFS_all, 
          path = "./LFS_all.dta")