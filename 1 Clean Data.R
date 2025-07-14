library(data.table)
library(rstudioapi)
library(readxl)

####  Download data
setwd(dirname(getActiveDocumentContext()$path))
filePath <- "Data/"
СlientsData <- fread(paste0(filePath,"ClientsList.csv"))
TransactionData <- read_excel(paste0(filePath, "TXN.xlsx"))

##### TransactionData preparation
# Convert to Data_table
TransactionData <- as.data.table(TransactionData)

str(TransactionData) 
colSums(is.na(TransactionData)) 
sum(duplicated(TransactionData))

# Convert DATE to a date format
class(TransactionData$DATE)     
any(is.na(TransactionData$DATE))
TransactionData$DATE <- as.Date(TransactionData$DATE, origin = "1899-12-30")

summary(TransactionData$DATE)


# Remove non 'Chips' transactions 
TransactionData <- TransactionData[grepl("chips", PROD_NAME, ignore.case = TRUE)]

# Extract Brand names
TransactionData[, BRAND := tstrsplit(PROD_NAME, " ")[[1]]]
unique(TransactionData$BRAND)

TransactionData[BRAND == "Doritos", BRAND := "Dorito"]
TransactionData[BRAND == "Snbts", BRAND := "Sunbites"]
TransactionData[BRAND == "WW", BRAND := "Woolworths"]
TransactionData[BRAND == "Smiths", BRAND := "Smith"]
TransactionData[BRAND == "Infzns", BRAND := "Infuzions"]

unique(TransactionData$BRAND)

# Extract sizes
TransactionData[, PACK_SIZE := parse_number(PROD_NAME)]
unique(TransactionData[["PACK_SIZE"]])


##### ClientsData preparation
СlientsData <- as.data.table(СlientsData)

str(СlientsData) 
colSums(is.na(СlientsData)) 
sum(duplicated(СlientsData))

#### Merge tables
Full_data <- merge(TransactionData, СlientsData, all.x = TRUE)
colSums(is.na(Full_data))

fwrite(Full_data, paste0(filePath,"Full_Data.csv"))

### Data preparation is now complete!
