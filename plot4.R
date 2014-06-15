# Reading data
message("Reading data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

message("Starting plot")
png("plot4.png")
par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)

# Getting only data associated to coal-related sources by
# matching the EI.Sector attribute to a regular expression
# containing the word Coal and the SCC.Level.One to a regular
# expression containing (C|c)ombustion
coal.sources <- SCC[which(attr(regexpr("Coal", SCC$EI.Sector), "match.length") >= 0 & attr(regexpr("(C|c)ombustion", SCC$SCC.Level.One), "match.length")),]
NEI.coal <- merge(NEI, coal.sources, by.x="SCC", by.y="SCC")

emissions <- tapply(NEI.coal$Emissions, as.factor(NEI.coal$year), sum)
plot(levels(as.factor(NEI.coal$year)), emissions, type="l", 
     xlab = "Year", ylab = "Emissions (tons)", 
     main = "Coal-related emissions per year in the US")
dev.off()
message("Plot finished")