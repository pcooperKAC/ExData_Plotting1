library(dplyr)

directory <- ""                 # set working directory, download and unzip file
setwd(directory)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./powerconsumption.zip")
unzip("powerconsumption.zip")

powerdata <- read.table("household_power_consumption.txt",     # read and filter file
                        header = TRUE, sep = ";", na.strings = "?")
target <- c("1/2/2007", "2/2/2007")
powerdata <- powerdata %>% filter(Date %in% target)

powerdata <- powerdata %>% mutate(DateTime = paste(Date, Time))   # add datetime column
powerdata$DateTime <- strptime(powerdata$DateTime, format = '%d/%m/%Y %H:%M:%S')

par(mfrow = c(2,2))   # format plots

plot(powerdata$DateTime, powerdata$Global_active_power, type = "l",  # plot active power
     xlab = '', ylab = "Global Active Power")

plot(powerdata$DateTime, powerdata$Voltage, type = "l",              # plot voltage
     xlab = "datetime", ylab = "Voltage")

plot(powerdata$DateTime, powerdata$Sub_metering_1, type = "l",       # plot sub metering
     xlab = '', ylab = "Energy sub metering")
lines(powerdata$DateTime, powerdata$Sub_metering_2, col = "red")
lines(powerdata$DateTime, powerdata$Sub_metering_3, col = "blue")
legend("top", lty = c(1,1), col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        bty = "n")

plot(powerdata$DateTime, powerdata$Global_active_power, type = "l",  # plot reactive power
     xlab = "datetime", ylab = "Global Reactive Power")

dev.copy(png, file = "plot4.png")                  # save as png
dev.off()
