##################################################
############ prepare to merge ####################
##################################################
library(dplyr)
temp2001 = list.files(path = "T:/Thesis_Data/LFS_clean/LFS_clean", 
                      pattern = "LFS_[2][0][01][123456789]_[Q][1234]_above15.csv")
allfrom2001 = lapply(temp2001, read.csv)

for (i in 1:length(allfrom2001)) {
  assign(paste0("col_", i), colnames(allfrom2001[[i]]))
}

select(allfrom2001[[1]], -c(X))

print(col_68)

union(col_68, col_1)
union(setdiff(col_68, col_1), setdiff(col_1, col_68))
?union
union()
?do.call

do.call(union, allcolnames)

rm(allfrom2001)

