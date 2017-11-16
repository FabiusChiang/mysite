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