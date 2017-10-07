##Exercise 1.118 ----------------------------------------------------

drawShadeInNorm <- function(begin, end, title) {
    cord.x <- c(begin,seq(begin,end,0.01),end) 
    cord.y <- c(0,dnorm(seq(begin,end,0.01)),0) 
    curve(dnorm(x,0,1),xlim=c(-6,6),main=title) 
    polygon(cord.x,cord.y,col='skyblue')
    abline(0,0)
}

## Z > 1.75
p<-(1-pnorm(1.75))
## The portion is 
p*100
drawShadeInNorm(1.75, 6, "Exercise 1.118  Z > 1.75")

## Z < 1.75
p<-pnorm(1.75)
## The portion is 
p*100
drawShadeInNorm(-6, 1.75, "Exercise 1.118  Z < 1.75")

## Z > -0.80
p<-(1-pnorm(-0.80))
## The portion is 
p*100
drawShadeInNorm(-0.8, 6, "Exercise 1.118  Z > -0.80")

## -0.80 < Z < 1.75
p<-(pnorm(1.75) - pnorm(-0.80))
## The portion is 
p*100
drawShadeInNorm(-0.8, 1.75, "Exercise 1.118  -0.80 < Z < 1.75")


##Exercise 1.122 ----------------------------------------------------
## As WAIS matches Normal with mean 100 and standard deviation 15 approximately, 
## we just need to get P(IQ<70) per Normal(100, 15).
## So the result is:
pnorm(70, 100, 15)


##Exercise 2.5 ----------------------------------------------------
## Question (a)
## The cases are all the tweets posted on tweets of "you" and "nine of your friends" during a week;

## Question (b)
##  Categorical variables: the day of the week, the sex of the person posting the tweet;
##  Quantitative variables: the number of click counts, the time of day, the length of the tweet;

## Question (c)
##  The day of the week, the sex of the person posting the tweet, the time of day and the length of the tweet could be explanatory variables;
##  the number of click counts is the response click.
##  Below examples should help to explain the association.
##      Time and day: a tweet posted in the middle night may not get many clicks;
##      a tweet posted at 8:00 AM of weekday may receive more clicks than a tweet posted at 8:00 AM of weekend; because more people may be commuting to office and using tweet to kill time at 8:00 AM on weekdays, but very possible more people may be in bed at 8:00 AM on weekend.
##      Gender of poster: tweets posted by females may receive more clicks because females maybe better at communication and own more friends;
##      Length of the tweets: too short tweets may be non-sense and won't be clicked by many times; too long tweets may be easily ignored as Internet users may be not so patient to read longer text; tweets with median length may be more popular.



##Exercise 2.34 ----------------------------------------------------
## Question (a)
## From the numerical value, the 2 variables are negative association; the association is absolute but not every strong.

## Question (b)
## Suppose having birth is event B and surfing Internet is event C; if there is a lurk factor which affects
## event B and event C at the same time, we can see the statistic of B and C are accociation in numerical value.
## However we cannot prove B and C are related logically because they are related in numerical value.
## In fact, the lurk factor might be the development level: 
## The more devloped the country is, the lower birth ratio the country; at the same time the higher Internet user ratio the country owns.


##Exercise 2.59 ----------------------------------------------------
birthAndInternetUser<-read.csv("/home/fabius/workspace/mysite/northwestern/CSV/Chapter\ 2/EX02-059INBIRTH.csv")
attach(birthAndInternetUser)
## Question (a)
dataForScatterplot<-data.frame(Users, BirthRate2011)
plot(dataForScatterplot, xlab="Internet users", ylab="Birth", main="Exercise 2.59 (a)")
## The correlation is:
cor(BirthRate2011, Users)

## Question (b)
## No, it's not a numerical summary -- there is a trend but the trend is not strong or the trend is not linear. Genernally the more devloped the country is, the lower birth ratio the country 
## owns. The users of Internet could be one of index to reflect the how developed a country is.


##Exercise 2.75 ----------------------------------------------------
studentsOfStates<-read.csv("/home/fabius/workspace/mysite/northwestern/CSV/Chapter\ 2/EX02-075COLLEGE.csv")
attach(studentsOfStates)
dataForScatterplot<-data.frame(Population, Undergrads)

## Question (a)
plot(dataForScatterplot, main="Exercise 2.75 (a)")
## see below graph

