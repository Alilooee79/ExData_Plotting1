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

#### make png file and plot three time series on a same coordiante system
png("./Plot3.png")
with(Data, plot.ts(Sub_metering_1,xaxt="n",
                  type="l",ylab="Energy Sub metering",xlab=NULL))
par(new=TRUE)
with(Data, plot.ts(Sub_metering_2,xaxt="n",yaxt="n",col="red",
        type="l",ylab=NULL,xlab=NULL,ylim=c(0,40)))
par(new=TRUE)
with(Data, plot.ts(Sub_metering_3,xaxt="n",yaxt="n",col="blue",
                   type="l",ylab=NULL,xlab=NULL,ylim=c(0,40)))
axis(1,at=c(1,1450,2900),labels=c("Thu","Fri","Sat"))
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()