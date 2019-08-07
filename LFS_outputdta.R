#########################################
#select variables for LFS basic analysis#
#########################################

#What this script does:
# 1 select only necessary variables for LFS basic analysis
# 2 recompute dailywage to use in the basic analysis
# 3 drop samples with no wage data available 
#   (i.e. employer, people helping family business)

#compute daily wage (draft)
#If WAGE_TYPE=1, use AMOUMT*8. 
#If WAGE_TYPE=2, use AMOUMT.
#If WAGE_TYPE=3, use AMOUMT/7.
#If WAGE_TYPE ==4, use APPROX/30. 
#If WAGE_TYPE=5|6, use NA.
#If WAGE_TYPE=7, use 0.

install.packages("dplyr")
library(dplyr)

file = list.files(path = "T:/Thesis_Data/LFS_clean/LFS_clean/",
                  "_selected.csv",
                  full.names = TRUE) #This is LFS by year

#get col names ##################################
collist = list()

for (i in 1:length(file)) {
  temp = read.csv(file[i], row.names = 1)
  collist[[i]] = colnames(temp)
}

# check variable names ##########################

checkvar = function(v){
  for (i in 1:length(collist)) {
    x = v %in% collist[[i]]
    if (x == FALSE) {
      instruc = paste0("Change variable to ",v, " for year")
      print(paste0(instruc, " ", i+2000))}
  }
}

varneed = list("year", "quarter", "CWT", "SEX", "AGE",
               "STATUS", "INDUS", "SIZE_", "OCCUP",
               "RE_ED",
               "WAGE_TYPE", "AMOUNT", "APPROX",
               "RE_WK")

for (i in 1: length(varneed)) {
  checkvar(varneed[[i]])
}

# OUTPUT:
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

# rename ######################################################################## 

# 2001 - 2003
for (i in 1:3) {
  data = read.csv(file[i], row.names = 1)
  newdata = rename(data,
                   CWT = CWD,
                   AMOUNT = AMOUMT)
  outputname = paste0("LFS_",i+2000, "_correctvar.csv")
  write.csv(newdata, file = outputname)
}

#2004-2009
for (i in c(4,5,8,9)) {
  data = read.csv(file[i], row.names = 1)
  newdata = rename(data,
                   AMOUNT = AMOUMT)
  outputname = paste0("LFS_",i+2000, "_correctvar.csv")
  write.csv(newdata, file = outputname)
}

?gctorture
gctorture(on=FALSE)

#2006-2007
for (i in 6:7) {
  data = read.csv(file[i], row.names = 1)
  newdata = rename(data,
                   RE_WK = RE_MK,
                   AMOUNT = AMOUMT)
  outputname = paste0("LFS_",i+2000, "_correctvar.csv")
  write.csv(newdata, file = outputname)
}

library(haven)

file_ana = list.files("T:/Thesis_Data/LFS_analysis",
                      pattern = "_ana.csv",
                      full.names = TRUE)

allLFS_ana = lapply(file_ana, read.csv, row.names=1)
LFS_all_ana = bind_rows(allLFS_ana)

LFS_all_ana$matchid = paste0(LFS_all_ana$CWT,
                             LFS_all_ana$year,
                             LFS_all_ana$quarter
)

head(LFS_all_ana)

write_dta(LFS_all_ana, 
          path = "T:/Thesis_Data/LFS_analysis/LFS_all_ana.dta")

getRversion()

rm(temp)

# 2013
for (i in 13:13) {
  data = read.csv(file[i], row.names = 1)
  newdata = rename(data,
                   STATUS = status,
                   INDUS = indus)
  outputname = paste0("LFS_",i+2000, "_correctvar.csv")
  write.csv(newdata, file = outputname)
}

# no need to change: 10,11,12, 14, 15, 16, 17, 18
for (i in c(10,11,12, 14, 15, 16, 17, 18)) {
  data = read.csv(file[i], row.names = 1)
  newdata = data
  outputname = paste0("LFS_",i+2000, "_correctvar.csv")
  write.csv(newdata, file = outputname)
}

# write function

LFSana = function(path){
  input = read.csv(path, row.names = 1)
  data = select(input, 
                year, quarter, CWT,
                SEX, AGE,
                STATUS,
                INDUS,
                RE_ED,
                WAGE_TYPE, AMOUNT, APPROX
  )
  data$dailywage = ifelse(data$WAGE_TYPE == 1, data$AMOUNT * 8, 
                          ifelse(data$WAGE_TYPE == 2, data$AMOUNT,
                                 ifelse(data$WAGE_TYPE == 3, data$AMOUNT / 7,
                                        ifelse(data$WAGE_TYPE == 4, data$APPROX /30,
                                               ifelse(data$WAGE_TYPE == 7, 0, NA)
                                        )
                                 )
                          )
  )
  data_out = select(data[!is.na(data$dailywage),],
                    -c(AMOUNT, APPROX))
  year = data_out$year[1]
  outputname = paste0("LFS_", year, "_ana.csv")
  write.csv(data_out, file = outputname)
}

file_correctvar = list.files(path = "T:/Thesis_Data/LFS_analysis",
                             pattern = "_correctvar.csv",
                             full.names = TRUE)

for (i in 1:length(file_correctvar)) {
  LFSana(file_correctvar[i])
}