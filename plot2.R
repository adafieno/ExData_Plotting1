## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##
## Exploratory Data Analysis - Week 1 Project
## Creates a png histogram for Global Active Power by day of the week
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
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(fileConnection), value=TRUE), sep="\n", file="plot2.txt")

## Closing file connection
close(fileConnection)

## Reading filtered file
plot2 <- fread("plot2.txt", sep=";", header=TRUE, na.strings="?")

## Parse the date format
datetime <- paste(as.Date(plot2$Date, format="%d/%m/%Y"), plot2$Time) 
plot2$Datetime <- as.POSIXct(datetime)
                               

## Plotting the required chart
with(plot2, plot(Global_active_power~Datetime, xlab="", type="l", ylab="Global Active Power (kilowatts)"))

## COpying plot to png file
dev.copy(png, file="plot2.png")

## Closing png device
dev.off()

