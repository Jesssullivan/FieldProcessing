#This tool merges <50m and >50m point count col. 
#while preserving point, date, and time data.  
library(data.table)
#Read data in:
Data <- fread("2011_Git_PCD.csv")
#Define count and iterations:
count <- as.numeric(count(Data[,1]))
it <- 1:count
#process
q <- data.frame(Data[it,1:3])
w <- data.frame(cbind(q, Data[it,4]))
e <- data.frame(cbind(q, Data[it,5]))
r <- rbind(w,e)
#remove rows resulting with no species data:
rclean <- cbind(r[!(r[,4] ==""),])
#write the results out:
##write.csv(rclean, "path-goes-here.csv")

