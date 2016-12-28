# create temporary file to store downloaded data file
temporaryfile <- tempfile()

# download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temporaryfile, mode = "wb")

# unzip temporary data file and read in csv file
power.c <- read.csv(unz(temporaryfile, "household_power_consumption.txt"),
                    sep = ";", na.strings = "?")

#delete temporary file
unlink(temporaryfile)

# subset data to specific time range 
power.c.subset <- subset(power.c, power.c$Date == "1/2/2007" | power.c$Date == "2/2/2007")

# initialize writting plots to png file
png(file = "plot2.png", width = 480, height = 480)

# create plot
with(power.c.subset, plot(strptime(paste(power.c.subset$Date, power.c.subset$Time), format = "%d/%m/%Y %H:%M:%S"),
                          Global_active_power, col = "black", xlab = "", ylab = "Global Active Power (kilowatts)",
                          type = "l"))

# close/save png file
dev.off()

# clean up variables added to environment
rm(power.c)
rm(power.c.subset)
rm(temporaryfile)

# call garbage collector to clear any memory still allocated to variables used in this script
gc()