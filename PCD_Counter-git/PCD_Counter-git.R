#set working directory!
local <- "local/dir"
#
setwd(Local)
#
library(data.table)
library(tidyverse)
# Secies Of Intrest:
SOI <- "AAAA"
#Using Hubbard Brook Data Template
valley <- read.csv("HUBB.csv")
#defs
Plots <- c(1:30)
Points <- { c(
  "A-18", "A-15", "A-12", "A-9", "A-6", "A-3", "A-0", 
  "C-0", "C-.3", "C-.6", "C-.9",
  "D-0", "D-12", "D-15", "D-18", "D-3", "D-6", "D-9",
  "F-0", "F-0.3", "F-0.6","F-0.9", 
  "I-0", "I-.3", "I-0.6", "I-0.9",
  "L-O", "L-0.3", "L-0.6", "L-0.9"  
)
}
PCP <- as.numeric(length(Points))
# Hubbard brook data:
## format valley to base R date:
date2012 <- seq(as.Date("2012-01-01"), as.Date("2012-12-30"), "days")
valley$Date <- as.Date(valley$Date, "%m/%d/%y")
# is SOI, plots are 1:30, 2012 data == datetotalval
totalvalSOI <- subset(valley, Species == SOI)
plotval <- subset(totalvalSOI, Plot == Plots)
datesvalG <- plotval[plotval$Date > "2012-01-01"]
datesvaltotal <- datesvalG[datesvalG$Date <"2012-12-30"]
totcounval <- as.numeric(count(datesvaltotal))
# US data:
len <- fread("OUR_DATA.csv")
pointslen <- subset(len, Point == Points)
totalslen <- subset(len, X.50m == SOI)
totcounlen <- as.numeric(count(totalslen))
resultvalues <- cbind(totcounlen, totcounval)
print(resultvalues)
