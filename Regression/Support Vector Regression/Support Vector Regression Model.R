# Import the dataset
dataset = read.csv('Position_Salaries.csv')

# Subset the dataset
dataset = dataset[2:3]

# Fitting the Regression Model to the dataset
install.packages('e1071')
library(e1071)
regressor = svm(formula = Salary ~ .,
                data = dataset,
                type = 'eps-regression')

# Predicting a new result with Regression Model
predictor = predict(regressor, data.frame(Level = 6.5))
                    
# Visualising the Regression Model results
install.packages('ggplot2')
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = "red") + 
  geom_line(aes(x = dataset$Level, y = predict(regressor, newdata = dataset)),
            colour = "blue") + 
  ggtitle('Salary vs Level') + 
  xlab('Level') + 
  ylab('Salary')
