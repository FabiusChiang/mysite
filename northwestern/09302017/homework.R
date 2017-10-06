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
p
drawShadeInNorm(1.75, 6, "Exercise 1.118  Z > 1.75")

## Z < 1.75
p<-pnorm(1.75)
p
drawShadeInNorm(-6, 1.75, "Exercise 1.118  Z < 1.75")

## Z > -0.80
p<-(1-pnorm(-0.80))
p
drawShadeInNorm(-0.8, 6, "Exercise 1.118  Z > -0.80")

## -0.80 < Z < 1.75
p<-(pnorm(1.75) - pnorm(-0.80))
p
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
## In fact, the lurk factor is the development level: 
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
## Yes, it's a good numerical summary. Genernally the more devloped the country is, the lower birth ratio the country 
## owns. The users of Internet could be one of index to reflect the how developed a country is.


##Exercise 2.75 ----------------------------------------------------


