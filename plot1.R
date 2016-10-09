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

hist(powerdata$Global_active_power,                # plot histogram
     col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")                  # save as png
dev.off()