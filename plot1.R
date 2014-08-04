#Set up  working directory
setwd("C:\\Users\\rtornay\\Desktop\\DataScienceSpecialization")

#Load first lines to figure out column classes
dfTemp = read.table(".\\household_power_consumption.txt", sep = ";",header=T, fill=T, nrow =2)
classes <- sapply(dfTemp, class)

# Load data
startRow = 66637 #otherwise load all dataset and subset
df = read.table(".\\household_power_consumption.txt", 
                sep = ";",header=F, fill=T,
                colClasses = classes,na.strings = "?",#Handles classes and NA
                skip = startRow,#Skiping every day until Feb 1st, 2007
                nrow = 24*60*2)#Loading two days at 1 data point per minute
names(df) = names(dfTemp)

# #Brute force method (but does not require knowing where the interesting data starts)
# df = read.table(".\\household_power_consumption.txt", 
#                 sep = ";",header=T, fill=T,
#                 colClasses = classes,na.strings = "?")
# startDate = strptime("2007-02-01 0:0:0", "%Y-%m-%d %H:%M:%S")
# endDate = strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S") 
# df2 = subset(df, x<=endDate & x>=startDate)


#Create datetime column
df$datetime =strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")

#Set locale to get adequate weekdays
Sys.setlocale("LC_TIME", "English")

# Plot data
png(filename = "plot1.png",width = 480, height = 480) #Create device
hist(main = "Global Active Power",as.numeric(df$Global_active_power),
     col = "red",xlab = "Global Active Power (kilowatts)")
dev.off()
