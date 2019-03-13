################
# Title: Shot Charts Script
# Description: This R script will contain the script necessary for the creation of shot charts.
# Input(s): The  data will come from the csv file containing data for all five players that we exported at the end of  make-shots-data-script.R. The background basketball court jpeg file will come from the images repo in the Stat 133 github page.
# Output(s): The outputs will be five shot charts for each of the players saved as PDFs. There will also be a faceted image with all five shot charts. This will be saved as a PDF and also as a PNG. All produced images will be exported to the images folder.
################

#####packages required - jpeg, grid, ggplot2
library(jpeg)
library(grid)
library(ggplot2)
library(dplyr)
#####making a seperate data frame with each player's data
total_table <- read.csv("../data/shots-data-summary.csv")
#andre iguodala
iguodala <- filter(total_table, name == "Andre Iguodala")

#draymond green
green <- filter(total_table, name == "Draymond Green")

#kevin durant
durant <- filter(total_table, name == "Kevin Durant")

#klay thompson
thompson <- filter(total_table, name == "Klay Thompson")

#stephen curry
curry <- filter(total_table, name == "Stephen Curry")

#####importing the basketball court image
url <- "https://raw.githubusercontent.com/ucb-stat133/stat133-hws/master/images/nba-court.jpg"
destination <- "../images/nba-court.jpeg"
download.file(url, destination)
court_file <- "../images/nba-court.jpeg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width = unit(1, "npc"),
  height = unit(1, "npc"))

#####Shot chart for Andre Iguodala
#scatterplot
iguodala_scatterplot <- ggplot(data = iguodala) + geom_point(aes(x = x, y = y, color = shot_made_flag))
#shot chart w court background
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()
#exporting the plot as pdf
pdf(file = "../images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
iguodala_shot_chart
dev.off()

#####Shot chart for Draymond Green
green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()
#exporting the plot as pdf
pdf(file = "../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
green_shot_chart
dev.off()

#####Shot chart for Kevin Durant
durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()
#exporting the plot as pdf
pdf(file = "../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
durant_shot_chart
dev.off()

#####Shot chart for Klay Thompson
thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
#exporting the plot as pdf
pdf(file = "../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
thompson_shot_chart
dev.off()

#####Shot chart for Stephen Curry
curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()
#exporting the plot as pdf
pdf(file = "../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
curry_shot_chart
dev.off()

#####Facetted Shot Chart
total_shot_chart <- ggplot(data = total_table) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: GSW (2016 season)') +
  theme_minimal() + facet_wrap(~name)
#exporting the plot as PDF
pdf(file = "../images/gsw-shot-charts.pdf", height = 7, width = 8)
total_shot_chart
dev.off()
#exporting the plot as PNG
png(filename = "../images/gsw-shot-charts.png", width = 8, height = 7, units = "in", res = 300)
total_shot_chart
dev.off()

