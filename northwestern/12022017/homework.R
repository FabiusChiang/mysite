##Exercise 10.45 ----------------------------------------------------
importedData<-read.csv("/home/fabius/workspace/mysite/northwestern/CSV/Chapter\ 10/EX10-45SALES.csv")
attach(importedData)

importedData


## (a) The count of homes which have a sales price greater than the assessed value
diff <- SalesPrice - AssessedValue
isSalesGreaterThanAssessed <- function(x) 
{
    if (x>0) 
        return(TRUE) 
    else 
        return(FALSE)
}

length(Filter(isSalesGreaterThanAssessed, diff))

# Prepare the parameters for t distribution
m<-mean(diff)
n<-length(diff)
s<-sd(diff)/sqrt(n)

pt(m/s, df=n-1, lower.tail=F)


## (b) 
dataForScatterplot<-data.frame(AssessedValue, SalesPrice)
plot(dataForScatterplot, xlab="Assessed Value", ylab="Sales Price", main="Exercise 10.45 (b)")
## The correlation is:
# cor(BirthRate2011, Users)

modelAS<-lm(SalesPrice~AssessedValue)
abline(modelAS)

## (c)
filteredData<-importedData[-27,]
modelFilteredAS<-lm(filteredData$SalesPrice~filteredData$AssessedValue)
abline(modelFilteredAS, col='blue')

## (d)
summary(modelAS)

## (e)
summary(modelFilteredAS)


##Exercise 10.46 ----------------------------------------------------
estimateY <- function(x){
    9.43181 + 1.123 * x
}
estimatedSalesPrice<-sapply(filteredData$AssessedValue, estimateY, simplify="array")
diffOfY<-filteredData$SalesPrice-estimatedSalesPrice

## (a)
dataForScatterplot<-data.frame(filteredData$AssessedValue, diffOfY)
plot(dataForScatterplot, xlab="Assessed Value", ylab="Residuals", main="Exercise 10.46 (a)")
abline(modelFilteredAS, col='blue')

## (b)
hist(diffOfY, bre=6, main="10.46 (b) The difference between observed Y and the estimated Y")
## The value of residuals don't match Normal but "linear + Normal noise".
## From the histograph of the difference between observed Y and the estimated Y, we can infer the "difference" matches Normal roughly

## (c)
## Yes, the statistical inference is satified -- the difference between observed Y and the estimated Y is due to the random noise, which matches Normal roughly.

## (d)
#From the summary(modelFilteredAS) we know the mean of slope is 1.123 and the standard error of slope is 0.08295
#The corresponding t of the 95% confidence level is:
t<-qt(0.95+(1-0.95)/2, df=32)
m<-t*0.08295
1.123-m
1.123+m

## (e)
# t<-