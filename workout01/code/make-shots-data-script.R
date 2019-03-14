################
# Title: Data Cleanup/Preparation
# Description: This R script will contain all my data preparation and cleaning.
# Input(s): The raw data will come from five data CSV files - one for each player.
# Output(s): The output will be a single data frame with cleaned information from all five players (exported to data folder), and text files with summary outputs for each player (exported to output folder). 
################

#####Downloading the data from the Stat133 github folder
#Iguodala
urlI <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/data/andre-iguodala.csv"
dI <- "../data/andre-iguodala.csv"
download.file(urlI, dI)

#Green
urlG <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/data/draymond-green.csv"
dG <- "../data/draymond-green.csv"
download.file(urlG, dG)

#Durant
urlD <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/data/kevin-durant.csv"
dD <- "../data/kevin-durant.csv"
download.file(urlD, dD)

#Thompson
urlT <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/data/klay-thompson.csv"
dT <- "../data/klay-thompson.csv"
download.file(urlT, dT)

#Curry
urlC <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/data/stephen-curry.csv"
dC <- "../data/stephen-curry.csv"
download.file(urlC, dC)


data_types <- c("team_name" = "character", "game_date" = "character", "season" = "integer", "period" = "integer", "minutes_remaining" = "integer", "seconds_remaining" = "integer", "shot_made_flag" = "character", "action_type" = "character", "shot_type" = "character", "shot_distance" = "integer", "opponent" = "character", "x" = "integer", "y" = "integer")

#####Reading in Iguodala's data
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE, colClasses = data_types)
#adding a name column
iguodala$name <- "Andre Iguodala"
iguodala <- iguodala[,c(14, 1,2,3,4,5,6,7,8,9,10,11,12,13)]
#changing shot_made_flag from y/n to shot_yes/shot_no
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <- "shot_yes"
#adding minute column
iguodala$minute <- (iguodala$period*12) - iguodala$minutes_remaining
#exporting summary statistics
sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

#####Reading in Green's data
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE, colClasses = data_types)
#adding a name column
green$name <- "Draymond Green"
green <- green[,c(14, 1,2,3,4,5,6,7,8,9,10,11,12,13)]
#changing shot_made_flag from y/n to shot_yes/shot_no
green$shot_made_flag[green$shot_made_flag == "n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag == "y"] <- "shot_yes"
#adding minute column
green$minute <- (green$period*12) - green$minutes_remaining
#exporting summary statistics
sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()

#####Reading in Durant's data
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE, colClasses = data_types)
#adding a name column
durant$name <- "Kevin Durant"
durant <- durant[,c(14, 1,2,3,4,5,6,7,8,9,10,11,12,13)]
#changing shot_made_flag from y/n to shot_yes/shot_no
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "shot_yes"
#adding minute column
green$minute <- (green$period*12) - green$minutes_remaining
#exporting summary statistics
sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()

#####Reading in Thompson's data
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE, colClasses = data_types)
#adding a name column
thompson$name <- "Klay Thompson"
thompson <- thompson[,c(14, 1,2,3,4,5,6,7,8,9,10,11,12,13)]
#changing shot_made_flag from y/n to shot_yes/shot_no
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "shot_yes"
#adding minute column
thompson$minute <- (thompson$period*12) - thompson$minutes_remaining
#exporting summary statistics
sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()

#####Reading in Curry's data
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE, colClasses = data_types)
#adding a name column
curry$name <- "Stephen Curry"
curry <- curry[,c(14, 1,2,3,4,5,6,7,8,9,10,11,12,13)]
#changing shot_made_flag from y/n to shot_yes/shot_no
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "shot_no"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "shot_yes"
#adding minute column
curry$minute <- (curry$period*12) - curry$minutes_remaining
#exporting summary statistics
sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()

#####Stacking all five tables into one
total_table <- rbind(iguodala, green, durant, thompson, curry)

#####Exporting the total_table as a CSV file shots-data.csv into the data folder
write.table(total_table, file = "../data/shots-data-summary.csv", sep = ",")

#####Exporting summary statistics for total_table to the output folder
sink(file = "../output/shots-data-summary.txt")
summary(total_table)
sink()
