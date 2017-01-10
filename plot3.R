install.packages("data.table")
install.packages("dplyr")
library(data.table)
library(dplyr)
library(chron)

#Create variable names
varNames <- c("date", "time", "global_active_power","global_reactive_power",
              "voltage","global_intensity","sub_metering_1","sub_metering_2",
              "sub_metering_3")

#Import file from working directory
data <- as.data.frame(fread("household_power_consumption.txt", sep=";", col.names=varNames,
                            na.strings="?"))

#Convert "date" to date class& "time" columns to date/time class
data$date <- as.Date(data$date,"%d/%m/%Y")

#Subset data for date only "2007-02-01" or "2007-02-02"
newData <- subset(data,date == "2007-02-01" | date == "2007-02-02")

#Convert "time" to date/time class
newData$time <- strptime(paste(as.character.Date(newData$date),newData$time),
                         "%Y-%m-%d %H:%M:%S")

#Plot 3
png("plot3.png", width=480, height=480)
par(mar=c(6,6,4,2))
plot(newData$time, newData$sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="")
lines(newData$time, newData$sub_metering_2, type="l",col="orangered2",
      ylab="Energy sub metering")
lines(newData$time, newData$sub_metering_3, type="l",col="blue",
      ylab="Energy sub metering")
legend(x="topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
       col=c("black","orangered2","blue"), lwd=1)
dev.off()