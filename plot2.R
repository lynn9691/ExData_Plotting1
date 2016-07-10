#plot2
#read in data
hhpower <- read.table("household_power_consumption.txt",
                      header = TRUE, sep = ";")

#subset data by date

library(lubridate)
hhpower$Date <- as.Date(hhpower$Date, format = "%d/%m/%Y")
hhpower$Time <- strptime(hhpower$Time, format = "%H:%M:%S")
hhpower <- subset(hhpower, Date == "2007-02-01" | Date == "2007-02-02")
date(hhpower$Time) <- hhpower$Date

attach(hhpower)
#remove missing values
Global_active_power <- as.numeric(as.character(Global_active_power))

png("plot2.png")
par(mfrow = c(1,1))
plot(Time,Global_active_power, type = "n", 
     ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
lines(Time, Global_active_power)
axis.POSIXct(1,Time,c(min(Time),median(Time),max(Time)), 
             format = "%Y-%m-%d %H:%M:%S",labels = c("Thu","Fri","Sat"))
dev.off()
