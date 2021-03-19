#Dropping Duplicates rows is very easy. Here is the code!

from pandas import read_csv
# define the location of the dataset
path = 'https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv'
# load the dataset
df = read_csv(path, header=None)
print(df.shape)
# delete duplicate rows. 
df.drop_duplicates(inplace=True)
print(df.shape)