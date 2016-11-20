## This file provides a solution to Project #1 Plot#2

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


##Plot Global Active Power versus DateTime
##On screen

par(mfrow=c(1,1),mar=c(4,4,2,2))
with(pwrData4,plot(DtTm,Global_active_power,
                   type="l",
                   ylab="Global Active Power - KW",
                   xlab=""))



##Plot Global Active Power versus DateTime
##On PNG file

png("plot2.png")

with(pwrData4,plot(DtTm,Global_active_power,
                   type="l",
                   ylab="Global Active Power - KW",
                   xlab=""))

dev.off()