## Data set "household_power_consumption.txt" must be pre-loaded
## into working directory

## Read data, all as character to avoid factorisation
t <- read.table("household_power_consumption.txt", 
				header = TRUE,
				sep = ";",
				colClasses = "character",
				nrows = 2075259)

## Subset dates of interest
t <- subset(t, t$Date=="1/2/2007" | t$Date=="2/2/2007")

## Create continous date and time column by merging date and
## time columns and adding the new column to the data frame
dates <- t[[1]]
times <- t[[2]]
datetime <- paste(dates, times)
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
t$datetime <- datetime

## Convert numeric columns to numeric
for(i in 3:9){t[, i] <- as.numeric(t[, i])}

## Set par to produce four plots in one graphic
par(mfcol=c(2, 2))

# First plot
with(t, plot(datetime, Global_active_power, typ='l'))

## Second plot
with(t, plot(datetime, Sub_metering_1, 
		typ='l',
		xlab="Time", 
		ylab="Global sub metering",
		ylim=c(0, 40)))
par(new=T)
with(t, plot(datetime, Sub_metering_2, 
		col="red", 
		typ='l', 
		xlab=NA, 
		ylab=NA, 
		ylim=c(0, 40)))
par(new=T)
with(t, plot(datetime, Sub_metering_3, 
		col="blue", 
		typ='l', 
		xlab=NA, 
		ylab=NA, 
		ylim=c(0, 40)))
legend("topright", 
	legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
	lty=1, col=c("black", "blue", "red"))

# Third plot
with(t, plot(datetime, Voltage, typ='l'))

# Fourth plot
with(t, plot(datetime, Global_reactive_power, typ='l'))

dev.copy(png, file = "plot4.png")  ## Copy my plot to a PNG file
dev.off()  ## Close the PNG device