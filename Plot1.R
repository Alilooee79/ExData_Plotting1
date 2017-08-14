library(dplyr)

#### download and unzip file

url.file<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url.file,destfile = "Power.consumption.zip")
unzip("Power.consumption.zip")
file<-"./household_power_consumption.txt"
field1<-grep("1/2/2007",readLines(file))[1]
Vector<-setdiff(grep("2/2/2007",readLines(file)),grep("22/2/2007|12/2/2007",readLines(file)))

#### read files and rename its columns

field2<-Vector[length(Vector)]
Data<-read.table(file,skip=field1-1,nrow=field2-field1+1,sep=";")
Data<-rename(Data,Date=V1,
             time=V2,
             Global_active_power=V3,
             Global_reactive_power=V4,
             Voltage=V5,
             Global_intensity=V6,
             Sub_metering_1=V7,
             Sub_metering_2=V8,
             Sub_metering_3=V9)
#### make png file and histogram

png("./Plot1.png")
hist(as.numeric(as.character(Data$Global_active_power)),
     col="darkorange1",main="Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()