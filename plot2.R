#set file location
setwd("C:\\Users\\zhent\\Desktop\\Exploratory Data Analysis\\Week 1\\Course Project 1")

#download and unzip data
if(!file.exists('data'))
dir.create('data')
fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileURL, destfile = './data/household_power_consumption.zip')
unzip('./data/household_power_consumption.zip',exdir='./data')

#read data into R
data <- read.csv("household_power_consumption.txt", header = T, na.strings = "?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"', sep = ";")
subdata <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(subdata$Date), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

#Plot2
#open device
if(!file.exists('figures'))
dir.create('figures')
png(filename = "./figures/plot2.png", width=480, height=480)

#plot figure
with(subdata, {plot(Global_active_power~Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")})
title(main="Global Active Power Vs Time")
dev.off()