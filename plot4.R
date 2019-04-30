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

#Plot4
#open device
if(!file.exists('figures'))
dir.create('figures')
png(filename = "./figures/plot4.png", width=480, height=480)

#plot figure
par(mfrow=c(2,2), mar=c(4,4,2,1),oma=c(0,0,2,0))
with(subdata,
	{
	#plot1
	plot(Global_active_power~Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
	#plot2
	plot(Voltage~Datetime, type="l", xlab="datetime", ylab="Voltage (Volt)")
	#plot3
	with(subdata, {plot(Sub_metering_1~Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
	lines(Sub_metering_2~Datetime, col='Red')
	lines(Sub_metering_3~Datetime, col='Blue')
	})
	legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	#plot4
	plot(Global_reactive_power~Datetime, type="l", xlab="datetime", ylab="Global_reactive_power")
})

dev.off()