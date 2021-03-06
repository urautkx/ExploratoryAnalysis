## This file provides a solution to Project #1 Plot3

## Clear memory to make room for reading huge dataset
rm(list=ls())

## Import required libraries
library(dplyr)


## Read the data set
pwrData<-read.csv2("PowerConsumption/household_power_consumption.txt",header=TRUE)

##Filter the data set and extract out the data for first two days of Feb 2007

pwrData2<-pwrData[pwrData$Date %in% c('1/2/2007','2/2/2007'),]

##Convert the Date and Time variables into one DateTime variable of class "POSIXct"
pwrData2$DateTime<-paste(pwrData2$Date,pwrData2$Time)
pwrData2$DateTime<-strptime(pwrData2$DateTime,format="%d/%m/%Y %H:%M:%S")

##Convert the data that is of class 'factor' into numeric and put it in a new dataframe
pwrData3<-sapply(select(pwrData2,3:9),as.numeric)
pwrData4<-cbind(DtTm=pwrData2[,10],data.frame(pwrData3[,1:7]))

##Analysis of data on Sub_metering_2 shows that there is an abnormal value of 14 in some rows 
##lasing for a minute at a time. Normally the value of this variable is approx 2.
##Given this sub metering is for laundry room and refrigerator a brief high value seems like a 
##fluctuation or bad data
##Assuming the "14" is an abnormal value, lets eliminate those record which has
##Sub_metering_2 as 14

pwrData5<-filter(pwrData4,!(pwrData4$Sub_metering_2==14))


##Analysis of data on Sub_metering_3 shows that this variable has a normal value in the range of
##of less than 10 or less than 20. There are some value which are as high as 30 for a minute or two
##Given that this submetering is for water heater and air-conditioner, brief high values 
##could just be fluctuations or bad data.
##
## Considering value above 20 as anomaly, eliminate the records which has sub_metering_3 
## as above 20

pwrData6<-filter(pwrData5,!(pwrData5$Sub_metering_3>20))


##Plot Energy Sub Metering versus DateTime
##On screen

par(mfrow=c(1,1),mar=c(4,4,2,2))

with(pwrData6,plot(DtTm,Sub_metering_1,
                   type="l",
                   ylab="Energy sub metering",
                   xlab=""))


with(pwrData6,points(DtTm,Sub_metering_2,
                     type="l",
                     col="Red"))


with(pwrData6,points(DtTm,Sub_metering_3,
                     type="l",
                     col="Blue"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=1 
       ,col = c("Black","Red","Blue"))


##Plot Energy Sub Metering versus DateTime
##On PNG file

png("plot3.png")

with(pwrData6,plot(DtTm,Sub_metering_1,
                   type="l",
                   ylab="Energy sub metering",
                   xlab=""))


with(pwrData6,points(DtTm,Sub_metering_2,
                     type="l",
                     col="Red"))


with(pwrData6,points(DtTm,Sub_metering_3,
                     type="l",
                     col="Blue"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=1 
       ,col = c("Black","Red","Blue"))


dev.off()