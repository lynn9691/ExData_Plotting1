#plot4
#read in data
hhpower <- read.table("household_power_consumption.txt",
                      header = TRUE, sep = ";")

#subset data by date

library(lubridate)
hhpower$Date <- as.Date(hhpower$Date, format = "%d/%m/%Y")
hhpower <- subset(hhpower, Date == "2007-02-01" | Date == "2007-02-02")
hhpower$Time <- strptime(hhpower$Time, format = "%H:%M:%S")
date(hhpower$Time) <- hhpower$Date

attach(hhpower)
#remove missing values
Global_active_power <- as.numeric(as.character(Global_active_power))
Voltage <- as.numeric(as.character(Voltage))
Sub_metering_1 <- as.numeric(as.character(Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(Sub_metering_3))
Global_reactive_power <- as.numeric(as.character(Global_reactive_power))

png("plot4.png")
par(mfrow = c(2,2))

#first graph
plot(Time, Global_active_power, type = "n", xaxt = "n",
     xlab = "", ylab = "Global Active Power")
lines(Time, Global_active_power)
axis.POSIXct(1,Time,c(min(Time),median(Time),max(Time)), 
             format = "%Y-%m-%d %H:%M:%S",labels = c("Thu","Fri","Sat"))

#second graph
plot(Time, Voltage, type = "n", xaxt = "n",
     xlab = "datetime", ylab = "Voltage")
lines(Time, Voltage)
axis.POSIXct(1,Time,c(min(Time),median(Time),max(Time)), 
             format = "%Y-%m-%d %H:%M:%S",labels = c("Thu","Fri","Sat"))

#third graph
plot(Time,Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(Time, Sub_metering_1)
lines(Time, Sub_metering_2, col = "red")
lines(Time, Sub_metering_3, col = "blue")
axis.POSIXct(1,Time,c(min(Time),median(Time),max(Time)), 
             format = "%Y-%m-%d %H:%M:%S",labels = c("Thu","Fri","Sat"))
legend("topright", box.col = "transparent", lty = c(1,1,1), col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#fourth graph
plot(Time, Global_reactive_power, type = "n", xaxt = "n",
     xlab = "datetime", ylab = "Global_reactive_power")
lines(Time, Global_reactive_power)
axis.POSIXct(1,Time,c(min(Time),median(Time),max(Time)), 
             format = "%Y-%m-%d %H:%M:%S",labels = c("Thu","Fri","Sat"))

dev.off()
