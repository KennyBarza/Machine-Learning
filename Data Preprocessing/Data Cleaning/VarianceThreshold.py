#In this section, we will be removing columns that have a low variance uisng VarianceThreshold()
# example of apply the variance threshold. Note that our data is full of numerical data. So if we got
#a value of 2, it would be reasonable for a categorical variable, but unreasonable for a numerical value!
from pandas import read_csv
from sklearn.feature_selection import VarianceThreshold
# define the location of the dataset
path = 'https://raw.githubusercontent.com/jbrownlee/Datasets/master/oil-spill.csv'
# load the dataset
df = read_csv(path, header=None)
# split data into inputs and outputs.
data = df.values
X = data[:, :-1]
y = data[:, -1]
print(X.shape, y.shape)
# Here we are defining the VarianceThreshold
transform = VarianceThreshold()
# We are applying it the the X variable. We could see that they 1 is removed.
X_sel = transform.fit_transform(X)
print(X_sel.shape)
