t <- read.table("household_power_consumption.txt", 
				header = TRUE,
				sep = ";",
				colClasses = "character",
				nrows = 2075259)


t <- subset(t, t$Date=="1/2/2007" | t$Date=="2/2/2007")

t[, 1] <- as.Date(t[, 1], format = "%m/%d/%Y")

for(i in 3:9){t[, i] <- as.numeric(t[, i])}

hist(t[, 3], 
	col="red", 
	main="Global Active Power", 
	xlab="Global Active Power(kilowatts)", 
	ylab="Frequency")

dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off()  ## Close the PNG device