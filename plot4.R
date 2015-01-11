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
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Voltage)))
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Global_reactive_power)))
pwr <- mutate(pwr, Global_active_power = as.numeric(as.character(Global_intensity)))

#plotting
Sys.setlocale(category = "LC_TIME", "English")

#will be filled column afeter column, 2 rows per columns
par(mfcol=c(2,2))

#(1,1) Global_active_power
# X O
# O O
plot(
 pwr$Global_active_power ~ pwr$DateTime,
 type='l',
 ylab='Global Active Power (kilowatts)', 
 xlab= '',
 main = ''
 )


#(2,1) Energy sub metering
# O O
# X O
plot(
  pwr$Sub_metering_1 ~  pwr$DateTime,
  type='l',
  ylab='Energy sub metering'
 )
points(
 pwr$Sub_metering_2 ~ pwr$DateTime,
 col='red',
 type='l')
points(
 pwr$Sub_metering_3 ~ pwr$DateTime,
 col='blue',
 type='l')

#(1,2) Voltage
# O X
# O O
plot(
  pwr$Voltage ~  pwr$DateTime,
  type='l',
  xlab='datetime',
  ylab='Voltage'
  )

#(2,2) Global_reactive_power
# O O
# O X
plot(
  pwr$Global_reactive_power ~  pwr$DateTime,
  type='l',
  xlab='datetime',
  ylab='Global_reactive_power'
  )


filename <- 'plot4.png'
dev.copy(png, file=filename)
dev.off()