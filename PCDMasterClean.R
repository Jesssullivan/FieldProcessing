library(tidyverse)
library(plyr)
library(dplyr)
library(lubridate)
library(XLConnect) # Java Jar troubles, only for xlsx work
# ^ Handy Packages, generally not used
# see github.com/Jesssullivan/FieldProcessing 
datafile <- "InsertPCDFileHere.xlsx"
outfile <- "CleanedPCD_2011-2018.csv"

excel <- loadWorkbook(datafile) 
sheet_names <- getSheets(excel)
names(sheet_names) <- sheet_names
# get all sheets
d <- lapply(sheet_names, function(.sheet){readWorksheet(object=excel, .sheet)})

# List of sheets to iterate over
listDF <- list(d$`2011 Point Counts`, d$`2012 Point Counts`, d$`2013 Point Counts`,
               d$`2014 Point Counts`, d$`2015 Point Counts`, d$`2016 PCs`, d$`2017 PC`,
               d$`2018 PC`)

# fill empty cells with CleanDFs Function
CleanDFs <- function(Data) {
  it <- as.numeric(length(Data$Point))
  i <- 1  
  try(for(i in 1:it) {
    if (is.na(Data[i,1] == TRUE))
      Data[i,1] <- as.character(Data[i - 1,1])
  })
  i <- 1 
  try(for(i in 1:it) {
    if (is.na(Data[i,2] == TRUE))
    Data[i,2] <- as.character(Data[i - 1,2])
    print(Data[i,2])
  })
  i <- 1 # fill Time col
  try(for(i in 1:it) {
    if (is.na(Data[i,3] == TRUE))
    Data[i,3] <- Data[i - 1,3]
    print(Data[i,3])
  })
  return(Data)
}

df <- data.frame() # we will fill this with all cleaned PCD data

for (ii in 1:as.numeric(length(listDF))) {
  print(ii)
  df_cleaned <- CleanDFs(listDF[[ii]])
  df_cleaned$Time <- format(df_cleaned$Time, format="%H:%M:%S")
  df_cleaned$Date <- as.Date(df_cleaned$Date)
  df <- rbind(df_cleaned[,1:5], df) 
}

# Carry on with life
# write_csv(df, outfile)