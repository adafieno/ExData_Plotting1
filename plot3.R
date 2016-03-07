## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##
## Exploratory Data Analysis - Week 1 Project
## Creates a png histogram for Energy sub-metering by day of the week
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
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(fileConnection), value=TRUE), sep="\n", file="plot3.txt")

## Closing file connection
close(fileConnection)

## Reading filtered file
plot3 <- fread("plot3.txt", sep=";", header=TRUE, na.strings="?")

## Parse the date format
datetime <- paste(as.Date(plot3$Date, format="%d/%m/%Y"), plot3$Time) 
plot3$Datetime <- as.POSIXct(datetime)
                               

## Plotting the required chart
with(plot3, { 
    plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="") 
    lines(Sub_metering_2~Datetime,col='red') 
    lines(Sub_metering_3~Datetime,col='blue') 
    }) 

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 


## COpying plot to png file
dev.copy(png, file="plot3.png")

## Closing png device
dev.off()

