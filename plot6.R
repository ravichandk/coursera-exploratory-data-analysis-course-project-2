##Reading dataset from the file. This may take a while.
if(!exists("summarySCCPM25")) {
	summarySCCPM25 <- readRDS("summarySCC_PM25.RDS")
}

if(!exists("Source_Classification_Code")) {
	Source_Classification_Code <- readRDS("Source_Classification_Code.RDS")
}

## Merge the data sets get the classifications.
if(!exists("summarySCCPM25WithClassification")) {
	summarySCCPM25WithClassification <- merge(summarySCCPM25, Source_Classification_Code, by="SCC")
}

## Emissions from motor vehicle sources in Baltimore city
baltimoreVehicleData <- subset(summarySCCPM25WithClassification, fips=="24510" & type=="ON-ROAD")

## Emissions from motor vehicle sources in LosAngeles city
losangelesVehicleData <- subset(summarySCCPM25WithClassification, fips=="06037" & type=="ON-ROAD")

## Total PM2.5 Emissions from motor vehicle sources in Baltimore city
baltimoreAggregateByYear <- aggregate(Emissions~year+fips, baltimoreVehicleData, sum)

## Total PM2.5 Emissions from motor vehicle sources in LosAngeles city
losangelesAggregateByYear <- aggregate(Emissions~year+fips, losangelesVehicleData, sum)

## Add County name so that it can be displayed on the plot
baltimoreAggregateByYear$county <- "Baltimore City, MD"
losangelesAggregateByYear$county <- "Los Angeles, CA"
aggregateByYear <- rbind(baltimoreAggregateByYear, losangelesAggregateByYear)

library(ggplot2)

png("plot6.png", width=640, height=480)

## Use ggplot system to plot the above data.
g <- ggplot(aggregateByYear, aes(x=factor(year), y=Emissions)) 
g <- g + facet_grid(. ~ county)
g <- g + geom_bar(stat = "identity") 
g <- g + xlab("year") + ylab("Total PM 2.5 Emissions") 
g <- g + ggtitle("Total Emissions from motor vehicle in Baltimore City, MD vs Los Angeles, CA 1999-2008")

print(g)
 
dev.off()