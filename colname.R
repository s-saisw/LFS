#===========================================================================
# This program rename columns and merge quarterly data together
# last update - 8/7/2019
# input       - .csv quarterly data 1993-2018
# output      - annual LFS
#===========================================================================

library(tidyverse)

# merge 2018 #####################################################

LFS_2018_Q4 = read.csv("/Data/LFS/rawcsv/LFS_2018_Q4.csv", 
                       row.names=1)
colbase = colnames(LFS_2018_Q4)
base2018 = colbase

LFS_2018_Q3 = read.csv("/Data/LFS/rawcsv/LFS_2018_Q3.csv",
                       row.names=1)  #ready to merge

union(setdiff(colbase, newcol), setdiff(newcol, colbase)) 

LFS_2018_Q2 = read.csv("/Data/LFS/rawcsv/LFS_2018_Q2.csv", 
                       row.names=1) #ready

LFS_2018_Q1 = read.csv("/Data/LFS/rawcsv/LFS_2018_Q1.csv", 
                       row.names=1) #ready

LFS_2018 = bind_rows(LFS_2018_Q1, LFS_2018_Q2, LFS_2018_Q3, LFS_2018_Q4)

write.csv(LFS_2018, file = "LFS_2018.csv")

newcol = colnames(LFS_2018_Q1)

#clear memory
rm(LFS_2018)
rm(LFS_2018_Q1)
rm(LFS_2018_Q2)
rm(LFS_2018_Q3)
rm(LFS_2018_Q4)

# merge 2017 ###################################################

list2017 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2017_Q[1234].csv")

temp2017 = lapply(list2017, read.csv, row.names=1)
class(temp2017)

base2017 = colnames(temp2017[[1]])

Q2_col_2017 = colnames(temp2017[[2]]) #ready
Q3_col_2017 = colnames(temp2017[[3]]) #ready
Q4_col_2017 = colnames(temp2017[[4]]) #ready

LFS_2017 = bind_rows(temp2017)
write.csv(LFS_2017, file = "LFS_2017.csv")

length(union(base2017, Q4_col_2017))

#clear memory
rm(temp2017)
rm(LFS_2017)

# merge year 2016 ###################################################

list2016 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2016_Q[1234].csv")

temp2016 = lapply(list2016, read.csv, row.names=1)

base2016 = colnames(temp2016[[1]])

Q2_col_2016 = colnames(temp2016[[2]]) 
length(union(base2016, Q2_col_2016))
union(setdiff(base2016, Q2_col_2016),
      setdiff(Q2_col_2016, base2016))

temp2016[[2]] = rename(temp2016[[2]], RETURN_ = RETURN)

Q3_col_2016 = colnames(temp2016[[3]]) #ready
length(union(base2016, Q3_col_2016))
union(setdiff(base2016, Q3_col_2016),
      setdiff(Q3_col_2016, base2016))

Q4_col_2016 = colnames(temp2016[[4]]) #ready
length(union(base2016, Q4_col_2016))
union(setdiff(base2016, Q4_col_2016),
      setdiff(Q4_col_2016, base2016))

LFS_2016 = bind_rows(temp2016)
write.csv(LFS_2016, file = "LFS_2016.csv")

#clear memory
rm(temp2016)
rm(LFS_2016)

# merge 2015 ################################################
list2015 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2015_Q[1234].csv")

temp2015 = lapply(list2015, read.csv, row.names=1)
class(temp2015)

base2015 = colnames(temp2015[[1]])
length(base2015)

Q2_col_2015 = colnames(temp2015[[2]]) #ready
length(union(base2015, Q2_col_2015))
union(setdiff(base2015, Q2_col_2015),
      setdiff(Q2_col_2015, base2015))

Q3_col_2015 = colnames(temp2015[[3]]) #ready
length(union(base2015, Q3_col_2015))
union(setdiff(base2015, Q3_col_2015),
      setdiff(Q3_col_2015, base2015))

Q4_col_2015 = colnames(temp2015[[4]]) #ready
length(union(base2015, Q4_col_2015))
union(setdiff(base2015, Q4_col_2015),
      setdiff(Q4_col_2015, base2015))

LFS_2015 = bind_rows(temp2015)
write.csv(LFS_2015, file = "LFS_2015.csv")

#clear memory
rm(temp2015)
rm(LFS_2015)

# merge 2014 ######################################################
list2014 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2014_Q[1234].csv")

