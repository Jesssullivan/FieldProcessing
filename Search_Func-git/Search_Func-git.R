#query for paired birds
#
#set working directory!
local <- "local/dir"
#
setwd(Local)
data <- data.frame(fread("QGIS_KML-XML_2_CSV.csv"))
pair_rows <- contains("pair", vars = data$description)
fem_rows <- contains("fem", vars = data$description)
result <- combine(pair_rows, fem_rows)
result <- data[result,]
write_csv(result, "Paired_birds.csv")
