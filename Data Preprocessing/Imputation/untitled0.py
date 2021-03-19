from numpy import mean
from numpy import std
from pandas import read_csv
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import RepeatedStratifiedKFold
from sklearn.linear_model import LogisticRegression
# load dataset
url = 'https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.csv'
dataframe = read_csv(url, header=None)
data = dataframe.values
# separate into input and output elements
X, y = data[:, :-1], data[:, -1]
# minimally prepare dataset
X = X.astype('float')
#Encoding!
y = LabelEncoder().fit_transform(y.astype('str'))
# define the model
model = LogisticRegression(solver='liblinear')
# define the evaluation procedure
cv = RepeatedStratifiedKFold(n_splits=10, n_repeats=3, random_state=1)
# evaluate the model
m_scores = cross_val_score(model, X, y, scoring='accuracy', cv=cv, n_jobs=-1)
# summarize the result
print('Accuracy: %.3f (%.3f)' % (mean(m_scores), std(m_scores)))