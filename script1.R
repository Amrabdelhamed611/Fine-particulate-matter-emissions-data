##PM2.5(dust) emission from all sources for each of the years 1999, 2002, 2005, and 2008 in USA
#download the data from the link
if(!file.exists("Dataset.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(url, destfile= "Dataset.zip") 
}
##unzip the data
if(!file.exists('household_power_consumption.txt')  ){
    unzip("Dataset.zip" ) 
}
## read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##Have total emissions from PM2.5 decreased in the US from 1999 to 2008?accourding to the data
##Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##sources for each of the years 1999, 2002, 2005, and 2008.
png(filename = "plot1.png",width = 480, height = 480)
yearTotalEmissions <-with(NEI,tapply(Emissions, year, FUN = sum,na.rm = "True"))
plot((names(yearTotalEmissions)) ,
     yearTotalEmissions/10**6 ,
     xlab ="year",
     ylab="PM2.5 Emissions (millions tons)" ,
     pch = 19,
     col = "red",
     xaxt="none",
     main = "Total PM2.5 Emissions for each year")
lines(x=names(yearTotalEmissions),y= yearTotalEmissions/10**6,lwd = 2,type = "c")
axis(1, names(yearTotalEmissions))
dev.off()