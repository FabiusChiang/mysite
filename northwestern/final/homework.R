
importedData<-read.delim("data.txt")

attach(importedData)

## Question 5.1
dataForScatterplot<-data.frame(x_i, y_i)
plot(dataForScatterplot, xlab="X", ylab="Y", main="Final Exam Question#5")

modelXY<-lm(y_i~x_i)
abline(modelXY)


## Question 5.2
## The point in the middle bottom is most likely to be an outlier because the distance between the estimated Y of the Y of the point is the farthest.


## Question 5.3
## The correlation between the two vaiables is:
cor(x_i, y_i)


## Question 5.4
## The line has been drawed in question#5.1
## The summary of the model is 
summary(modelXY)

## So the equation of the line is y = 253.185 + 31.206 * x


## Question 5.5
## Null Hypothesis is b1 = 0
## The HA is b1 != 0
t<-(31.206-0)/2.895
pt(t, df=60-2, lower.tail=F)
## The P-Value is so small, so it's significance and b1 is not 0


## Question 5.6
## The trend of the spots is absotlute; almost all spots are closed to the line got per linear regression.
## At the same time we got it's almost impossible that b1 is 0. 
## According to the diagram generated in question 5.1/5.4 and the calculation of 5.5, we get the same conslusion: the correlation between X and Y is strong.

## Question 5.7
summary(x_i)

ymean<- 253.185 + 31.206 * 21.13
ymean

ymedian<- 253.185 + 31.206 * 21
ymedian


## Question 5.8
t<-qt(0.95+(1-0.95)/2, df=60-2)
m<-t*2.895
31.206-m
31.206+m

## Question 5.9
## We konw y=b0+b1x
## We know the distribution of b0 and b1, we know the exact value of x
## So y=b0+30b1 (then we can calculate the mean of y and the sigma of y per the distribution of b0 and b1)