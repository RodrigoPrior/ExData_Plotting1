## Solve cp1

# set working dir
setwd("~/desenvolvimento/coursera/ExploratoryDataAnalysis/CourseProject1/ExData_Plotting1")
getwd()

# create data folder
if (!file.exists("data")) {
    dir.create("data")
}

# download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
list.files("./data")
dateDownloaded <- date()

# load data
## We will only be using data from the dates 2007-02-01 and 2007-02-02.
## One alternative is to read the data from just those dates rather than
## reading in the entire dataset and subsetting to those dates.
workData <- read.csv(
    # unz = unzip file
    unz("./data/household_power_consumption.zip", "household_power_consumption.txt"),
    sep = ";",
    skip = 66637, # line 66638 from egrep -n -e 1\/2\/2007 household_power_consumption.txt
    nrows = 2880, #  line 69518 from egrep -n -e 3\/2\/2007 household_power_consumption.txt
    header = FALSE)
head(workData)
tail(workData)

# create detetime to join date and time columns
# convert and set datetime column
library(lubridate)
workData$DATAHORA <- dmy_hms(paste(workData$V1,workData$V2))

# start ploting stuf
png(filename="plot4.png")

par(mfrow = c(2, 2))

with(workData, {
    # plot 11
    plot(DATAHORA,V3,type="l",ylab="Global Active Power",xlab="",)
    # plot 12
    plot(DATAHORA,V5,type="l",ylab="voltage",xlab="datetime",)
    # plot21
    plot(DATAHORA,V7,type="l",ylab="Energy sub metering",xlab="",)
    with(subset(workData), points(DATAHORA, V9, type="l", col="blue"))
    with(subset(workData), points(DATAHORA, V8, type="l", col="red"))
    legend("topright", pch='_', bty = "n",
           col = c("black","blue", "red"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    # plot 22
    plot(DATAHORA,V4,type="l",ylab="Global_reactive_power",xlab="datetime",)
}
)
dev.off()

