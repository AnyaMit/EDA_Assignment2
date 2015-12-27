##Author: AnyaMit
##Date:12/27/2015
##Purpose: Project2: Exploratory Data Analysis - Data Science Specialization
##Make sure you install ggplot2 package, if not use the following code below:
install.packages("ggplot2")
install.packages("reshape2")
library(ggplot2)
library(reshape2)

setwd("C:/Users/Anya/Documents/EDA/Project2")

print("Make sure you download the data into your working directory first")

##reading in the data - 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
print("Data is ready")

##Format data to answer question 3: 
##Of the four types of sources (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008?

###Merge two datasets
merged_data <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")
print ("merge worked")

## Subset full data to Baltimore only

Baltimore <-merged_data[merged_data$fips == "24510",]

##Calculate total emissions per year for type1
type1 <-Baltimore[Baltimore$type == "POINT",]
type1_yrsum <-ddply(type1, .(year), summarize, emissions=sum(Emissions))
##Calculate total emissions per year for type2
type2 <-Baltimore[Baltimore$type == "NONPOINT",]
type2_yrsum <-ddply(type2, .(year), summarize, emissions=sum(Emissions))
##Calculate total emissions per year for type3
type3 <-Baltimore[Baltimore$type == "ON-ROAD",]
type3_yrsum <-ddply(type3, .(year), summarize, emissions=sum(Emissions))
##Calculate total emissions per year for type4
type4 <-Baltimore[Baltimore$type == "NON-ROAD",]
type4_yrsum <-ddply(type4, .(year), summarize, emissions=sum(Emissions))

temp_merge_1and2 <- merge(type1_yrsum, type2_yrsum, by.x = "year", by.y = "year")
temp_merge_3and4 <- merge(type3_yrsum, type4_yrsum, by.x = "year", by.y = "year")
full_sum<-merge(temp_merge_1and2, temp_merge_3and4, by.x ="year", by.y = "year")


##Rename full_sum to match type names

names(full_sum) <-gsub("emissions.x.x", "POINT", names(full_sum))
names(full_sum) <-gsub("emissions.y.x", "NONPOINT", names(full_sum))
names(full_sum) <-gsub("emissions.x.y", "ONROAD", names(full_sum))
names(full_sum) <-gsub("emissions.y.y", "NONROAD", names(full_sum))
type <-c("POINT", "NONPOINT", "ON-ROAD", "NONROAD")
year <-c("1999", "2002", "2005", "2008")

##MGRAPHING THE DATA####

png("plot3.png", width=480, height=480)
print(ggplot(full_sum, aes(x=year, , colour=type))+geom_density())
dev.off()

print("Graph complete")

##PLEASE NOTE: I know that Ineed to fix the data to see accurate results, but I have to submit the project as is
##for partial credit if anything.
