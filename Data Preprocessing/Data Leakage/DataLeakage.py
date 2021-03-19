# -*- coding: utf-8 -*-
#Data leakage!


# test classification dataset
from sklearn.datasets import make_classification
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

# Here we are defining the dataset
X, y = make_classification(n_samples=1000, n_features=20, n_informative=15, n_redundant=5, random_state=7)
# Checking for the shape
print(X.shape, y.shape)



#Naive approach of data preparation

#To standarise the data, we will use the MinMaxScalar class from sklearn,preprocessing

# As you can see, in this approach, we are preparing the data before splitting!
scaler = MinMaxScaler()
X = scaler.fit_transform(X)

#Now we will split the data.
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=1)

#Finally we will fit a logistic regression model
model = LogisticRegression()
model.fit(X_train, y_train)

#Here we will be evaluating the model
yhat = model.predict(X_test)
#Printing the accuracy
accuracy = accuracy_score(y_test, yhat)
print('Accuracy: %.3f' % (accuracy*100))

#In this model, we got an accuracy of 84.848. Now, let us try the data preparation after training


# define dataset
X, y = make_classification(n_samples=1000, n_features=20, n_informative=15, n_redundant=5, random_state=7)
# split into train and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=1)
# define the scaler
scaler = MinMaxScaler()
# As you can see, here w did the preparation after the training
scaler.fit(X_train)
# scale the training dataset
X_train = scaler.transform(X_train)
# scale the test dataset
X_test = scaler.transform(X_test)
# fit the model
model = LogisticRegression()
model.fit(X_train, y_train)
# evaluate the model
yhat = model.predict(X_test)
# evaluate predictions
accuracy = accuracy_score(y_test, yhat)
print('Accuracy: %.3f' % (accuracy*100))

#At the end, we got a better accuracy of aout 0.3% more!
