## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##
## Exploratory Data Analysis - Week 1 Project
## Creates a png histogram for Global Active Power
##
## Author: Agustín Da Fieno Delucchi
##
## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Load required library
require(data.table)

## Dowload and unzip data file
file.Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file.Url, destfile = "ElectricPowerConsumption.zip")
unzip("ElectricPowerConsumption.zip")

## Creating a file connection
fileConnection <- file(description = "household_power_consumption.txt", open = "rt")

## Filtering read to only January-February 2007 and storing in a separate file
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(fileConnection), value=TRUE), sep="\n", file="plot1.txt")

## Closing file connection
close(fileConnection)

## Reading filtered file
plot1 <- fread("plot1.txt", sep=";", header=TRUE, na.strings="?")

## Parse the date format
plot1$Date <- as.Date(plot1$Date, "%d/%m/%Y")

## Plotting the required historgram
with(plot1, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Acitve Power (kilowatts)", ylab="Frequency"))

## COpying plot to png file
dev.copy(png, file="plot1.png")

## Closing png device
dev.off()

