library(reshape2)
library(readxl)
library(plater)
library(plyr)


#Prior to running script:
# Make sure methanotroph transformation data is stored in a csv file in 96-well plate format
# Each well will have an interger or 0 to represent colony count
# CFU = colony forming units.

#Import data in "wide" format
tx_plate <- read_plates(file = "C:/Users/ihernandez/Desktop/Arational_McapTx.csv", well_ids_column = "Wells")

#QC checks and checking imported data

#head(tx_plate)
#check_plater_format(tx_plate) #boolean
#str(tx_plate)
#typeof(tx_plate)

# Create "narrow" format and remanme columns
databycolumn <- melt(tx_plate)
names(databycolumn)[names(databycolumn) == "Wells"] <- "Well"
names(databycolumn)[names(databycolumn) == "variable"] <- "Plate Name"
names(databycolumn)[names(databycolumn) == "value"] <- "CFU"
databycolumn$Plate <- NULL

# QC checks of newly formatted data
tail(databycolumn)
head(databycolumn)
dim(databycolumn) #4 columns, 288 rows

#Export
write.csv(bycolumn, file = "C:/Users/ihernandez/Desktop/Mcap Tx Parsed Data_2.csv")


#   1   2   3   4   5   6   7   8  9  10 11 12
# A "A" "I" "Q" "Y" "g" "o" "w" "" "" "" "" ""
# B "B" "J" "R" "Z" "h" "p" "x" "" "" "" "" ""
# C "C" "K" "S" "a" "i" "q" "y" "" "" "" "" ""
# D "D" "L" "T" "b" "j" "r" "z" "" "" "" "" ""
# E "E" "M" "U" "c" "k" "s" ""  "" "" "" "" ""
# F "F" "N" "V" "d" "l" "t" ""  "" "" "" "" ""
# G "G" "O" "W" "e" "m" "u" ""  "" "" "" "" ""
# H "H" "P" "X" "f" "n" "v" ""  "" "" "" "" ""

### Visualizations ###

plate_data <- read_excel("C:/Users/ihernandez/Desktop/Tx Arational MBO_11.4.19.xlsx", sheet = "Rearranged plate")
head(plate_data)

cfu_count <- plate_data$CFUs
concentration <- plate_data$`c+c DNA Conc`
Tx_Result <- revalue(plate_data$Transformation_Result, c("Low Efficency (1-100 CFUs)"="Transformants", "High Efficiency (+100 CFUs)"="Transformants"))


cfu_histogram <- ggplot(plate_data, aes(x = plate_data$Gene_Size)) + geom_histogram(binwidth = 100, alpha=0.9, fill = "purple", colour = "black") + facet_grid(as.factor(Tx_Result) ~ .)
cfu_histogram + labs(x = "Gene Length (bp)", title = "Distribution of Methanotroph Gene Sizes by Transformation Result") + xlim(0,5000)

dot1 <- ggplot(plate_data, aes(x = concentration, y = cfu_count)) + geom_point() + geom_smooth(method = "lm")
dot1 + labs(x = "DNA Concentration from Clean & Concentrate (ng/uL)", y = "CFU Count") + xlim(0,600)

dot2 <- ggplot(plate_data, aes(x = plate_data$Gene_Size, y = cfu_count)) + geom_point() + geom_smooth(method = "lm")
dot2 + labs(title = "Correlation between Gene Length and TH55 Transformation Efficiency", x = "Gene size (bp)", y = "CFU Count") + xlim(0,6000) + ylim(0,120) + 
  theme(panel.grid.major = element_line(colour = "gray", size = 0.5, linetype = "solid"),
panel.grid.minor= element_line(colour = "gray", size = 0.5, linetype = "solid"))

histrogram_2 <- ggplot(plate_data, aes(x = plate_data$Gene_Size)) + geom_histogram(binwidth = 100, alpha=0.9, fill = "purple", colour = "black") + facet_grid(plate_data$Transformation_Result ~ .)
histogram_2 + labs(x = "Gene Length (bp)", title = "Distribution of Methanotroph Gene Sizes by Transformation Result") + xlim(0,5000)
