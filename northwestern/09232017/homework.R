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
hist(x, main="this is main title", xlab="title of x", ylab="title of y", breaks=9)
boxplot(x)


##Section 8, #2 ----------------------------------------------------
x<- (-10):10
n<-length(x)
y<-rnorm(n,x,4)
plot(x,y)
abline(0,1)