temp2014 = lapply(list2014, read.csv, row.names=1)

base2014 = colnames(temp2014[[1]])
length(base2014)

Q2_col_2014 = colnames(temp2014[[2]]) #ready
length(union(base2014, Q2_col_2014))
union(setdiff(base2014, Q2_col_2014),
      setdiff(Q2_col_2014, base2014))

Q3_col_2014 = colnames(temp2014[[3]]) #ready
length(union(base2014, Q3_col_2014))
union(setdiff(base2014, Q3_col_2014),
      setdiff(Q3_col_2014, base2014))

Q4_col_2014 = colnames(temp2014[[4]]) #ready
length(union(base2014, Q4_col_2014))
union(setdiff(base2014, Q4_col_2014),
      setdiff(Q4_col_2014, base2014))

LFS_2014 = bind_rows(temp2014)
write.csv(LFS_2014, file = "LFS_2014.csv")

#clear memory
rm(temp2014)
rm(LFS_2014)

# merge 2013 ######################################################
list2013 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2013_Q[1234].csv")

temp2013 = lapply(list2013, read.csv, row.names=1)

base2013 = colnames(temp2013[[1]])
length(base2013)

Q2_col_2013 = colnames(temp2013[[2]]) #ready
length(union(base2013, Q2_col_2013))
union(setdiff(base2013, Q2_col_2013),
      setdiff(Q2_col_2013, base2013))

Q3_col_2013 = colnames(temp2013[[3]]) #ready
length(union(base2013, Q3_col_2013))
union(setdiff(base2013, Q3_col_2013),
      setdiff(Q3_col_2013, base2013))

Q4_col_2013 = colnames(temp2013[[4]]) #ready
length(union(base2013, Q4_col_2013))
union(setdiff(base2013, Q4_col_2013),
      setdiff(Q4_col_2013, base2013))

LFS_2013 = bind_rows(temp2013)
write.csv(LFS_2013, file = "LFS_2013.csv")

#clear memory
rm(temp2013)
rm(LFS_2013)

# merge 2012 ######################################################
list2012 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2012_Q[1234].csv")

temp2012 = lapply(list2012, read.csv, row.names=1)

base2012 = colnames(temp2012[[1]])
length(base2012)

Q2_col_2012 = colnames(temp2012[[2]]) #ready
length(union(base2012, Q2_col_2012))
union(setdiff(base2012, Q2_col_2012),
      setdiff(Q2_col_2012, base2012))

Q3_col_2012 = colnames(temp2012[[3]]) #ready
length(union(base2012, Q3_col_2012))
union(setdiff(base2012, Q3_col_2012),
      setdiff(Q3_col_2012, base2012))

Q4_col_2012 = colnames(temp2012[[4]]) 
length(union(base2012, Q4_col_2012))
union(setdiff(base2012, Q4_col_2012),
      setdiff(Q4_col_2012, base2012))

temp2012[[4]] = rename(temp2012[[4]],
  MEMBERS =  MEMBERS_
)

LFS_2012 = bind_rows(temp2012)
write.csv(LFS_2012, file = "LFS_2012.csv")

#clear memory
rm(temp2012)
rm(LFS_2012)

# merge 2011 #####################################################
list2011 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2011_Q[1234].csv")

temp2011 = lapply(list2011, read.csv, row.names=1)

base2011 = colnames(temp2011[[1]])
length(base2011)

Q2_col_2011 = colnames(temp2011[[2]]) #ready
length(union(base2011, Q2_col_2011))
union(setdiff(base2011, Q2_col_2011),
      setdiff(Q2_col_2011, base2011))

Q3_col_2011 = colnames(temp2011[[3]]) #ready
length(union(base2011, Q3_col_2011))
union(setdiff(base2011, Q3_col_2011),
      setdiff(Q3_col_2011, base2011))

Q4_col_2011 = colnames(temp2011[[4]]) 
length(union(base2011, Q4_col_2011))
union(setdiff(base2011, Q4_col_2011),
      setdiff(Q4_col_2011, base2011))

temp2011[[4]] = rename(temp2011[[4]],
                       RETURN =  RETURN_
)

LFS_2011 = bind_rows(temp2011)
write.csv(LFS_2011, file = "LFS_2011.csv")

#clear memory
rm(temp2011)
rm(LFS_2011)

