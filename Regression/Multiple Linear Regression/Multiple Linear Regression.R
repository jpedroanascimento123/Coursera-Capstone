# Import the dataset
dataset = read.csv('50_Startups.csv')

# Dealing with categorical data (transforming text into numerical)
dataset$State = factor(dataset$State,
                         levels = c('New York', 'California', 'Florida'),
                         labels = c(1, 2, 3))

# Splitting the dataset into the Training and Test set (one to teach our model, the other to test it)
# The dependant variable is Purchased 
install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit,
                     SplitRatio = 0.8)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = training_set)

# Get some info regarding the regressor. Looking at the coefficients, we can see that the independent variable RD Spend has a strong effect on our dependant variable (p-value extremely low)
summary(regressor)

# We could now turn this multiple linear regression in a simple linear regression, since we found out only one independent variable has a strong impact on our dependent variable.

# Predicting the Test set results
predictor = predict(regressor, newdata = test_set)

# Building the optimal model using Backward Elimination - analyse the entire dataset to see which independent variables can be removed because they have no significant impact on the dependent variable (keep removing the most non-significant independent variables one at a time)
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = dataset)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = dataset)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend ,
               data = dataset)
summary(regressor)

# Visualization...



