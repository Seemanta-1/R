install.packages("ggplot2")
install.packages("GGally")
install.packages("dplyr")

library(ggplot2)
library(GGally)
library(dplyr)

#Load the dataset from URL
url <- "https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/datasets/airquality.csv"
air <- read.csv(url)
head(air)

#check null value
colSums(is.na(air))

#clean data
air_clean <- na.omit(air)
cat("Total NA values after cleaning:", sum(is.na(air_clean)),"\n")
air_clean <- air_clean[!duplicated(air_clean), ]

#Trend Analysis 
ggplot(air_clean, aes(x=Temp, y=Wind)) +
  geom_point() +
  geom_smooth(method='lm', se=FALSE, color='blue') +
  labs(title="Temp vs Wind", x="Temp", y="Wind")

#box plot
ggplot(air_clean, aes(y = Wind)) +
  geom_boxplot(fill = "green") +
  labs(title = "Boxplot of Wind", y = "Wind")

#correlation Map
ggcorr(air_clean, label = TRUE)

#data wrangling
air_filtered <- air_clean %>% filter(Temp > 60)

air_selected <- air_filtered %>% select(Temp, Wind, Solar.R)
air_mutated <- air_selected %>% mutate(Temp_Multiply_Solar.R = Temp * Solar.R)

head(air_selected)
head(air_mutated)

#Normalize
air_scaled <- air_selected %>% mutate(across(c(Temp, Wind, Solar.R), ~ scale(.)[,1]))
head(mtcars_scaled)