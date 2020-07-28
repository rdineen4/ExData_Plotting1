#Download data to working directory
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./epcdata")

#Unzip data file
unzip("epcdata")

#Read in data from 2007-02-01 and 2007-02-02
dat <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

#Convert dates to Date format
library(lubridate)
dat$Date <- dmy(dat$Date)

#Subset the desired dates
datsub <- subset(dat, (Date == "2007-02-01" | Date == "2007-02-02"))

#Open png graphics device
png(filename = "plot1.png")

#Create Histogram
hist(datsub$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Close png graphics device
dev.off()
