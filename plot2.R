t <- read.table("household_power_consumption.txt", 
				header = TRUE,
				sep = ";",
				colClasses = "character",
				nrows = 2075259)


t <- subset(t, t$Date=="1/2/2007" | t$Date=="2/2/2007")

dates <- t[[1]]
times <- t[[2]]
datetime <- paste(dates, times)
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
t$datetime <- datetime

for(i in 3:9){t[, i] <- as.numeric(t[, i])}

with(t, plot(datetime, Global_active_power, typ='l'))

dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file
dev.off()  ## Close the PNG device