# merge 2010 #####################################################
list2010 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2010_Q[1234].csv")

temp2010 = lapply(list2010, read.csv, row.names=1)

base2010 = colnames(temp2010[[1]])
length(base2010)

Q2_col_2010 = colnames(temp2010[[2]]) #ready
length(union(base2010, Q2_col_2010))
union(setdiff(base2010, Q2_col_2010),
      setdiff(Q2_col_2010, base2010))

Q3_col_2010 = colnames(temp2010[[3]]) #ready
length(union(base2010, Q3_col_2010))
union(setdiff(base2010, Q3_col_2010),
      setdiff(Q3_col_2010, base2010))

Q4_col_2010 = colnames(temp2010[[4]]) #ready
length(union(base2010, Q4_col_2010))
union(setdiff(base2010, Q4_col_2010),
      setdiff(Q4_col_2010, base2010))

LFS_2010 = bind_rows(temp2010)
write.csv(LFS_2010, file = "LFS_2010.csv")

#clear memory
rm(temp2010)
rm(LFS_2010)

# merge 2009 #####################################################
list2009 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2009_Q[1234].csv")

temp2009 = lapply(list2009, read.csv, row.names=1)

base2009 = colnames(temp2009[[1]])
length(base2009)

Q2_col_2009 = colnames(temp2009[[2]]) #ready
length(union(base2009, Q2_col_2009))
union(setdiff(base2009, Q2_col_2009),
      setdiff(Q2_col_2009, base2009))

Q3_col_2009 = colnames(temp2009[[3]])
length(union(base2009, Q3_col_2009))
union(setdiff(base2009, Q3_col_2009),
      setdiff(Q3_col_2009, base2009))

temp2009[[3]] = rename(temp2009[[3]],
                       MEMBERS = MEMBERS_,
                       AMOUMT = AMOUNT,
                       WEIGHT = Weight
                       )

Q4_col_2009 = colnames(temp2009[[4]])
length(union(base2009, Q4_col_2009))
union(setdiff(base2009, Q4_col_2009),
      setdiff(Q4_col_2009, base2009))

temp2009[[4]] = rename(temp2009[[4]],
                       MEMBERS = MEMBERS_,
                       AMOUMT = AMOUNT,
                       WEIGHT = Weight
                      )

LFS_2009 = bind_rows(temp2009)
write.csv(LFS_2009, file = "LFS_2009.csv")

length(colnames(LFS_2009))

#clear memory
rm(temp2009)
rm(LFS_2009)

# merge 2008 #####################################################
list2008 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2008_Q[1234].csv")

temp2008 = lapply(list2008, read.csv, row.names=1)

base2008 = colnames(temp2008[[1]])
length(base2008)

Q2_col_2008 = colnames(temp2008[[2]]) #ready
length(union(base2008, Q2_col_2008))
union(setdiff(base2008, Q2_col_2008),
      setdiff(Q2_col_2008, base2008))

Q3_col_2008 = colnames(temp2008[[3]]) #ready
length(union(base2008, Q3_col_2008))
union(setdiff(base2008, Q3_col_2008),
      setdiff(Q3_col_2008, base2008))

Q4_col_2008 = colnames(temp2008[[4]]) #ready
length(union(base2008, Q4_col_2008))
union(setdiff(base2008, Q4_col_2008),
      setdiff(Q4_col_2008, base2008))

LFS_2008 = bind_rows(temp2008)
write.csv(LFS_2008, file = "LFS_2008.csv")

length(colnames(LFS_2008))

#clear memory
rm(temp2008)
rm(LFS_2008)

# merge 2007 #####################################################
list2007 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2007_Q[1234].csv")

temp2007 = lapply(list2007, read.csv, row.names=1)

base2007 = colnames(temp2007[[1]])
length(base2007)

Q2_col_2007 = colnames(temp2007[[2]]) #ready
length(union(base2007, Q2_col_2007))
union(setdiff(base2007, Q2_col_2007),
      setdiff(Q2_col_2007, base2007))

Q3_col_2007 = colnames(temp2007[[3]]) #ready
length(union(base2007, Q3_col_2007))
union(setdiff(base2007, Q3_col_2007),
      setdiff(Q3_col_2007, base2007))

Q4_col_2007 = colnames(temp2007[[4]]) #ready
length(union(base2007, Q4_col_2007))
union(setdiff(base2007, Q4_col_2007),
      setdiff(Q4_col_2007, base2007))

