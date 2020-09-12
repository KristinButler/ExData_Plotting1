#Load packages
library(lubridate)
library(data.table)
library(dplyr)

#Set working directory
setwd("C:/Users/Kristin.Butler/Desktop/Coursera/ExploratoryDataAnalysis/Week1")

#Import data and examine 
data <- read.table("C:/Users/Kristin.Butler/Desktop/Coursera/ExploratoryDataAnalysis/Week1/household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)
str(data)
dim(data)

#Create a column named DateTime
data$DateTime = dmy_hms(paste(data$Date, data$Time))
data$DateTime


#Extract a table from only two dates and examine data
data$Date <- as.Date(data$Date, "%d/%m/%Y")
dataSub <- data %>% filter(Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
str(dataSub)

min(dataSub$Date)
max(dataSub$Date)


# Plot 1
#remove data with "?"
dataP1 <- subset(dataSub, data$Global_active_power != "?")
dataP1$Global_active_power <- as.numeric(dataP1$Global_active_power)
str(dataP1)

png(filename = "plot1.png", width = 480, height = 480)
hist(dataP1$Global_active_power, col = "red", main = "Global Active Power", xlab= "Global Active Power (kilowatts)")
dev.off()

#Plot 2

png(filename = "plot2.png", width = 480, height = 480)
plot(dataP1$DateTime, dataP1$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()   
 

#Plot 3

png(filename = "plot3.png", width = 480, height = 480)
plot(dataP1$DateTime, dataP1$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(dataP1$DateTime, dataP1$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")     
lines(dataP1$DateTime, dataP1$Sub_metering_2, type = "l", ylab = "Energy sub metering", xlab = "", col = "red")    
lines(dataP1$DateTime, dataP1$Sub_metering_3, type = "l", ylab = "Energy sub metering", xlab = "", col = "blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

#Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow= c(2,2))
plot(dataP1$DateTime, dataP1$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(dataP1$DateTime, dataP1$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(dataP1$DateTime, dataP1$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(dataP1$DateTime, dataP1$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")     
lines(dataP1$DateTime, dataP1$Sub_metering_2, type = "l", ylab = "Energy sub metering", xlab = "", col = "red")    
lines(dataP1$DateTime, dataP1$Sub_metering_3, type = "l", ylab = "Energy sub metering", xlab = "", col = "blue")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = 'n')
plot(dataP1$DateTime, dataP1$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
