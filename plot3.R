#Set up  working directory
setwd("C:\\Users\\rtornay\\Desktop\\DataScienceSpecialization")

#Load first lines to figure out column classes
dfTemp = read.table(".\\household_power_consumption.txt", sep = ";",header=T, fill=T, nrow =2)
classes <- sapply(dfTemp, class)

# Load data
startRow = 66637
df = read.table(".\\household_power_consumption.txt", 
                sep = ";",header=F, fill=T,
                colClasses = classes,na.strings = "?",#Handles classes and NA
                skip = startRow,#Skiping every day until Feb 1st, 2007
                nrow = 24*60*2)#Loading two days at 1 data point per minute
names(df) = names(dfTemp)
#Create datetime column
df$datetime =strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

#Set locale to get adequate weekdays
Sys.setlocale("LC_TIME", "English")

# Plot 3
png(filename = "plot3.png",width = 480, height = 480)
plot(x = df$datetime,y = df$Sub_metering_1,
     type = "l", xlab = "",ylab = "Energy sub metering")
lines(x = df$datetime,y = df$Sub_metering_2, col = "red")
lines(x = df$datetime,y = df$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black","red","blue")) 
dev.off()
