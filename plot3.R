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
png(filename = "plot3.png")

#Initialize scatterplot with type = "n"
plot(datsub$DateTime, datsub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")

#Add lines for each sub metering
lines(datsub$DateTime, datsub$Sub_metering_1)
lines(datsub$DateTime, datsub$Sub_metering_2, col = "red")
lines(datsub$DateTime, datsub$Sub_metering_3, col = "blue")

#Create a legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close png graphics device
dev.off()
