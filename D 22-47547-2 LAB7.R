install.packages("caret")
library(caret)
library(rpart)

#Load the dataset
data <- read.table("~/Downloads/penguins.csv", header = TRUE, sep = "\t")
head(data)
str(penguins)
summary(penguins)

# Set seed for reproducibility
set.seed(123)

# Create train-test split based on Species (target variable)
trainIndex <- createDataPartition(penguins$species, p = 0.7, list = FALSE)
trainData  <- penguins[trainIndex, ]
testData   <- penguins[-trainIndex, ]

# Train Decision Tree
model_dt <- rpart(species ~ ., data = trainData, method = "class")

# Print model
print(model_dt)

pred_dt <- predict(model_dt, newdata = testData, type = "class")
head(pred_dt)

conf_mat <- confusionMatrix(pred_dt, testData$species)
conf_mat

library(ggplot2)

# Extract table from confusion matrix
cm_table <- as.data.frame(conf_mat$table)

# Plot heatmap
ggplot(cm_table, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), vjust = 1) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  theme_minimal() +
  ggtitle("Confusion Matrix Heatmap")


accuracy <- conf_mat$overall['Accuracy']
accuracy

# Logistic Regression (Binary Classification)
# Copy dataset
penguins_bin <- penguins

# Create binary target (Adelie vs Others)
penguins_bin$IsAdelie <- ifelse(penguins_bin$species == "Adelie", "Yes", "No")
penguins_bin$IsAdelie <- as.factor(penguins_bin$IsAdelie)

# Train-test split
set.seed(123)
trainIndex2 <- createDataPartition(penguins_bin$IsAdelie, p = 0.7, list = FALSE)
trainData2  <- penguins_bin[trainIndex2, ]
testData2   <- penguins_bin[-trainIndex2, ]

names(penguins_bin)

# Logistic Regression model (using bill length & bill depth as predictors)
model_log <- glm(IsAdelie ~ bill_len + bill_dep,
                 data = trainData2,
                 family = binomial)

# Check summary
summary(model_log)


#Prediction & evaluation
# Predict probabilities
prob <- predict(model_log, newdata = testData2, type = "response")

# Convert probabilities into Yes/No classes
pred_log <- ifelse(prob > 0.5, "Yes", "No")
pred_log <- as.factor(pred_log)

# Confusion Matrix for Adelie vs Not Adelie
cm <- confusionMatrix(pred_log, testData2$IsAdelie)
cm

# Extract table from confusion matrix
cm_table <- as.data.frame(cm$table)

# Plot heatmap
ggplot(cm_table, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), color = "white", size = 5) +  # better visibility
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  theme_minimal() +
  ggtitle("Confusion Matrix Heatmap") +
  theme(plot.title = element_text(hjust = 0.5)) 
