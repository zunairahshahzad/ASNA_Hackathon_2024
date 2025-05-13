## Before running code, install packages: dplyr, GGally, pROC and load libraries

## Open train and test dataset provided
data <- read.csv("train.csv")
test_data <- read.csv("test.csv")

## On train data set

ggpairs(data[0:1000,2:4], cardinality_threshold = 1000)
model <- glm(Claim.over.1k ~ Vehicle.Size.Index + Gender + Income + Customer.Lifetime.Value 
             + Marital.Status.Index + Employment.Status.Index + Education.Index + 
               Employment.Status + Policy.Index + Income + Coverage.Index + Response + 
               State + Sales.Channel.Index + Renew.Offer.Type + Number.of.Policies + 
               Number.of.Open.Complaints + Months.Since.Policy.Inception + 
               Months.Since.Last.Claim + Effective.To.Date + Policy.Type.Index + Sales.Channel.Index, data = data)
data$predicted_prob <- predict(model, type = "response")
roc_curve <- roc(data$Claim.over.1k, data$predicted_prob)
optimal_coords <- coords(roc_curve, "best", best.method = "youden")
optimal_threshold <- optimal_coords["threshold"]
threshold <- optimal_threshold
data <- data %>% mutate(binary_prediction = ifelse(predicted_prob > threshold, 1, 0))

# correct code no duplicates ****
model <- glm(Claim.over.1k ~ Vehicle.Size.Index + Gender + Income + Customer.Lifetime.Value + Marital.Status.Index + Education.Index + Employment.Status.Index + Policy.Index + Coverage.Index + Response + State + Sales.Channel.Index + Renew.Offer.Type + Number.of.Policies + Number.of.Open.Complaints + Months.Since.Policy.Inception + Months.Since.Last.Claim + Effective.To.Date + Policy.Type.Index, data = data, family=binomial)


# removed policy type index
model <- glm(Claim.over.1k ~ Vehicle.Size.Index + Gender + Income + Customer.Lifetime.Value + Marital.Status.Index + Education.Index + Employment.Status.Index + Policy.Index + Coverage.Index + Response + State + Sales.Channel.Index + Renew.Offer.Type + Number.of.Policies + Number.of.Open.Complaints + Months.Since.Policy.Inception + Months.Since.Last.Claim + Effective.To.Date, data = data, family=binomial)

# model 
model <- glm(Claim.over.1k ~ Vehicle.Size.Index + Gender + Income + Customer.Lifetime.Value + Marital.Status.Index + Education.Index + Employment.Status.Index + Coverage.Index + Response + Number.of.Open.Complaints, data = data, family=binomial)
# vehicle size, gender, income, CLV, marital status, education, employment, coverage, response, # of complaints

#extract coefficients
coefficients <- coef(model)
predict_claims <- function(test_data, coefficients) {
  # Extract the coefficients
  intercept <- coefficients[1]
  
  #convert categorical variables to numerics
  test_data$Gender_numeric <- ifelse(test_data$Gender == "M", 1, 0)
  test_data$State_numeric <- as.numeric(as.factor(test_data$State))
  test_data$Response_numeric <- as.numeric(as.factor(test_data$Response))
  test_data$Effective.To.Date.numeric <- as.numeric(as.factor(test_data$Effective.To.Date))

  # Calculate the linear predictor (logit)
  linear_predictor <- intercept + 
    coefficients[2] * test_data$Vehicle.Size.Index + 
    coefficients[3] * test_data$Gender_numeric + 
    coefficients[4] * test_data$Income + 
    coefficients[5] * test_data$Customer.Lifetime.Value + 
    coefficients[6] * test_data$Marital.Status.Index + 
    coefficients[7] * test_data$Education.Index + 
    
    #test for diff model
    coefficients[9] * test_data$Coverage.Index + 
    coefficients[10] * test_data$Response_numeric + 
    coefficients[11] * test_data$Number.of.Open.Complaints 
  
  # Calculate predicted probabilities
  predicted_probabilities <- 1 / (1 + exp(-linear_predictor))
  
  return(predicted_probabilities)
}

# applying on new dataset
test_data$Predicted_Probabilities <- predict_claims(test_data, coefficients)

# binary column
test_data$Predicted_Class <- ifelse(test_data$Predicted_Probabilities > 0.5, 1, 0)

org <- read.csv("test.csv")
combined_data <- cbind(org$CustomerID, test_data$Predicted_Class)
colnames(combined_data) <- c("CustomerID", "Claim over 1k")
write.csv(combined_data, file = "claimover1k_submission.csv", row.names = FALSE)

## Plotting actual vs. predicted values
plot_data <- data.frame(
  Actual = data$Claim.over.1k,            # Actual values
  Predicted = data$predicted_prob        # Predicted probabilities
)

# Create the plot
graph <- ggplot(plot_data, aes(x = Predicted, y = Actual)) +
  geom_point(alpha = 0.5) +  # Scatter plot with transparency
  geom_smooth(method = "loess", col = "blue") +  # Adds a smooth line (e.g., loess smoothing)
  labs(
    title = "Predicted Probabilities vs Actual Values",
    x = "Predicted Probability",
    y = "Actual Value"
  ) +
  theme_minimal()  # Use a minimal theme

# Save the plot as a PNG
ggsave("predicted_vs_actual.jpg", plot = graph, width = 8, height = 6, dpi = 300)
