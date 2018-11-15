## running dplyr package
library(dplyr)

## reading a file
fulldata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## coverting to date class
fulldata$Date <- as.Date(fulldata$Date, "%d/%m/%Y")

## substracting chosen date
chosenDate <- rbind(fulldata[fulldata$Date == "2007-02-01",], fulldata[fulldata$Date == "2007-02-02",])

## substracting DateTime and Global Acitve Power data
Plot2Data <- chosenDate %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S"))) %>% select(DateTime, Global_active_power)

## plotting data
with(Plot2Data, plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power (kilowatts)"))

## printing png file
png(filename = "plot2.png", width = 480, height = 480, units = "px")