#--------------------------------------------------------------------------------------------------------------------
#					 Estimating the price of car 
# The goal here is to establish a mathematical equation for
# the price of a car as a function of "Cyl", "Power", "Height", "Width", "Weight" and "Speed"
# so you can use it to predict "price" 
# when only the proprieties above of the car is known.
# You will find the data in a file called "car_data.txt".
# We propose to study the relation between the price of a car and the following variables:
# cylinder, power, Height, width, weight and speed of 18 cars.
# You will find the data in a file called "car_data.txt".
#--------------------------------------------------------------------------------------------------------------------

# 1) Preparing the data
#------------------------------------------------------------------------------

# a) Choosing Working Directory
#------------------------------------------------------------------------------
# Define your directory : It's the place(file) where you can find your data.
# For example if your file "car_data.txt" is on your Desktop, then Desktop is your directory.
# In order ot choose your Directory, go to Toolbar: "Session" --> "Set Working Directory"-->"Choose Directory" 
# and select the desired file.


# b) Importation of the data "car_data.txt"
#------------------------------------------------------------------------------
# The extention of this data is ".txt" so the function used to read the data is "read.table".
# The parameters of this functions used here are two
# 1) The name of the data file which must be found in the directory your on. In this case "car_data.txt".
# 2) The parameter "header" to determine whether the first line of the table is the table's header or not.
#    In this case, "header =T" or "header=TRUE". 
getwd()
setwd("C:/Users/keven/Desktop/regression")

car = read.table("car_data.txt", header=T) 

# You can see now in the "Global Environment" on the left your data
# In order to see the table content, you can click on the data and a new tab will open.
# You can see that our sample has 18 observations and 9 variables.
# The variables that we are going to choose are, as mentioned, price and power.

# c) Getting to know your data
#------------------------------------------------------------------------------
# In order to see your variables you can use the function summary 

dim(car)
n=dim(car)[1]
p=dim(car)[2]
summary(car$Power)
summary(car)

# c) Plotting the data
#------------------------------------------------------------------------------
# We are using Price as the response variable and each variable as the regressors
# We can have an idea on how the price is explained by each variable and locate suspected outliers

# Box plot 
par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(car$Speed, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(car$Speed)$out)) 
boxplot(car$Price, main="Price", sub=paste("Outlier rows: ", boxplot.stats(car$Price)$out))  
boxplot(car$Cyl, main="Cyl", sub=paste("Outlier rows: ", boxplot.stats(car$Cyl)$out))  
boxplot(car$Power, main="Power", sub=paste("Outlier rows: ", boxplot.stats(car$Power)$out))  
boxplot(car$Height, main="Height", sub=paste("Outlier rows: ", boxplot.stats(car$Height)$out))  
boxplot(car$Width, main="Width", sub=paste("Outlier rows: ", boxplot.stats(car$Width)$out))  
par(mfrow=c(1, 1))
boxplot(car$Weight, main="Weight", sub=paste("Outlier rows: ", boxplot.stats(car$Weight)$out[1],boxplot.stats(car$Weight)$out[2],boxplot.stats(car$Weight)$out[3]))  

# Scatter Plot 
plot(car$Cyl,car$Price,main='The Scatter plot of the Data ',xlab='Cyl',ylab='Price',col='red',pch=19)
text(car$Cyl,car$Price, row.names(car), cex=0.6, pos=4, col="red")

plot(car$Weight,car$Price,main='The Scatter plot of the Data ',xlab='Weight',ylab='Price',col='red',pch=19)
text(car$Weight,car$Price, row.names(car), cex=0.6, pos=4, col="red")


# e) Correlation Analysis
#------------------------------------------------------------------------------
car = car[,-c(1,8)]
cor(car) # calculate the correlation matrix 


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

linMod=lm(Price~Cyl + Power + Height + Width + Weight +Speed, car)

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
# Use the function confint where you should determine the regression ("regression") and the level.

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


#-------------------------------------------------------------------------------
# 5)	Finding a more restrained model
#-------------------------------------------------------------------------------

# a) Removing the suspected outlier 
#-------------------------------------------------------------------------------
car1 = car[-18,]

# b) Fitting the new data
#-------------------------------------------------------------------------------
linMod1 = lm(Price~Cyl + Power + Height + Width + Weight +Speed, car1)
attributes(linMod1) # Check out details in Help for function "lm".

# c)	Linear regression diagnostic:
#-------------------------------------------------------------------------------------
summary(linMod1)
modelSummary1 <- summary(linMod1) 
confint(linMod1, level=0.95)
Rsquared=modelSummary1$r.squared

# c) Linear regression plots diagnostic:
#-------------------------------------------------------------------------------
par(mfrow=c(2,2))
plot(linMod1)

# d) Prevision interval
#-------------------------------------------------------------------------------
# Predict the price for a car with Cyl= 1300, Power= 83, Height= 401, Width= 160, Weight= 867, Speed=163
# And  its prevision interval

predict(linMod1,data.frame(Cyl= 1300, Power= 83, Height= 401, Width= 160, Weight= 867, Speed=163),interval="prediction",level=0.95)