LFS_2007 = bind_rows(temp2007)
write.csv(LFS_2007, file = "LFS_2007.csv")

#clear memory
rm(temp2007)
rm(LFS_2007)

# merge 2005 #####################################################
list2005 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2006_Q[1234].csv")

temp2006 = lapply(list2006, read.csv, row.names=1)

base2006 = colnames(temp2006[[1]])
length(base2006)

Q2_col_2006 = colnames(temp2006[[2]]) #ready
length(union(base2006, Q2_col_2006))
union(setdiff(base2006, Q2_col_2006),
      setdiff(Q2_col_2006, base2006))

Q3_col_2006 = colnames(temp2006[[3]]) #ready
length(union(base2006, Q3_col_2006))
union(setdiff(base2006, Q3_col_2006),
      setdiff(Q3_col_2006, base2006))

Q4_col_2006 = colnames(temp2006[[4]]) #ready
length(union(base2006, Q4_col_2006))
union(setdiff(base2006, Q4_col_2006),
      setdiff(Q4_col_2006, base2006))

LFS_2006 = bind_rows(temp2006)
write.csv(LFS_2006, file = "LFS_2006.csv")

#clear memory
rm(temp2006)
rm(LFS_2006)

# merge 2005 #####################################################
list2005 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2005_Q[1234].csv")

temp2005 = lapply(list2005, read.csv, row.names=1)

base2005 = colnames(temp2005[[1]])
length(base2005)

Q2_col_2005 = colnames(temp2005[[2]]) #ready
length(union(base2005, Q2_col_2005))
union(setdiff(base2005, Q2_col_2005),
      setdiff(Q2_col_2005, base2005))

Q3_col_2005 = colnames(temp2005[[3]]) #ready
length(union(base2005, Q3_col_2005))
union(setdiff(base2005, Q3_col_2005),
      setdiff(Q3_col_2005, base2005))

Q4_col_2005 = colnames(temp2005[[4]]) #ready
length(union(base2005, Q4_col_2005))
union(setdiff(base2005, Q4_col_2005),
      setdiff(Q4_col_2005, base2005))

LFS_2005 = bind_rows(temp2005)
write.csv(LFS_2005, file = "LFS_2005.csv")

#clear memory
rm(temp2005)
rm(LFS_2005)

# merge 2004 #####################################################
list2004 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2004_Q[1234].csv")

temp2004 = lapply(list2004, read.csv, row.names=1)

base2004 = colnames(temp2004[[1]])
length(base2004)

Q2_col_2004 = colnames(temp2004[[2]]) #ready
length(union(base2004, Q2_col_2004))
union(setdiff(base2004, Q2_col_2004),
      setdiff(Q2_col_2004, base2004))

Q3_col_2004 = colnames(temp2004[[3]]) #ready
length(union(base2004, Q3_col_2004))
union(setdiff(base2004, Q3_col_2004),
      setdiff(Q3_col_2004, base2004))

Q4_col_2004 = colnames(temp2004[[4]]) #ready
length(union(base2004, Q4_col_2004))
union(setdiff(base2004, Q4_col_2004),
      setdiff(Q4_col_2004, base2004))

LFS_2004 = bind_rows(temp2004)
write.csv(LFS_2004, file = "LFS_2004.csv")

#clear memory
rm(temp2004)
rm(LFS_2004)

# merge 2003 #####################################################
list2003 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2003_Q[1234].csv")

temp2003 = lapply(list2003, read.csv, row.names=1)

base2003 = colnames(temp2003[[1]])
length(base2003)

Q2_col_2003 = colnames(temp2003[[2]]) #ready
length(union(base2003, Q2_col_2003))
union(setdiff(base2003, Q2_col_2003),
      setdiff(Q2_col_2003, base2003))

Q3_col_2003 = colnames(temp2003[[3]]) #ready
length(union(base2003, Q3_col_2003))
union(setdiff(base2003, Q3_col_2003),
      setdiff(Q3_col_2003, base2003))

Q4_col_2003 = colnames(temp2003[[4]]) #ready
length(union(base2003, Q4_col_2003))
union(setdiff(base2003, Q4_col_2003),
      setdiff(Q4_col_2003, base2003))

LFS_2003 = bind_rows(temp2003)
write.csv(LFS_2003, file = "LFS_2003.csv")

#clear memory
rm(temp2003)
rm(LFS_2003)

