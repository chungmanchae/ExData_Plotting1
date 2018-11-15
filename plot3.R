## running dplyr package
library(dplyr)

## reading a file
fulldata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## coverting to date class
fulldata$Date <- as.Date(fulldata$Date, "%d/%m/%Y")

## substracting chosen date
chosenDate <- rbind(fulldata[fulldata$Date == "2007-02-01",], fulldata[fulldata$Date == "2007-02-02",])

## substracting DateTime and Sub metering data
Plot3Data <- chosenDate %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))) %>% select(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

## plotting data
with(Plot3Data, plot(Sub_metering_1 ~ DateTime, type="l", ylab = "Energy sub metering"))
with(Plot3Data, lines(Sub_metering_2 ~ DateTime, type="l", col = "Red"))
with(Plot3Data, lines(Sub_metering_3 ~ DateTime, type="l", col = "Blue"))

## adding legend
legend("topright", lty = 1, lwd = 3, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## printing png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")