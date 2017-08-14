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

#### make png file and plot a time serie
par(mar=c(2,4,2,4),cex.axis=1,cex.lab=1.2)
Series<-as.ts(Data$Global_active_power)
png("./Plot2.png")
with(Data,plot.ts(Series,xaxt="n",
              type="l",ylab="Global Active Power (kilowatts)"
              ,xlab=NULL))
axis(1,at=c(1,1450,2900),labels=c("Thu","Fri","Sat"))
dev.off()