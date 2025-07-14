library(data.table)
library(ggplot2)
library(ggmosaic)
library(readr)
library(rstudioapi)
library(readxl)
library(scales)
library(zoo)

####  Download data
setwd(dirname(getActiveDocumentContext()$path))
filePath <- "Data/"
Data <- fread(paste0(filePath,"Full_Data.csv"))

### Daily reports
Daily_report <- Data[, 
                     .(TotalSales = sum(TOT_SALES)), 
                     by = .(DATE)]

ggplot(Daily_report, aes(x = DATE)) +
  geom_col(aes(y = TotalSales), color = 'lightgreen', line = 'grey', size = 1.2) +  
  scale_x_date(date_breaks = "15 days", date_labels = "%d-%b") +
  labs(x = "Date", title = "Daily sales report") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

### Weekdays report 
Data[, iWeekday := factor(weekdays(as.Date(DATE)), 
                          levels = c("Monday", "Tuesday", "Wednesday", 
                                     "Thursday", "Friday", "Saturday", "Sunday"))]

WDay_report <- Data[, 
                    .(TotalSales = sum(TOT_SALES)), 
                    by = iWeekday][order(iWeekday)]


ggplot(WDay_report, aes(x = iWeekday, y = TotalSales)) +
  geom_col(fill = 'lightgreen', size = 1.2) +  
  labs(x = "Day of the Week", title = "Daily sales report") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

### Monthly reports 
Data[, iMonth := as.yearmon(as.Date(DATE))]

Month_report <- Data[, 
                    .(TotalSales = sum(TOT_SALES)), 
                    by = iMonth][order(iMonth)]

ggplot(Month_report, aes(x = as.Date(iMonth), y = TotalSales)) +
  geom_col(fill = 'lightgreen', width = 25) +  
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y") +  # подпись каждый месяц
  labs(x = "Month", y = "Sales", title = "Mounthly sales `report") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#Total Sales through Clients Segments and Ages
Segmentation <- Data[, 
                      .(TotalSales = sum(TOT_SALES),
                        NumClients = uniqueN(LYLTY_CARD_NBR), 
                        NumTxn = uniqueN(TXN_ID),
                        NumProd = sum(PROD_QTY)), 
                     by = .(LIFESTAGE, PREMIUM_CUSTOMER)]

ggplot(Segmentation, aes(x = PREMIUM_CUSTOMER, y = TotalSales, fill = LIFESTAGE)) +
  geom_col(position = 'dodge', color = 'black', size = 0.2) +
  geom_hline(yintercept = 4000, color = "red", linetype = "dashed", size = 1) +
  scale_fill_brewer(palette = "Set2") +
  labs(x = "Client Status", title = "Total Sales through Clients Segments") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

Segmentation[, top_client := ifelse(TotalSales > 4000, 1, 0)]
Top_clients_sales[, label := ifelse(top_client == 1, "Top Clients", "Others")]
Top_clients_sales[, percent := round(Sum / sum(Sum) * 100)]

ggplot(data = Segmentation) +
  geom_mosaic(aes(x = product(PREMIUM_CUSTOMER, LIFESTAGE),
                  weight = TotalSales,
                  fill = LIFESTAGE)) +
  labs(title = "Sales Distribution Across Client Segments",
       x = "Premium Customer × Lifestage", y = "Share of Sales") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Top clients 
Top_clients_sales <- Segmentation[ , 
                                   .(Sum = sum(TotalSales)), 
                                   by = top_client]


ggplot(Top_clients_sales, aes(x = "", y = Sum, fill = label)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  geom_text(aes(label = paste0(percent, "%")),
            position = position_stack(vjust = 0.5)) +
  coord_polar("y") +
  labs(title = "Sales proportion: Top Clients vs Others") +
  theme_void() +
  scale_fill_brewer(palette = "Set2")

# Top clients Preference 
Segmentation[, av_price := TotalSales / NumProd]
Segmentation[, av_quantity := NumProd / NumTxn]

Top_brands <- Data[, .(TotalQty = sum(PROD_QTY),
                       TotalSum = sum(TOT_SALES)), 
                      by = .(BRAND, PREMIUM_CUSTOMER)][
                             order(-TotalQty)]
Top_brands

ggplot(Top_brands, aes(x = reorder(BRAND, TotalQty), 
                       y = TotalQty, 
                       fill = as.factor(PREMIUM_CUSTOMER))) +
  geom_col(position = 'dodge') +
  coord_flip() +
  labs(title = "Top Chart of Chips' Brands", 
       x = "Brand", y = "Total quantity", fill = "Client Status") +
  theme_minimal()

Top_size <- Data[, .(TotalQty = sum(PROD_QTY),
                       TotalSum = sum(TOT_SALES)), 
                   by = .(PACK_SIZE)][
                     order(-TotalQty)]

ggplot(Top_size, aes(x = reorder(PACK_SIZE, TotalQty), y = TotalQty)) +
  geom_col() +
  coord_flip() +
  labs(title = "Top Chart of Chips' Pack size", 
       x = "Brand", y = "Total quantity", fill = "Client Status") +
  theme_minimal()
