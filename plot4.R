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
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(fileConnection), value=TRUE), sep="\n", file="plot4.txt")

## Closing file connection
close(fileConnection)

## Reading filtered file
plot4 <- fread("plot4.txt", sep=";", header=TRUE, na.strings="?")

## Parse the date format
datetime <- paste(as.Date(plot4$Date, format="%d/%m/%Y"), plot4$Time) 
plot4$Datetime <- as.POSIXct(datetime)
                               

## Plotting the required chart
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(2,2,2,0))
with(plot4, {
  plot(Global_active_power~Datetime, type="l", ylab="Global Active Power", xlab="")
  
  plot(Voltage~Datetime, type="l", ylab="Voltage", xlab="datetime")
  
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~Datetime, type="l", ylab="Global_reactive_power",xlab="datetime")
})


## COpying plot to png file
dev.copy(png, file="plot4.png")

## Closing png device
dev.off()

