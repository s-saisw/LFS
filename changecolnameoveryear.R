###############################
##Change column names by year##
###############################

data = read.csv("T:/Thesis_Data/LFS_clean/LFS_clean/LFS_2013.csv", 
                row.names=1)

colnames(data)

rm(data)

?memory.size
Sys.getenv("R_ARCH")
