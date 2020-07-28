#Download data to working directory
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./epcdata")

#Unzip data file
unzip("epcdata")

