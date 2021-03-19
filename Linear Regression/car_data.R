#--------------------------------------------------------------------------------------------------------------------
#					 Estimating the distance of car 
#
# The goal here is to establish a mathematical equation for "dist"
# as a function of speed, so you can use it to predict "dist" 
# when only the "speed" of the car is known.
# You will find the data in a file called "car_data1.txt".
#--------------------------------------------------------------------------------------------------------------------

# 1) Preparing the data
#------------------------------------------------------------------------------

# a) Choosing Working Directory
#------------------------------------------------------------------------------
# Define your directory : It's the place(file) where you can find your data.
# For example if your file "car_data1.txt" is on your Desktop, then Desktop is your directory.
# In order ot choose your Directory, go to Toolbar: "Session" --> "Set Working Directory"-->"Choose Directory" 
# and select the desired file.


# b) Importation of the data "car_data1.txt"
#------------------------------------------------------------------------------
# The extention of this data is ".txt" so the function used to read the data is "read.table".
# The parameters of this functions used here are two
# 1) The name of the data file which must be found in the directory you're on. In this case "car_data1.txt".
# 2) The parameter "header" to determine whether the first line of the table is the table's header or not.
#    In this case, "header =T" or "header=TRUE". 
getwd()
setwd("C:/Users/keven/Desktop/regression")
car = read.table("car_data1.txt", header=T) 

# You can see now in the "Global Environment" on the left your data
# In order to see the table content, you can click on the data and a new tab will open.
# You can see that our sample has 50 observations and 2 variables.
# The variables are dist and speed.

# c) Getting to know your data
#------------------------------------------------------------------------------
# For the "Speed": to select the variable speed you use the term "car$speed".
# For the "dist": to select the variable speed you use the term "car$dist".
# The symbol $ is used when we have a data with a list of attributes forming it.

dim(car)
n=dim(car)[1]
p=dim(car)[2]
summary(car$speed)
summary(car$dist)

# d) Plotting the data
#------------------------------------------------------------------------------
# We are using dist as the response variable and Speed as the regressor

# Scatter Plot 
plot(car$speed,car$dist,main='The Scatter plot of the Data ',xlab='distance',ylab='speed',col='red',pch=19)
text(car$speed,car$dist, row.names(car), cex=0.6, pos=4, col="red")

# Box plot 
par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(cars$speed, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(cars$speed)$out))  # box plot for 'speed'
boxplot(cars$dist, main="Distance", sub=paste("Outlier rows: ", boxplot.stats(cars$dist)$out))  # box plot for 'distance'


# e) Correlation Analysis
#------------------------------------------------------------------------------
cor(cars$speed, cars$dist)  # calculate correlation between speed and distance 


#-------------------------------------------------------------------------------------
# 2)	Fitting the data
#-------------------------------------------------------------------------------------

# a) Building the model
#------------------------------------------------------------------------------
# The function used for building linear models is lm(), 
# it takes in two main arguments: Formula and Data. 
# The data is typically a data.frame object 
# and the formula is a object of class formula. 
# The most common convention is to write out the formula directly as written here.

linMod=lm(formula=dist~speed, data=car)

# b) Attributes
#------------------------------------------------------------------------------
# If you look in "Global Environment", you can see that "regression" is a list of 12.
# To see its attributes:

attributes(linMod) # Check out details in Help for function "lm".

#-------------------------------------------------------------------------------------
# 3)	Linear regression diagnostic:
#-------------------------------------------------------------------------------------

# a) Evaluating the model : Summary
#------------------------------------------------------------------------------

summary(linMod)

# capture model summary as an object
modelSummary <- summary(linMod) 

# b) Using the p-value to check for statistical significance.
#------------------------------------------------------------------------------

# c) Confidence Interval
#------------------------------------------------------------------------------
# Use the function confint where you should determine the regression ("linMod") and the level.

confint(linMod, level=0.95)

# d) Rsquared of the model
#------------------------------------------------------------------------------
# Use Extract the R-squared found in summary

Rsquared=modelSummary$r.squared


#-------------------------------------------------------------------------------------
# 4)	Linear regression plots diagnostic:
#-------------------------------------------------------------------------------------

par(mfrow=c(2,2)) # If you would like to have the 4 plots on the same page
plot(linMod)



# 5) Prevision interval
#-------------------------------------------------------------------------------
# Predict the price for a car with a speed equal to 30
# And  its prevision interval

predict(linMod,data.frame(speed=30),interval="prediction",level=0.95)





