# Reading data
message("Reading data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

message("Starting plot")
png("plot2.png")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)
baltimore <- NEI[NEI$fips == "24510",]
emissions <- tapply(baltimore$Emissions, as.factor(baltimore$year), sum)
plot(levels(as.factor(baltimore$year)), emissions, type="l", 
     xlab = "Year", ylab = "Emissions (tons)", 
     main = "Emissions per year in Baltimore")
dev.off()
message("Plot finished")