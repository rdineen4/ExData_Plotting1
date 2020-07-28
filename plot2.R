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
png(filename = "plot2.png")

#Initialize scatterplot with type = "n"
plot(datsub$DateTime, datsub$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")

#Add line connecting data points
lines(datsub$DateTime, datsub$Global_active_power)

#Close png graphics device
dev.off()
