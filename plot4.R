#Download data to working directory
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./epcdata")

#Unzip data file
unzip("epcdata")

#Read in data from 2007-02-01 and 2007-02-02
dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

#Convert dates and times to Date format
library(lubridate)
dat$Date <- dmy(dat$Date)
dat$Time <- hms(dat$Time)

#Create DateTime column
dat$DateTime <- dat$Date + dat$Time

#Subset the desired dates
datsub <- subset(dat, (Date == "2007-02-01" | Date == "2007-02-02"))

#Open png graphics device
png(filename = "plot4.png")

#Set parameters for the plot to allow 4 graphs in one plot
par(mfcol = c(2, 2))

#Add 1st graph, similar to plot2
plot(datsub$DateTime, datsub$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(datsub$DateTime, datsub$Global_active_power)

#Add 2nd graph, similar to plot3
plot(datsub$DateTime, datsub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(datsub$DateTime, datsub$Sub_metering_1)
lines(datsub$DateTime, datsub$Sub_metering_2, col = "red")
lines(datsub$DateTime, datsub$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Add 3rd graph
with(datsub, plot(DateTime, Voltage, xlab = "datetime", ylab = "Voltage", type = "n"))
with(datsub, lines(DateTime, Voltage))

#Add 4th graph
with(datsub, plot(DateTime, Global_reactive_power, xlab = "datetime", type = "n"))
with(datsub, lines(DateTime, Global_reactive_power))

#Close png graphics device
dev.off()