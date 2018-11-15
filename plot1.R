## running dplyr package
library(dplyr)

## reading a file
fulldata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## coverting to date class
fulldata$Date <- as.Date(fulldata$Date, "%d/%m/%Y")

## substracting chosen date
chosenDate <- rbind(fulldata[fulldata$Date == "2007-02-01",], fulldata[fulldata$Date == "2007-02-02",])

## printing png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

## drawing histogram 
hist(chosenDate$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## closing plotted file
dev.off()