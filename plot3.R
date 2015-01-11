library(dplyr)

#reading the data

#read the file as csv with ';' separator (csv2 does it)
pwr <- read.csv2('household_power_consumption.txt', dec='.', na.strings='?')

#convert date column as date format
pwr <- mutate(pwr, Date = as.Date(Date, format='%d/%m/%Y'))

#I don't need not needed values
pwr <- pwr[pwr$Date >= as.Date("2007-02-01", "%Y-%m-%d") & pwr$Date <= as.Date("2007-02-02", "%Y-%m-%d"),]

#prepares a dateTime column from date and time columns
pwr <- mutate(pwr, DateTime = paste(Date, Time))

#convert datetime column as time format
pwr <- mutate(pwr, DateTime = as.POSIXct(DateTime, format='%Y-%m-%d %H:%M:%S'))

#convert numeric values
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Global_active_power)))
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Sub_metering_1)))
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Sub_metering_2)))
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Sub_metering_3)))

#plotting
Sys.setlocale(category = "LC_TIME", "C")
with(pwr,
     plot(
       Sub_metering_1 ~ DateTime,
       type='l',
       ylab='Energy sub metering', 
       xlab= '',
       main = '')
)

with(pwr,
     points(
       Sub_metering_2 ~ DateTime,
       col='red',
       type='l')
)

with(pwr,
     points(
       Sub_metering_3 ~ DateTime,
       col='blue',
       type='l')
)

#adding legends
legend("topright", lty=1, col=c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

filename <- 'plot3.png'
dev.copy(png, file=filename)
dev.off()