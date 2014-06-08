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
download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
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
# start ploting stuf
png(filename="plot1.png")
hist(workData$V3,
     main="Global Active Power",  ## Add a title
     xlab="Global Active Power (kilowatts)",
     col="red"
)
dev.off()
