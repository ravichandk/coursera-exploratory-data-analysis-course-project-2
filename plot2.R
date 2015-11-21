##Reading dataset from the file. This may take a while.
if(!exists("summarySCCPM25")) {
	summarySCCPM25 <- readRDS("summarySCC_PM25.RDS")
}

if(!exists("Source_Classification_Code")) {
	Source_Classification_Code <- readRDS("Source_Classification_Code.RDS")
}

## Filter the PM2.5 in Baltimore City, Maryland (fips == "24510")
baltimoreSummarySCCPM25 <- subset(summarySCCPM25, fips == "24510")

## Get total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008
baltimoreAggregateByYear <- aggregate(Emissions~year, baltimoreSummarySCCPM25, sum)

png("plot2.png")

## Plot the data using BASE plot.
barplot(height = baltimoreAggregateByYear$Emissions, names.arg = baltimoreAggregateByYear$year, xlab = "years", ylab = "Total PM 2.5 Emission in Baltimore", main="Year wise total PM 2.5 Emissions in Baltimore")

dev.off()
