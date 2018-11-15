## running dplyr package
library(dplyr)

## reading a file
fulldata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## coverting to date class
fulldata$Date <- as.Date(fulldata$Date, "%d/%m/%Y")

## substracting chosen date
chosenDate <- rbind(fulldata[fulldata$Date == "2007-02-01",], fulldata[fulldata$Date == "2007-02-02",])

## merging and convert date and time data
Plot4Data <- chosenDate %>% mutate(DateTime = as.POSIXct(strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S")))

## printing png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## making 2x2 plotting frame
par(mfrow=c(2,2))

## plotting each data
#1
with(Plot4Data, plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
#2
with(Plot4Data, plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "datetime"))
#3
with(Plot4Data, plot(Sub_metering_1 ~ DateTime, type="l", ylab = "Energy sub metering", xlab = ""))
with(Plot4Data, lines(Sub_metering_2 ~ DateTime, type="l", col = "Red"))
with(Plot4Data, lines(Sub_metering_3 ~ DateTime, type="l", col = "Blue"))
legend("topright", lty = 1, lwd = 3, col = c("black", "red", "blue"), bty = "n" ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#4
with(Plot4Data, plot(Global_reactive_power ~ DateTime, type= "l", ylab = "Global_reactive_power", xlab = "datetime"))

## closing plotted file
dev.off()
