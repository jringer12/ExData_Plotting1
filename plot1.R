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

#Plot 1
png("plot1.png", width=480, height=480)
par(mar=c(6,6,4,2))
hist(newData$global_active_power, main = "Global Active Power", col="orangered2",
     xlab="Global Active Power (kilowatts)")
dev.off()