# merge 2002 #####################################################
list2002 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2002_Q[1234].csv")

temp2002 = lapply(list2002, read.csv, row.names=1)

base2002 = colnames(temp2002[[1]])
length(base2002)

Q2_col_2002 = colnames(temp2002[[2]]) #ready
length(union(base2002, Q2_col_2002))
union(setdiff(base2002, Q2_col_2002),
      setdiff(Q2_col_2002, base2002))

Q3_col_2002 = colnames(temp2002[[3]]) #ready
length(union(base2002, Q3_col_2002))
union(setdiff(base2002, Q3_col_2002),
      setdiff(Q3_col_2002, base2002))

Q4_col_2002 = colnames(temp2002[[4]]) #ready
length(union(base2002, Q4_col_2002))
union(setdiff(base2002, Q4_col_2002),
      setdiff(Q4_col_2002, base2002))

LFS_2002 = bind_rows(temp2002)
write.csv(LFS_2002, file = "LFS_2002.csv")

#clear memory
rm(temp2002)
rm(LFS_2002)

# merge 2001 #####################################################
list2001 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2001_Q[1234].csv")

temp2001 = lapply(list2001, read.csv, row.names=1)

base2001 = colnames(temp2001[[1]])
length(base2001)

Q2_col_2001 = colnames(temp2001[[2]]) #ready
length(union(base2001, Q2_col_2001))
union(setdiff(base2001, Q2_col_2001),
      setdiff(Q2_col_2001, base2001))

Q3_col_2001 = colnames(temp2001[[3]]) #ready
length(union(base2001, Q3_col_2001))
union(setdiff(base2001, Q3_col_2001),
      setdiff(Q3_col_2001, base2001))

Q4_col_2001 = colnames(temp2001[[4]]) #ready
length(union(base2001, Q4_col_2001))
union(setdiff(base2001, Q4_col_2001),
      setdiff(Q4_col_2001, base2001))

LFS_2001 = bind_rows(temp2001)
write.csv(LFS_2001, file = "LFS_2001.csv")

#clear memory
rm(temp2001)
rm(LFS_2001)

# merge 2000 #####################################################
list2000 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_2000_Q[1234].csv")

temp2000 = lapply(list2000, read.csv, row.names=1)

base2000 = colnames(temp2000[[1]])
length(base2000)

Q2_col_2000 = colnames(temp2000[[2]]) #ready
length(union(base2000, Q2_col_2000))
union(setdiff(base2000, Q2_col_2000),
      setdiff(Q2_col_2000, base2000))

Q3_col_2000 = colnames(temp2000[[3]]) #ready
length(union(base2000, Q3_col_2000))
union(setdiff(base2000, Q3_col_2000),
      setdiff(Q3_col_2000, base2000))

Q4_col_2000 = colnames(temp2000[[4]]) #ready
length(union(base2000, Q4_col_2000))
union(setdiff(base2000, Q4_col_2000),
      setdiff(Q4_col_2000, base2000))

LFS_2000 = bind_rows(temp2000)
write.csv(LFS_2000, file = "LFS_2000.csv")

#clear memory
rm(temp2000)
rm(LFS_2000)

# merge 1999 #####################################################
list1999 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1999_Q[1234].csv")

temp1999 = lapply(list1999, read.csv, row.names=1)

base1999 = colnames(temp1999[[1]])
length(base1999)

Q2_col_1999 = colnames(temp1999[[2]]) #ready
length(union(base1999, Q2_col_1999))
union(setdiff(base1999, Q2_col_1999),
      setdiff(Q2_col_1999, base1999))

Q3_col_1999 = colnames(temp1999[[3]]) #ready
length(union(base1999, Q3_col_1999))
union(setdiff(base1999, Q3_col_1999),
      setdiff(Q3_col_1999, base1999))

Q4_col_1999 = colnames(temp1999[[4]]) #ready
length(union(base1999, Q4_col_1999))
union(setdiff(base1999, Q4_col_1999),
      setdiff(Q4_col_1999, base1999))

LFS_1999 = bind_rows(temp1999)
write.csv(LFS_1999, file = "LFS_1999.csv")

#clear memory
rm(temp1999)
rm(LFS_1999)

# merge 1998 #####################################################
list1998 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1998_Q[1234].csv")

temp1998 = lapply(list1998, read.csv, row.names=1)

