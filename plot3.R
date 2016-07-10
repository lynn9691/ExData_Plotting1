#plot3
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
Sub_metering_1 <- as.numeric(as.character(Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(Sub_metering_3))

png("plot3.png")
par(mfrow = c(1,1))
plot(Time,Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab = "", xaxt = "n")
lines(Time, Sub_metering_1)
lines(Time, Sub_metering_2, col = "red")
lines(Time, Sub_metering_3, col = "blue")
axis.POSIXct(1,Time,c(min(Time),median(Time),max(Time)), 
             format = "%Y-%m-%d %H:%M:%S",labels = c("Thu","Fri","Sat"))
legend("topright", lty = c(1,1,1), col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
