# Import the dataset
dataset = read.csv('Position_Salaries.csv')

# Subset the dataset
dataset = dataset[2:3]

# Fitting the Regression Model to the dataset
install.packages('randomForest')
library(randomForest)
set.seed(1234)
regressor = randomForest(x = dataset[1], 
                         y = dataset$Salary,
                         ntree = 500)

# Predicting a new result with Regression Model
predictor = predict(regressor, data.frame(Level = 6.5))

# Visualising the Regression Model results
install.packages('ggplot2')
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.001)
ggplot() + 
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
             colour = "red") + 
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame (Level = x_grid))),
            colour = "blue") + 
  ggtitle('Salary vs Level') + 
  xlab('Level') + 
  ylab('Salary')