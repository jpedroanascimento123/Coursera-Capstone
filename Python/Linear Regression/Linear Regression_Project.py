#Congratulations! You just got some contract work with an Ecommerce company based in New York City that sells clothing online but they also have in-store style and clothing advice sessions. 
#Customers come in to the store, have sessions/meetings with a personal stylist, then they can go home and order either on a mobile app or website for the clothes they want.
#The company is trying to decide whether to focus their efforts on their mobile app experience or their website. They've hired you on contract to help them figure it out! Let's get started!

#Import
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

#Get and read data
customers = pd.read_csv("Ecommerce Customers.csv")
customers.describe()
customers.head()
customers.info()
customers.columns

#EDA (should the company focus on their website or app?)

#Maybe more time on website correlates to more money spent?
sns.jointplot(x='Time on Website',y='Yearly Amount Spent',data=customers)

#Maybe more time on app correlates to more money spent?
sns.jointplot(x='Time on App',y='Yearly Amount Spent',data=customers)

#Maybe more time on app correlates to an increase in membership lenght?
sns.jointplot(x='Time on App',y='Length of Membership',kind='hex',data=customers)

#Let's check all relationships between all quantitative variables
sns.pairplot(customers)

#There is definitely a correlation between the membership lenght and how much money the person spends (quite expected). Let's check it
sns.lmplot(x = "Length of Membership", y = "Yearly Amount Spent", data = customers)

#Training and Testing Data

#Let's place our independent variables in the X variable and our dependent variable in the Y variable
X = customers[['Avg. Session Length', 'Time on App', 'Time on Website', 'Length of Membership']]
y = customers['Yearly Amount Spent']

#Splitting X and y to the training and test sets
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)

#Importing our LinearRegression and training the model
from sklearn.linear_model import LinearRegression
lm = LinearRegression()
lm.fit(X_train,y_train)
print(lm.coef_)

#Testing and plotting
predictions = lm.predict(X_test)
plt.scatter(y_test,predictions)
plt.xlabel('Y Test')
plt.ylabel('Predicted Y')

#Evaluating our model's performance
from sklearn import metrics
print('MAE:', metrics.mean_absolute_error(y_test, predictions))
print('MSE:', metrics.mean_squared_error(y_test, predictions))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
print('R Squared:', metrics.explained_variance_score(y_test, predictions))

#Plotting our Residuals to check if it looks is normally distributed
sns.distplot((y_test-predictions),bins=50)

#Let's check our coefficients and answer the original question
coefficients = pd.DataFrame(lm.coef_,X.columns)
coefficients.columns = ['Coefficient']
coefficients

#Answer1 So it looks that the company should invest on their app, as our data shows that increasing by 1 unit on "Time on App" is associated with an increase of ~39$, as long as other features are fixed.
#Answer2: If they don't want to have "all their eggs in one basket" they should improve their website as well.
#Answer3: Length of Membership is actually where they should be focused, since a unit increase here is associated with an increase of ~62$.