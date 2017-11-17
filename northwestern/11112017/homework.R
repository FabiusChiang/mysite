##Exercise 7.126 ----------------------------------------------------
importedData<-read.csv("/home/fabius/workspace/mysite/northwestern/CSV/Chapter\ 7/EX07-126PAIRED.csv")
attach(importedData)

## (a)
m1<-mean(Group1)
sd1<-sd(Group1)
sd1

m2<-mean(Group2)
sd2<-sd(Group2)
sd2

mOfPair<-m1-m2
sdOfPair<-sqrt(sd1*sd1/length(Group1)+sd2*sd2/length(Group2))
## Thus the mean difference of the pair is:
mOfPair
## Thus the standard deviation of the difference of the pair is:
sdOfPair

tOfPair<-(mOfPair-0)/sdOfPair
tOfPair

##As it's 2 sided alternative, the P-Value is 
2*pt(tOfPair, df=9)

## (b)
mOfDifference<-mean(Group1-Group2)
sdOfDifference<-sd(Group1-Group2)
## Mark "the difference in 2 data collection of individual I" is the "parameter P of individual I"
## Thus the mean of parameter P of the 10 individuals is:
mOfDifference
## Thus the standard deviation of parameter P of the 10 individuals is:
sdOfDifference

tOfDifference<-(mOfDifference-0)/(sdOfDifference/sqrt(length(Group1-Group2)))
tOfDifference

##As it's 2 sided alternative, the P-Value is 
2*pt(tOfDifference, df=9)


##Exercise 7.128 ----------------------------------------------------
## (a)
meanOfDifference <- 158.03 - 189.49
sdOfDifference <- sqrt(33.8^2/308+41.3^2/317)
meanOfDifference
sdOfDifference
TwoSidedPValue<-2*pt(meanOfDifference/sdOfDifference, df=307)
## So the P-Value is 
TwoSidedPValue

## (b)
t<- qt((1-0.95)/2, df=307)
abs(t*sdOfDifference)

##Exercise 8.29 ----------------------------------------------------
calculateConfidenceInterval <- function(confidenceLevel, p, sizeOfSample) {
    t<- qt((1-confidenceLevel)/2, df=(sizeOfSample-1))
    sd<- sqrt(p*(1-p)/sizeOfSample)
    m<-abs(t*sd)
    print(p-m);
    print(p+m);
}

## (a)
calculateConfidenceInterval(0.95, 0.6, 40)

## (b)
calculateConfidenceInterval(0.95, 0.6, 80)