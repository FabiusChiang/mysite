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
## (a)
dataForScatterplot<-data.frame(filteredData$AssessedValue, filteredData$SalesPrice)
plot(dataForScatterplot, xlab="Assessed Value", ylab="Sales Price", main="Exercise 10.46 (a)")
abline(modelFilteredAS, col='blue')