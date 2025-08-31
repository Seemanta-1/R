#Load the dataset
data <- read.table("~/Downloads/penguins.csv", header = TRUE, sep = "\t")
head(data)
str(penguins)
summary(penguins)

mean(penguins$bill_dep, na.rm = TRUE)
median(penguins$bill_len, na.rm = TRUE)

freq_table <- table(penguins$bill_len)
names(freq_table)[which.max(freq_table)]

range_val <- range(na.omit(penguins$bill_len))
max(range_val) - min(range_val)

var(penguins$bill_len, na.rm = TRUE)
sd(penguins$bill_len, na.rm = TRUE)
IQR(penguins$bill_len, na.rm = TRUE)
quantile(penguins$bill_len, na.rm = TRUE , probs=c(0.25,0.75))

library(dplyr)
penguins %>%
  group_by(species) %>%
  summarise(
    count= n(),
    mean_bill_length = mean(bill_len, na.rm= TRUE),
    sd_bill_length = sd(bill_len, na.rm = TRUE),
    mean_flipper_length = mean(flipper_len, na.rm =TRUE),
    sd_flipper_length = sd(flipper_len, na.rm = TRUE)
  )

pairs(penguins[,3:6], main = "Scatterplot Matrix of Penguins Data", col=penguins$species)