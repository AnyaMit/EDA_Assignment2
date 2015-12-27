##Author: AnyaMit
##Date:12/27/2015
##Purpose: Project2: Exploratory Data Analysis - Data Science Specialization

setwd("C:/Users/Anya/Documents/EDA/Project2")

print("Make sure you download the data into your working directory first")

##reading in the data - 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
print("Data is ready")

##Format data to answer question 2: 
##Have total emissions from PM2.5 decreased in the Baltimore City from 1999 to 2008?

##Merge two datasets
merged_data <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")
print ("merge worked")

## Subset full data to Baltimore only

Baltimore <-merged_data[merged_data$fips == "24510",]

##Calculate total emissions per year

emissions_year <-ddply(Baltimore, .(year), summarize, emissions=sum(Emissions))
year<- emissions_year$year
emissions <- emissions_year$emissions

#Plot emissions over "year"

png(filename = "plot2.png", width = 480, height = 480)
plot(year,emissions)
dev.off()

print("Graph complete")
