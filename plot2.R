library(dplyr)

#reading the data

#read the file as csv with ';' separator (csv2 does it)
pwr <- read.csv2('household_power_consumption.txt', dec='.')

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

#plotting
#set locale to english because french weekdays are displayed here
Sys.setlocale(category = "LC_TIME", "C")
with(pwr,
plot(
  Global_active_power ~ DateTime,
  type='l',
  ylab='Global Active Power (kilowatts)', 
  xlab= '',
  main = '')
)

filename <- 'plot2.png'
dev.copy(png, file=filename)
dev.off()