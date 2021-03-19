# Here, we will be doing the a k fold cross validation before and after splitting the data.

from numpy import mean
from numpy import std
from sklearn.datasets import make_classification
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import RepeatedStratifiedKFold
from sklearn.preprocessing import MinMaxScaler
from sklearn.linear_model import LogisticRegression
# We will use the same dataset as before
X, y = make_classification(n_samples=1000, n_features=20, n_informative=15, n_redundant=5, random_state=7)
# Doing the standarization wit MinMaxScaler
scaler = MinMaxScaler()
X = scaler.fit_transform(X)
# define the model
model = LogisticRegression()
# We are doing a stratified k fold. Here, we splitted the data into 1 folds and we repeated 3 times
cv = RepeatedStratifiedKFold(n_splits=10, n_repeats=3, random_state=1)
# evaluate the model using cross-validation. We should expect to have 30 accuracy.
scores = cross_val_score(model, X, y, scoring='accuracy', cv=cv, n_jobs=-1)
# We do the mean of every accuracy
print('Accuracy: %.3f (%.3f)' % (mean(scores)*100, std(scores)*100))
