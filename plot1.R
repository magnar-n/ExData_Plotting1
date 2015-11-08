##Data file "household_power_consumption must be
##pre-loaded into the R working directory

##Read data all as character to avoid factorisation
t <- read.table("household_power_consumption.txt", 
				header = TRUE,
				sep = ";",
				colClasses = "character",
				nrows = 2075259)

##Subset dates of interest
t <- subset(t, t$Date=="1/2/2007" | t$Date=="2/2/2007")

##Change format of date column
t[, 1] <- as.Date(t[, 1], format = "%m/%d/%Y")

##Convert numeric columns to numeric
for(i in 3:9){t[, i] <- as.numeric(t[, i])}

##Make histogram
hist(t[, 3], 
	col="red", 
	main="Global Active Power", 
	xlab="Global Active Power(kilowatts)", 
	ylab="Frequency")

#Make png copy
dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file
dev.off()  ## Close the PNG device