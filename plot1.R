#plot1
#read in data
hhpower <- read.table("household_power_consumption.txt",
                   header = TRUE, sep = ";")

#subset data by date
hhpower$Date <- as.Date(hhpower$Date, format = "%d/%m/%Y")
hhpower <- subset(hhpower, Date == "2007-02-01" | Date == "2007-02-02")

attach(hhpower)

#remove missing values
Global_active_power <- as.numeric(as.character(Global_active_power))

png("plot1.png")
par(mfrow = c(1,1))
hist(Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

detach(hhpower)
