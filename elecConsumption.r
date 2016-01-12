## elecConsumption.r
## 
# 
# Data Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#   
#   Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

## Assignment
# Our overall goal here is simply to examine how household energy usage varies over a 2 -
#   day period in February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
# 
# First you will need to fork and clone the following GitHub repository:https: /
#   / github.com / rdpeng / ExData_Plotting1
# 
# For each plot you should
# 
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 
# Name each of the plot files as plot1.png, plot2.png, etc.
# 
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file.
# 
# Add the PNG file and R code file to your git repository
# 
# When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. There should be four PNG files and four R code files.

library(sqldf)

uri = file("data/household_power_consumption.txt")

## read into SQLite database
elec = sqldf("select * from uri where Date=\'1/2/2007\' or Date=\'2/2/2007\';", dbname = tempfile(), file.format = 
                list(header = T, row.names = F, sep=";"))

names(elec)
elec$Timestamp = paste(elec$Date, elec$Time, sep=" ")
elec$Timestamp = strptime(elec$Timestamp, format="%d/%m/%Y %H:%M:%S")
elec$Date = as.Date(elec$Date, format="%d/%m/%Y")
View(elec)

## plot 1
png(file = "./plot1.png", height=480, width=480)
par(mfrow=c(1,1))
hist(elec$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()


## plot 2
png(file = "./plot2.png", height=480, width=480)
par(mfrow=c(1,1))
plot(x=elec$Timestamp, y=elec$Global_active_power, type="l", ylab="Global Active Power (kilowatts)")
dev.off()

## plot 3
png(file = "./plot3.png", height=480, width=480)
par(mfrow=c(1,1))
plot(x=elec$Timestamp, y=elec$Sub_metering_1, type="l", ylab="Energy sub metering")
lines(x=elec$Timestamp, y=elec$Sub_metering_2, col="red")
lines(x=elec$Timestamp, y=elec$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1),
       col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       )
dev.off()

## plot 4
png(file = "./plot4.png", height=480, width=480)
par(mfrow = c(2,2))
## plot1
plot(x=elec$Timestamp, y=elec$Global_active_power, type="l", ylab ="Global Active Power", xlab="")
## plot2
plot(x=elec$Timestamp, y=elec$Voltage, type="l", ylab="Voltage", xlab="datetime")
## plot3
plot(x=elec$Timestamp, y=elec$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="")
lines(x=elec$Timestamp, y=elec$Sub_metering_2, col = "red")
lines(x=elec$Timestamp, y=elec$Sub_metering_3, col = "blue")
legend(
  "topright", lty = c(1,1),
  col = c("black", "red", "blue"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
## plot4
plot(x=elec$Timestamp, y=elec$Global_reactive_power, type="l", xlab="datetime")
dev.off()