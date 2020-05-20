#In this project we will be working with a fake advertising data set, indicating whether or not a particular internet user clicked on an Advertisement on a company website. 
#We will try to create a model that will predict whether or not they will click on an ad based off the features of that user.
#This data set contains the following features:
#'Daily Time Spent on Site': consumer time on site in minutes
#'Age': cutomer age in years
#'Area Income': Avg. Income of geographical area of consumer
#'Daily Internet Usage': Avg. minutes a day consumer is on the internet
#'Ad Topic Line': Headline of the advertisement
#'City': City of consumer
#'Male': Whether or not consumer was male
#'Country': Country of consumer
#'Timestamp': Time at which consumer clicked on Ad or closed window
#'Clicked on Ad': 0 or 1 indicated clicking on Ad

#Import
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

#Get and read data
add_data = pd.read_csv("advertising.csv")
add_data.head()
add_data.info()
add_data.describe()
add_data.columns

#EDA and Transformations

sns.set_style('whitegrid')

#Let's create a histogram to see how is the Age distributed
sns.distplot(add_data["Age"])

#Let's see how does our dataset is behaving by "Clicked on Ad" column
sns.pairplot(add_data, hue = "Clicked on Ad")

#Let's remove the columns we do not need for the Logistic Model
add_data.drop(add_data[["Ad Topic Line", "City", "Country", "Timestamp"]], axis = 1, inplace = True)

#Let's place our independent variables in the X variable and our dependent variable in the Y variable
X = add_data[['Daily Time Spent on Site', 'Age', 'Area Income',
       'Daily Internet Usage', 'Male']]
y = add_data["Clicked on Ad"]

#Splitting X and y to the training and test sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.30)

#Importing our LogisticRegression and training the model
from sklearn.linear_model import LogisticRegression
logmodel = LogisticRegression()
logmodel.fit(X_train,y_train)

#Testing
predictions = logmodel.predict(X_test)

#Evaluating our model's performance
from sklearn.metrics import classification_report
print(classification_report(y_test,predictions))