## Question (b)
modelPU<-lm(Undergrads~Population)
yfit<-modelPU$fitted.values
lines(Population, yfit)
## from the the graph, there is an outlier in the top-right

## Question (c)
meanX<-5955551
sdX<-6620733
meanY<-302136
sdY<-358460
r<-0.98367

b1<-(r*sdY/sdX)
b0<-(meanY-b1*meanX)

b0
b1
## So the equation of regression line is y=-15044.15+0.0532579*x (y is undergrads and x is population)


##Exercise 2.76 ----------------------------------------------------
nMeanX<-4367448
nSdX<-3310957
nMeanY<-220134
nSdy<-165270
nr<-0.97081

nb1<-(nr*nSdy/nSdX)
nb0<-(nMeanY-b1*nMeanX)

nb0
nb1

## Reuse the "dataForScatterplot" variable from exercise 2.75
plot(dataForScatterplot, main="Exercise 2.76")
## Draw the least-squares regression line based on all data
abline(b0, b1, col="blue")
## Draw the least-squares regression line eliminating the for largest states
abline(nb0, nb1, col="gray")


##Exercise 2.77 ----------------------------------------------------
## Question (a)
## Per excercise 2.75 (c) -- the equation of regression line is y=-15044.15+0.0532579*x (y is undergrads and x is population)
x<-4000000
predictedGraduats<-(-15044.15+0.0532579*x)
## The predicted number of undergraduate students is: 
predictedGraduats

## Question (b)
predictedGraduats<-(nb0+nb1*x)
## The predicted number of undergraduate students based on statistic of 46 states is: 
predictedGraduats

## Question (c)
## From the graph "Exercise 2.76", we can see the main outlier is the largest state
## The largets state is much higher than the blue line
## The other 3 states with more than 15 million population are under the blue line, but they are closer to the blue line comparing 
## with the largest state
## So we get the gray by eliminate the 4 large state; the x-coordinate of crossing of the gray line and blue line is about 1.0e+6
## So we get lower predicted value when using gray line to predict when x-coordinate is 4.0e+6, comparing with the result predicted by gray line.


##Exercise 2.128 ----------------------------------------------------
hospitalA<-c(6, 594)
hospitalB<-c(8, 592)
casesOfGoodCondition<-data.frame( hospitalA, hospitalB);

hospitalA<-c(57, 1443)
hospitalB<-c(8, 192)
casesOfPoorCondition<-data.frame( hospitalA, hospitalB);

calculateDeathRate <- function (data, ...) {
    data[1]/sum(data)
}

## Question (a)
## The death rate under poor condition of 2 hospitals
apply(casesOfPoorCondition, 2, calculateDeathRate)

## Question (b)
## The death rate under good condition of 2 hospitals
apply(casesOfGoodCondition, 2, calculateDeathRate)

## Question (c)
## No matter under good conditions or poor conditions, the death rate in hospital A is lower;
## So I trust in hospital A more than hospital B based on the statistics of died/survived statistic under good conditions and poor conditions.

## Question (d)
casesOfOverrallCondition<-casesOfGoodCondition + casesOfPoorCondition
## The overrall death rate of 2 hospitals
apply(casesOfOverrallCondition, 2, calculateDeathRate)
## From the overrall result, we can see the death rate is higher in hospital A.
## It's because hospital A accepts much more "poor" patients comparing with hospital B; at the same time the quantity of poor patients in hospital A is much more than the good
## thus absolute quantity of died patients in hospital A is much higher than hospital B and the quantity contributes considerably to the death count in the overrall statistics of
## hospital A, though the relative death rate in lower in hospital A.

## If suppose all other data is fixed and the rate of death rate of poor patients in hospital A is fixed as 57/1443=0.038;
## set the number of poor patients in hospital A is the independent variable and the overrall death rate of hospital A is the dependent variable;
## we can use below function to calculate the dependent variable from independent variable:

calculateDeathRateOfHospitalA <- function (totalPoorPatientInA) {
    (6+totalPoorPatientInA*57/1443)/(600+totalPoorPatientInA)
}

curve(calculateDeathRateOfHospitalA, 0, 8000,main="Exercise 2.128", xlab="Total poor patients in A", ylab="Overrall death rate of A") 

## The curve shows the more poor patients accepted by hospital A, the higher the death rate of hospital A is. But the death rate is in [0.01, 0.038)