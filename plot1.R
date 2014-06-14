# Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot1.png")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)
emissions <- tapply(NEI$Emissions, as.factor(NEI$year), sum)
plot(levels(as.factor(NEI$year)), emissions, type="l", 
      xlab = "Year", ylab = "Emissions (tons)", 
      main = "Emissions per year in the United States")
dev.off()