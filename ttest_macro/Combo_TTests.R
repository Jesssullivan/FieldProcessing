library(XLConnect)
library(tidyverse)
library(plyr)
library(dplyr)

# locations, env setup
datafile <- "StemDensity3.xlsx"

# User input 
excel <- loadWorkbook(datafile) 
sheet_names <- getSheets(excel)
names(sheet_names) <- sheet_names
# get all sheets
d <- lapply(sheet_names, function(.sheet){readWorksheet(object=excel, .sheet)})

# start with a sheet
df <- d$`2017_2018 Combined`

# clean sheet
df_a <- df[, !apply(df, 2, function(x) all(gsub(" ", "", x)=="", na.rm=TRUE))]

# eval for cut catagories 
Edge <- subset(df_a, Presumed.Habitat.type..Patch..edge..Mature.frst. == "Edge")
Patch <- subset(df_a, Presumed.Habitat.type..Patch..edge..Mature.frst. == "Patch")
Mature <- subset(df_a, Presumed.Habitat.type..Patch..edge..Mature.frst. == "Mature")

# eval per species

MAWAEdge <- Edge[grep('MAWA', Edge$Bird.ID),]
CSWAEdge <- Edge[grep('CSWA', Edge$Bird.ID),]
BTBWEdge <- Edge[grep('BTBW', Edge$Bird.ID),]
COYEEdge <- Edge[grep('COYE', Edge$Bird.ID),]

MAWAPatch <- Patch[grep('MAWA', Patch$Bird.ID),]
CSWAPatch <- Patch[grep('CSWA', Patch$Bird.ID),]
BTBWPatch <- Patch[grep('BTBW', Patch$Bird.ID),]
COYEPatch <- Patch[grep('COYE', Patch$Bird.ID),]

MAWAMature <- Mature[grep('MAWA', Mature$Bird.ID),]
CSWAMature <- Mature[grep('CSWA', Mature$Bird.ID),]
BTBWMature <- Mature[grep('BTBW', Mature$Bird.ID),]
COYEMature <- Mature[grep('COYE', Mature$Bird.ID),]

# List all combo dfs
List_dfs <- list(MAWAMature, MAWAMature, MAWAPatch, CSWAEdge, CSWAMature, CSWAPatch,
  COYEEdge, COYEMature, COYEPatch, BTBWEdge, BTBWMature, BTBWPatch)

# find combos (12 sq or 144 here, FWIW)
i <- expand.grid(c(1:length(List_dfs)),(c(1:length(List_dfs))))

len_res <- 1:length(i[,1])

# iterate, errors are ok (will grep through for successes)
res <- lapply(X = c(1:length(i[,1])), FUN = function(p) {
  try({
     x <- t.test(data.frame(List_dfs[i[,1][p]])$Combined, 
                 data.frame(List_dfs[i[,2][p]])$Combined) 
     # t.test will be strong with this data
     x$data <- List_dfs[i[,1][p]][1]
     return(x)
  })
})
# find non errors
x_nums <- grep('Welch', res)
resul <- matrix(res[x_nums])
length(resul[1,])
# clean results for useful info
i = 1
p <- data.frame()

# iterate for p, a four column df
for (i in 1:49) {
    x <- data.frame(resul[[i]]$p.value, 
      resul[[i]]$parameter, 
      data.frame(resul[[i]]$data)$Bird.ID[1],
      data.frame(resul[[i]]$data)$Bird.ID[2],
      stringsAsFactors = FALSE)
    p <- rbind(p,x)
}

# do domething else
write.csv(p, "logged_values.csv")

