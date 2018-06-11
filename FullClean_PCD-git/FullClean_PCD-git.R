#These two tools read .csv from Excel for point count data.
## KEY: Headers 1 through 5:
###  Point	Date	Time	<50m	>50m  ###
#set working directory!
local <- "local/dir"
#
setwd(Local)
#
#Input file name || set working dir. to source file location:
input <- "Dirt/2012_dirt_PCD-git.csv"
#Outout file name, 5 col. with <> 50m data || use full path:
output_5col <- "Output/2012_5_PCD_cleaned.csv"
#Outout file name, 4 col. || use full path:
output_4col <- "Output/2012_4_PCD_cleaned.csv"
#
library(data.table)
library(tidyverse)
#Read data in:
Data <- fread(input)
#Define count and iterations:
count <- as.numeric(count(Data[,1]))
it <- 1:count+1
#define loop beginning and loop each cell:
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
write.csv(Data, output_5col)
#This tool merges <50m and >50m point count col. 
#while preserving point, date, and time data.  
iter <- 1:count
q <- data.frame(Data[iter,1:3])
w <- data.frame(cbind(q, Data[iter,4]))
e <- data.frame(cbind(q, Data[iter,5]))
r <- rbind(w,e)
#remove rows resulting with no species data:
rclean <- cbind(r[!(r[,4] ==""),])
#write the results out:
write.csv(rclean, output_4col)

