# =============================================================================
# This program filter individuals under 15 out
# details     - 2013 data has lower-case letter for column names. Rename first.
#             - filter those under 15 out
#             - ignore 1993-2001. Cutoff age was at 13 yo.
# input       - annual data (.csv)
# output      - _above15.csv
# Last update - 8/7/2019
# ==============================================================================

library(dplyr)

LFS_2013 = read.csv("/Data/LFS/LFS_2013.csv", 
                    row.names=1)

LFS_2013 = rename(LFS_2013,
                  REG =reg,
                  CWT = cwt,
                  AREA = area,
                  MONTH = mounth,
                  YR = yr,
                  HH_NO = hh_no,
                  MEMBERS_ = member,
                  LISTING = listing,
                  ENUM = enum,
                  SEX = sex,
                  AGE = age,
                  MARITAL = marital,
                  GRADE_A = grade_a,
                  GRADE_B = grade_b,
                  SUBJECT = subject,
                  LINE = line,
                  WK_7DAY = wk_7day,
                  RECEIVE = receive,
                  RETURN_ = return,
                  SEEKING = seeking,
                  OCCUP = occup,
                  FINDING = finding,
                  WAGE_TYPE = wage_ty,
                  AMOUNT = amount,
                  APPROX = approx,
                  BONUS = bonus,
                  OT = ot,
                  OTH_MONEY = oth_mon,
                  RE_WK = re_wk,
                  RE_ED = re_ed,
                  Weight = wgt)

write.csv(LFS_2013, file = "LFS_2013.csv") #replace the previous data

rm(LFS_2013) # remove 2013 data to reduce RAM's load

file= list.files("/Data/LFS/", 
                 pattern = "LFS_[12][09][019][0123456789].csv",
                 full.names = TRUE)[-c(1:8)]

# exclude 1993-2000

# for(i in 1:length(file_01to18)){
#   filterage15(file_01to18[i])
# }

for(i in 1:length(file)){
  filepath = file[i]
  data = read.csv(file, row.names=1)
  filtereddata = filter(data, data$AGE >=15)
  year = data$year[1]
  outputname = paste0("LFS_",year, "_above15.csv")
  write.csv(filtereddata, file= outputname)
}

#1993-2000: filter above 13 ################

# filterage13 = function(file){
#   filepath = paste0("/Data/LFS/", file)
#   data = read.csv(file, row.names=1)
#   filtereddata = filter(data, data$AGE >=13)
#   newname = substr(file, 1, 8)
#   outputname = paste0(newname, "_above13.csv")
#   write.csv(filtereddata, file= outputname)
# }
# 
# colvec_93to2000 = list(base1993, base1994, base1995,
#                        base1996, base1997, base1998,
#                        base1999, base2000)
# 
# for (i in 1:8) {
#   x= 'AGE' %in% colvec_93to2000[[i]]
#   print(x)
# } #confirmed that 'AGE' variable is ready to use
# 
# 
# file_93to2000 = list.files("T:/Thesis_Data/LFS_clean/LFS_clean",
#            pattern = "LFS_[12][09][019][0123456789].csv")[1:8]
# 
# for(i in 1:length(file_93to2000)){
#   filterage13(file_93to2000[i])
# }

# 2001 to 2018: filter above 15 #######################################

# filterage15 = function(file){
#   filepath = paste0("/Data/LFS/", file)
#   data = read.csv(file, row.names=1)
#   filtereddata = filter(data, data$AGE >=15)
#   newname = substr(file, 1, 8)
#   outputname = paste0(newname, "_above15.csv")
#   write.csv(filtereddata, file= outputname)
# }

# colvec_01to18 = list(base2001, base2002, base2003, base2004,
#                      base2005, base2006, base2007, base2008,
#                      base2009, base2010, base2011, base2012,
#                      base2013, base2014, base2015, base2016,
#                      base2017, base2018)

# for (i in 1: length(colvec_01to18)) {
#   x= 'AGE' %in% colvec_01to18[[i]]
#   print(x)
# } 

#'AGE' variable is not ready to use for year 2013. 
# Rename columns for year 2013 first



