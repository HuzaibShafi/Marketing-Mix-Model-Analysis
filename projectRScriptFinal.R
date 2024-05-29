# Load libraries

install.packages("GGally")
install.packages("car")


library(car)
library(readxl)
library(GGally)
library(MASS)
library(car)

# Load dataset

#Please change the address of the dataset here (Group 9 - dataset - FriutTea_2)
loaded_data <- load("CourseWorkData.RData")

data <- get(loaded_data)

#check table
data

# Rename columns for easier access and recall 
names(data) <- c("Sales","Price", "Ad1", "Ad2", "Prom", "Wage", "Time", "Product", "Region", "Month", "Year")
data



# Remove null values from Ad1
data <- na.omit(data)

# Apply Box-Cox transformation to Sales
lambda <- boxcox(Sales ~ 1, data = data)
best_lambda <- lambda$x[which.max(lambda$y)]

# Transform Sales variable using Box-Cox transformation 
# if lamda is 0 then the sales would be passed to the log function in order to transform it 


if (best_lambda != 0) {
  data$Sales <- (data$Sales^best_lambda - 1) / best_lambda
} else {
  data$Sales <- log(data$Sales)
}

#Ad1 display check 
data$Ad1
# Calculate ad1mod as (Ad1)^10
data$ad1mod <- data$Ad1^10
#Ad1 mod display check 
data$ad1mod

#Splitting the data into train and test sets ( 80. : 20 split )
set.seed(123)

#Create an index for the training set
train_index <- sample(1:nrow(data), 0.8 * nrow(data))

# Create the training set
train_data <- data[train_index, ]

# Create the test set
test_data <- data[-train_index, ]

# Variables check 
train_data
test_data


# Making linear regression model 

model <- lm('Sales ~  ad1mod + Ad2 + Prom + Wage+ Region', data = train_data)
summary(model)



# Make predictions on the test set
predictions <- predict(model, newdata = test_data)
predictions 
# Evaluate model performance
mse <- mean((predictions - test_data$Sales)^2)
rmse <- sqrt(mse)
mae <- mean(abs(predictions - test_data$Sales))

cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Mean Absolute Error (MAE):", mae, "\n")


# Create a scatterplot of predicted vs. actual values
plot(x = test_data$Sales , y = predictions, 
     main = "Predicted vs. Actual Values (Training Set)",
     xlab = "Actual Values", ylab = "Predicted Values",
     col = "blue", pch = 16)

# Add a line for equality (perfect predictions)
abline(0, 1, col = "red")

# Add a legend
legend("topright", legend = c("Model Predictions", "Perfect Predictions"), 
       col = c("blue", "red"), pch = c(16, NA), bty = "n")



#Regession analysis asumptions check 

# Get residuals and fitted values
residuals <- residuals(model)
fitted_values <- fitted(model)

