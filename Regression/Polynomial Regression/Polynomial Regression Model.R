# Import the dataset
dataset = read.csv('Position_Salaries.csv')

# Dealing with categorical data (transforming text into numerical) - since the Level column is the encoding of the Position column, we will use the Level and Salary columns only
# Need to subset the dataset to just have those two columns
dataset = dataset[2:3]

# Since it's a dataset with just 10 rows, it doesn't make sense to split into a training and test set.

# We don't need the feature scaling as well because this is a polynomial regression, which means we will need the "real values" to grab the exponents.

# A Polynomial regression Model is more suited for this problem because there isn't a linear relationship between our independent variable (Level) and our dependent variable (Salary) 
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
dataset$Level5 = dataset$Level^5
regressor = lm(formula = Salary ~ ., 
               data = dataset)

# Visualising the Polynomial Regression Results
install.packages('ggplot2')
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = "red") + 
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),
            colour = "blue") + 
  ggtitle('Salary vs Level') + 
  xlab('Level') + 
  ylab('Salary')

# Predicting a new result with Polynomial Regression
predictor = predict(regressor, data.frame(Level = 6.5, 
                                          Level2 = 6.5^2,
                                          Level3 = 6.5^3,
                                          Level4 = 6.5^4,
                                          Level5 = 6.5^5))
                                       