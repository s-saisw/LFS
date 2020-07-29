# ==============================================================================
# This program adds year and quarter to existing tables, output as csv
# details     - remove space in .sav file names
#             - write two new functions for Q and R
#             - process by quarter to reduce RAM's load
# input       - raw .sav files
# output      - raw .csv files
# Last update - 8/7/2019
# ==============================================================================

library(foreign)
library(haven)

setwd("C:/Users/81804/Desktop/Data/LFS")

LFSclean = function(year, quarter){
mainfolder = paste0("rawsav/Q", quarter)
filepath = paste0(mainfolder, "/LFS Q",quarter," ",year, ".sav")
LFSdata = read.spss(filepath, to.data.frame = TRUE)
LFSdata$year = year -543
LFSdata$quarter = quarter
output_name = paste0("LFS_", year-543, "_Q", quarter, ".csv")
write.csv(LFSdata, file= output_name)
}

#------------------------------------------------------------------------------
filesQ1 <- list.files("rawsav/Q1", ".sav", full.names = TRUE)
yearvecQ1 = as.numeric(substr(filesQ1, 18, 21))
quartervecQ1 = as.numeric(substr(filesQ1, 16, 16))

mapply(LFSclean, yearvecQ1, quartervecQ1)

#------------------------------------------------------------------------------
filesQ2 = list.files("/Data/LFS/rawsav/Q2", ".sav", full.names = FALSE)
yearvecQ2 = as.numeric(substr(filesQ2, 8, 11))
quartervecQ2 = as.numeric(substr(filesQ2, 6, 6))

mapply(LFSclean, yearvecQ2, quartervecQ2)

#------------------------------------------------------------------------------
filesQ3 = list.files("/Data/LFS/rawsav/Q3", ".sav", full.names = FALSE)
yearvecQ3 = as.numeric(substr(filesQ3, 8, 11))
quartervecQ3 = as.numeric(substr(filesQ3, 6, 6))

mapply(LFSclean, yearvecQ3, quartervecQ3)

#-------------------------------------------------------------------------------
filesQ4 = list.files("/Data/LFS/rawsav/Q4", ".sav", full.names = FALSE)
yearvecQ4 = as.numeric(substr(filesQ4, 8, 11))
quartervecQ4 = as.numeric(substr(filesQ4, 6, 6))

mapply(LFSclean, yearvecQ4, quartervecQ4)

#-------------------------------------------------------------------------------

LFSclean_R = function(year, quarter){
  mainfolder = "/Data/LFS/rawsav/R"
  filepath = paste0(mainfolder, "/LFS R",quarter," ",year, ".sav")
  LFSdata = read.spss(filepath, to.data.frame = TRUE)
  LFSdata$year = year -543
  LFSdata$quarter = quarter
  output_name = paste0("LFS_", year-543, "_R", quarter, ".csv")
  write.csv(LFSdata, file= output_name)
}

filesR = list.files("/Data/LFS/rawsav/R", ".sav", full.names = FALSE)
yearvecR = as.numeric(substr(filesR, 8, 11))
quartervecR = as.numeric(substr(filesR, 6, 6))

mapply(LFSclean_R, yearvecR, quartervecR)