# Residuals vs. Fitted plot
plot(fitted_values, residuals, xlab = "Fitted values", ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red")  # Adding a horizontal line at y = 0

#qqplot to check normality 

qqPlot(model, id = 0.05, main = "QQ Plot of Residuals")


# Check for multicollinearity using VIF

vif(model)

# This ANOVA table is analyzing the variance in Sales explained by different variables in the model

anova(model, test = "F")



# Answer to Question 1 

# Extract coefficients from the model
coefficients <- coef(model)
coefficients

# Associated units sold for each marketing activity
units_sold_Ad1mod <- coefficients["ad1mod"]
units_sold_Ad2 <- coefficients["Ad2"]
units_sold_Prom <- coefficients["Prom"]
units_sold_Wage <- coefficients["Wage"]

# Print associated units sold for each marketing activity
cat("Units sold associated with Ad1mod:", units_sold_Ad1mod, "\n")
cat("Units sold associated with Ad2:", units_sold_Ad2, "\n")
cat("Units sold associated with Prom:", units_sold_Prom, "\n")
cat("Units sold associated with Wage:", units_sold_Wage, "\n")


# Define costs for TV ads and Banners
cost_TV_ads <- 2000000
cost_Banners <- 500000

# Calculate cost per unit sold for each marketing activity
cat(cost_per_unit_TV <- cost_TV_ads / units_sold_Ad1mod)
cat(cost_per_unit_Banners <- cost_Banners / units_sold_Ad2)

# Compare cost-effectiveness
if (cost_per_unit_TV < cost_per_unit_Banners && cost_per_unit_TV > 0 ) {
  cat("TV ads are more cost-effective.")
} else {
  cat("Banners are more cost-effectiveness.")
}


#Question 3 : Possible sources of variation in sales

# Consumer Preferences : The variation in fruit tea sales between 2010 and 2014 could be attributed
# to a notable shift in consumer preferences towards healthier beverage options and a heightened focus
# on natural ingredients. During this period, consumers exhibited a growing awareness of the impact of
# their dietary choices on overall well-being, leading to an increased demand for beverages perceived
# as healthier alternatives. Fruit tea, often marketed as a natural and health-conscious option, likely
# gained traction as consumers sought beverages with genuine, recognizable ingredients. Moreover,
# the surge in popularity of organic foods during this timeframe may have played a significant role
# in influencing fruit tea sales. As the organic foods market experienced a boom, consumers were
# inclined to choose beverages, like fruit tea, that aligned with their preference for organic and
# natural products. This confluence of health-consciousness and the organic foods trend likely
# contributed to the fluctuations observed in fruit tea sales during the specified period.


# Supply Chain: The variations in fruit tea sales between 2010 and 2014 could also be attributed to
# fluctuations in the supply chain, availability, and distribution channels. A well-functioning supply 
# chain is crucial for ensuring the consistent availability of products on the market. Any 
# disruptions or challenges in the supply chain, such as issues with sourcing key ingredients
# or manufacturing bottlenecks, could lead to fluctuations in product availability. Additionally, 
# changes in distribution strategies or the entry into new markets might have influenced the reach
# of fruit tea products. If there were improvements in distribution networks during this timeframe
# , it could have positively impacted sales. Conversely, any hiccups or inefficiencies in the 
# distribution process may have resulted in inconsistent product availability, contributing to
# sales variations. Therefore, the dynamics of the supply chain and distribution channels are 
# essential factors to consider when analyzing the sales trends of fruit tea during this specified 
# period.


# 
# Competition : The fluctuations in fruit tea sales from 2010 to 2014 could be influenced by the enduring 
# popularity and cost-effectiveness of traditional tea. Normal tea, with its long-established
# presence and affordability, may have posed strong competition to fruit tea during this period.
# Given that traditional tea has been a staple beverage for over two centuries, it holds a
# deep-rooted position in consumer habits. The lower cost of conventional tea compared to 
# specialty fruit teas could have prompted price-sensitive consumers to opt for the more 
# economical option, especially during economically challenging times. Additionally, the
# readily available nature of traditional tea in various forms, from bagged to loose-leaf 
# varieties, might have further contributed to its consistent consumption. In light of these 
# factors, the enduring and cost-efficient appeal of normal tea may have played a pivotal role
# in shaping the sales dynamics, causing fluctuations in the demand for fruit tea.

#Question 4
# Remove rows with missing or infinite values in the 'Sales' variable
train_data <- na.omit(train_data[!is.na(train_data$Sales) & is.finite(train_data$Sales), ])

# Getting unique regions
unique_regions <- unique(train_data$Region)

# Initializing a list to store predicted sales for each region
predicted_sales_by_region <- list()

# Training a model for each region using linear regression
for (reg in unique_regions) {
  # Subset data for the current region
  subset_data_region <- subset(train_data, Region == reg)
  
  # Checking if there is enough data for the current region
  if (nrow(subset_data_region) >= 2) { 
    # Calculating mean values for independent variables
    mean_price <- mean(subset_data_region$Price)
    mean_ad1mod <- mean(subset_data_region$ad1mod)
    mean_ad2 <- mean(subset_data_region$Ad2)
    mean_wage <- mean(subset_data_region$Wage)
    mean_prom <- mean(subset_data_region$Prom)  # Add mean of Prom
    
    # Creating a data frame with mean values for prediction
    new_data <- data.frame(
      Price = mean_price,
      ad1mod = mean_ad1mod,
      Ad2 = mean_ad2,
      Wage = mean_wage,
      Prom = mean_prom,  # Include mean of Prom
      Region = reg
    )
    
    # Predicting sales for the current region using mean values
    predicted_sales <- predict(model, newdata = new_data)
    
    # Reverse Box-Cox transformation
    if (best_lambda != 0) {
      predicted_sales <- ((predicted_sales * best_lambda) + 1)^(1/best_lambda)
    } else {
      predicted_sales <- exp(predicted_sales)
    }
    
    # Storing predicted sales for the current region
    predicted_sales_by_region[[reg]] <- predicted_sales
    
    cat("Predicted Sales for", reg, "in January 2015:", predicted_sales, "\n")
  } else {
    cat("Not enough data for prediction in", reg, "\n")
    predicted_sales_by_region[[reg]] <- NA
  }
}

# Displaying the predicted sales for each region
for (reg in unique_regions) {
  cat("Predicted Sales for", reg, "in January 2015:", predicted_sales_by_region[[reg]], "\n")
}
