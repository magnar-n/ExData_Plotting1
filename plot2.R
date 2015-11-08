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

## Create plot (it will generate x-axis week day labels in local
## language, presmuably due to machine settings)
with(t, plot(datetime, Global_active_power, typ='l'))

## Make PNG copy
dev.copy(png, file = "plot2.png")
dev.off()  ## Close the PNG device