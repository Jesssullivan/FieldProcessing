library(data.table)
library(tidyverse)
#Read data in:
Data <- fread("2011_Git_PCD.csv")
#example of missing data
Data[99,]
#Define count and iterations:
count <- as.numeric(count(Data[,1]))
it <- 1:count+1
#efine loop beginning and loop each cell:
i <- 1
for(i in it) {
  ifelse(Data[i,1] == "", Data[i,1] <- Data[i-1,1], i+1)
}
i <- 1
for(i in it) {
  ifelse(Data[i,2] == "", Data[i,2] <- Data[i-1,2], i+1)
}
i <- 1
for(i in it) {
  ifelse(Data[i,3] == "", Data[i,3] <- Data[i-1,3], i+1)
}
#retest empty cells
Data[99,]
##write the results out:
##write.csv(Data, "PATH-HERE-2011_clean_PCD.csv")

