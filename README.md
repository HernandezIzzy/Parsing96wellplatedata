# Parsing96wellplatedata
Parsing of 96-well plate bacterial transformation data 

# Introduction 
I created a short R script to help scientists parse 96-well plate format data. A single 96-well plate contains 8 rows and 12 columns, totaling 96 samples. In this respository, I used an example of a bacterial transformation experiment, where the data is represented by the number of colonies counted in each well (biologically, these are called the Colony Forming Units, or CFUs).

# Input
- The data recorded in this experiment was on an Excel spreadsheet in 96-well plate format (each plate is 9 rows [A to H] and 13 columns  [1-12], to account for well locations). This format is "wide" and is therefore not easy to parse and work with for downstream analysis
- Here, I use the read_excel function from the readxl library to load the data and then use a variety of other packages to transform this wide format into a cleaner "narrow" format.

# Output
- A csv file of CFU data in narrow format. This means that each row is representative of a single well, so a full 96-well plate will be 96 rows long
- Columns are Plate Name, Plate well, CFU

#Extra
- I then refeed the formatted narrow data into the script again to do create some data visualizations with the ggplot2 package to look at the bacterial transformation results more closely
- Some interactions I looked at were Gene size transformed vs. CFU count, Gene size histogram color coded by 3 different categories of transfomration results (None, Low transformation efficiency, or high transformation efficiency)
