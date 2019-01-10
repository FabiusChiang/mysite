##Exercise 6.137 ----------------------------------------------------

drawShadeInNorm <- function(begin, end, title, sigma) {
    begin <- begin * sigma
    end <- end * sigma
    cord.x <- c(begin,seq(begin,end,0.01),end) 
    cord.y <- c(0,dnorm(seq(begin,end,0.01), 0, sigma),0) 
    curve(dnorm(x,0,sigma),xlim=c(-6 * sigma,6 * sigma),main=title) 
    polygon(cord.x,cord.y,col='skyblue')
    abline(0,0)
}

drawShadeInNorm(6.9/(55/sqrt(104)), 6, "Exercise 6.137 (a)", 55/sqrt(104))


##Exercise 6.141 ----------------------------------------------------
x<-rnorm(15, 20, 5)
x
miu=mean(x)
sigma=5/sqrt(15)
startOfConfidenceInterval=miu-1.96*sigma
startOfConfidenceInterval
endOfConfidenceInterval=miu+1.96*sigma
endOfConfidenceInterval

count<-0
sigma <- 5/sqrt(15)
for (i in 1:100) {
    x<-rnorm(15, 20, 5)
    miu<-mean(x)
    startOfConfidenceInterval <- miu-1.96*sigma
    
    endOfConfidenceInterval <- miu+1.96*sigma
    if (startOfConfidenceInterval<20 && endOfConfidenceInterval>20){
        count <- count +1
    }
    i
    count
}
##During the 100 repeating, the miu appears in confidence interval for following times:
count


##Exercise 7.27 ----------------------------------------------------
## (a)
importedData<-read.csv("/home/fabius/workspace/mysite/northwestern/CSV/Chapter\ 7/EX07-027UBERX.csv")
attach(importedData)
hist(Earnings, bre=6, main="7.27 (a).1 histogram")
boxplot(Earnings, main="7.27 (a).2 boxplot")
qqnorm(Earnings, main="7.27 (a).3 normal quantile")

## (b)
sd(Earnings)
mean(Earnings)
sd(Earnings)/sqrt(length(Earnings))
length(Earnings)-1


## (c)
earningsPerYear=Earnings*40*52
sd(earningsPerYear)
mean(earningsPerYear)
sd(earningsPerYear)/sqrt(length(earningsPerYear))
length(earningsPerYear)-1


##Exercise 7.40 ----------------------------------------------------
## (a)
importedData<-read.csv("/home/fabius/workspace/mysite/northwestern/CSV/Chapter\ 7/EX07-040JOCKO.csv")
attach(importedData)

importedData
diff<-Jocko-Other
diff

## a)
mean(diff)
sd(diff)

## b)
sd(diff) / sqrt(length(diff))