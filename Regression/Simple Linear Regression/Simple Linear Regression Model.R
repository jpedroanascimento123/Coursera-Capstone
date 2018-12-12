# Import the dataset
dataset = read.csv('Salary_Data.csv')

# Splitting the dataset into the Training and Test set (one to teach our model, the other to test it)
# The dependant variable is Purchased 
install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary,
                     SplitRatio = 2/3)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

# Feature scaling (putting our values on the same scale - all except categorical columns)
training_set[,1:2] = scale(training_set[, 1:2])
test_set[,1:2] = scale(test_set[, 1:2])

# Fitting Simple Linear Regression to the Training set
regressor = lm(formula = Salary ~ YearsExperience, 
               data = training_set)

# Get some info regarding the regressor. Looking at the coefficients, we can see that the independant variable YearsExperience has a strong effect on our dependant variable (p-value extremely low)
summary(regressor)

# Predicting the Test set results
predictor = predict(regressor, newdata = test_set)

# Visualising the Training set results
install.packages('ggplot2')
ggplot() + 
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = "red") + 
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = "blue") + 
  ggtitle('Salary vs Experience (Training set)') + 
  xlab('Years of Experience') + 
  ylab('Salary')


# Visualising the Test set results
install.packages('ggplot2')
ggplot() + 
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = "red") + 
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = "blue") + 
  ggtitle('Salary vs Experience (Test set)') + 
  xlab('Years of Experience') + 
  ylab('Salary')
