##Section 2, #1 ----------------------------------------------------

x<-c(4,2,6)
y<-c(1,0,-1)

length(x)

sum(x)

sum(x^2)

x+y

x*y

x-2

x^2


##Section 2, #2 ----------------------------------------------------
7:11

seq(2,9)

seq(4,10,by=2)

seq(3,30,length=10)

seq(6,-4,by=-2)


##Section 2, #3 ----------------------------------------------------
rep(2,4)

rep(c(1,2),4)

rep(c(1,2),c(4,4))

rep(1:4,4)

rep(1:4,rep(3,4))


##Section 2, #4 ----------------------------------------------------
rep(6,6)

rep(c(5,8), 3)

rep(c(5,8), rep(4,2))


##Section 3, #1 ----------------------------------------------------
x<- c(5,9,2,3,4,6,7,0,8,12,2,9)

x[2]

x[2:4]

x[c(2,3,6)]

x[c(1:5,10:12)]

x[-(10:12)]


##Section 3, #2 ----------------------------------------------------
y<-c(33,44,29,16,25,45,33,19,54,22,21,49,11,24,56)

summaryMatrix<-matrix(y, nr=3)
#summary of each day
apply(summaryMatrix, 2, sum)

summaryMatrix<-matrix(y, nr=5, by=T)
#summary of each shop
apply(summaryMatrix, 2, sum)


##Section 5, #1 ----------------------------------------------------
attach(quakes)
summary(quakes[,3:4])


##Section 5, #2 ----------------------------------------------------
attach(mtcars)
#the mean weight
mean(wt)
#the mean of fuel consumption
mean(mpg)


##Section 8, #1 ----------------------------------------------------
x<-rnorm(100)
hist(x, main="Section 8, #1 Graph#1", xlab="title of x", ylab="title of y", breaks=9)
boxplot(x, main="Section 8, #1 Graph#2")


##Section 8, #2 ----------------------------------------------------
x<- (-10):10
n<-length(x)
y<-rnorm(n,x,4)
plot(x,y, main="Section 8, #2")
abline(0,1)


##Section 8, #3 ----------------------------------------------------
data(nhtemp)
plot(nhtemp, main="Section 8, #3")


##Section 8, #4 ----------------------------------------------------
temp<-as.vector(nhtemp)
plot(1912:1971,temp, main="Section 8, #4, Graph#1")
plot(1912:1971,temp,type="l", main="Section 8, #4, Graph#2")
plot(1912:1971,temp,type="b", main="Section 8, #4, Graph#3")


##Other exercises

##5. Consider the following data set...
x<-c(97, 82, 85, 61, 14, 22, 51, 16, 55, 44, 70)
summary(x)
## About the different method to Q1 and Q3: the median is included as the part of "half" 
## while calcualting the Q1 and Q3
boxplot(x, main="Other exercises #5")
## IRQ equlas Q3-Q1=43;
## nothing is more than (Q3+1.3*IRQ)
## nothing is less than (Q1-1.3*IRQ)
## so there is no outliner



##6. Textbook Exercise 1.128
## To get "what is his percentile", just need to know "how many people get less than 2050 in pencentage"
## The distrubtion of SAT matches N(1498, 316) according to the declaration
## As z=(2050-1498)/316=1.746835
## By query the table of standard normal distribution, we get:
## P(x<1.746835) = 0.9599 = 95.99%
## So his percentile is 96%


##7. Textbook Exercise 1.162
id<-c("AA", "EE", "II", "BB", "FF", "JJ", "CC", "GG", "KK", "DD", "HH", "LL", "Other")
spamCount<-c(1818, 399, 251, 1358, 389, 178, 442, 304, 158, 416, 251, 103)
## How many did the others receive in total:
othersInTotal<-6693-sum(spamCount)
othersInTotal
spamCountWithOther<-c(spamCount, othersInTotal)

allData<-data.frame(id, spamCountWithOther)
allData<-allData[ order(-allData[,2]), ]
pie.spamCount <- allData[,2]
names(pie.spamCount) <- allData[,1]
pie(pie.spamCount, main="Other exercises #7. Textbook Exercise 1.162")