base1998 = colnames(temp1998[[1]])
length(base1998)

Q2_col_1998 = colnames(temp1998[[2]]) #ready
length(union(base1998, Q2_col_1998))
union(setdiff(base1998, Q2_col_1998),
      setdiff(Q2_col_1998, base1998))

Q3_col_1998 = colnames(temp1998[[3]]) #ready
length(union(base1998, Q3_col_1998))
union(setdiff(base1998, Q3_col_1998),
      setdiff(Q3_col_1998, base1998))

Q4_col_1998 = colnames(temp1998[[4]]) #ready
length(union(base1998, Q4_col_1998))
union(setdiff(base1998, Q4_col_1998),
      setdiff(Q4_col_1998, base1998))

LFS_1998 = bind_rows(temp1998)
write.csv(LFS_1998, file = "LFS_1998.csv")

#clear memory
rm(temp1998)
rm(LFS_1998)

# merge 1997 #####################################################
list1997 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1997_R[1234].csv")

temp1997 = lapply(list1997, read.csv, row.names=1)

base1997 = colnames(temp1997[[1]])
length(base1997)

R3_col_1997 = colnames(temp1997[[2]]) #ready
length(union(base1997, R3_col_1997))
union(setdiff(base1997, R3_col_1997),
      setdiff(R3_col_1997, base1997))

LFS_1997 = bind_rows(temp1997)
write.csv(LFS_1997, file = "LFS_1997.csv")

#clear memory
rm(temp1997)
rm(LFS_1997)

# merge 1996 #####################################################
list1996 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1996_R[1234].csv")

temp1996 = lapply(list1996, read.csv, row.names=1)

base1996 = colnames(temp1996[[1]])
length(base1996)

R2_col_1996 = colnames(temp1996[[2]]) #ready
length(union(base1996, R2_col_1996))
union(setdiff(base1996, R2_col_1996),
      setdiff(R2_col_1996, base1996))

R3_col_1996 = colnames(temp1996[[3]]) #ready
length(union(base1996, R3_col_1996))
union(setdiff(base1996, R3_col_1996),
      setdiff(R3_col_1996, base1996))

LFS_1996 = bind_rows(temp1996)
write.csv(LFS_1996, file = "LFS_1996.csv")

#clear memory
rm(temp1996)
rm(LFS_1996)

# merge 1995 #####################################################
list1995 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1995_R[1234].csv")

temp1995 = lapply(list1995, read.csv, row.names=1)

base1995 = colnames(temp1995[[1]])
length(base1995)

R3_col_1995 = colnames(temp1995[[2]]) #ready
length(union(base1995, R2_col_1995))
union(setdiff(base1995, R2_col_1995),
      setdiff(R2_col_1995, base1995))

LFS_1995 = bind_rows(temp1995)
write.csv(LFS_1995, file = "LFS_1995.csv")

#clear memory
rm(temp1995)
rm(LFS_1995)

# merge 1994 #####################################################
list1994 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1994_R[1234].csv")

temp1994 = lapply(list1994, read.csv, row.names=1)

base1994 = colnames(temp1994[[1]])
length(base1994)

R2_col_1994 = colnames(temp1994[[2]]) #ready
length(union(base1994, R2_col_1994))
union(setdiff(base1994, R2_col_1994),
      setdiff(R2_col_1994, base1994))

R3_col_1994 = colnames(temp1994[[3]]) #ready
length(union(base1994, R3_col_1994))
union(setdiff(base1994, R3_col_1994),
      setdiff(R3_col_1994, base1994))

LFS_1994 = bind_rows(temp1994)
write.csv(LFS_1994, file = "LFS_1994.csv")

#clear memory
rm(temp1994)
rm(LFS_1994)

# merge 1993 #####################################################
list1993 = list.files("/Data/LFS/rawcsv",
                      pattern = "LFS_1993_R[1234].csv")

temp1993 = lapply(list1993, read.csv, row.names=1)

base1993 = colnames(temp1993[[1]])
length(base1993)

R3_col_1993 = colnames(temp1993[[2]]) #ready
length(union(base1993, R3_col_1993))
union(setdiff(base1993, R3_col_1993),
      setdiff(R3_col_1993, base1993))

LFS_1993 = bind_rows(temp1993)
write.csv(LFS_1993, file = "LFS_1993.csv")

#clear memory
rm(temp1993)
rm(LFS_1993)
