library(tidyverse)
library(sqldf)
library(glmnet)
#install.packages("glmnet")
library(glmnet)

ord=read.csv("C://Users//fjiang4//share//mysite//northwestern//project2//orders.csv")
ord$t = as.numeric(as.Date("2014/11/25") - as.Date(ord$orddate, "%d%b%Y"))/365.25

summary(ord$t)
hist(ord$t)


customer=read.csv("C://Users//fjiang4//share//mysite//northwestern//project2//customer.csv")
table(customer$train)
head(customer)

rfm = ord %>%
  group_by(id) %>%
  summarise(tof=max(t), r = min(t), fitem=n(), ford=n_distinct(ordnum), m=sum(price*qty)) 

cats = sort(unique(ord$category))  # list of all unique categories
rfm2 = ord %>%
  group_by(id, category) %>%
  summarise(f=n()) %>%
  spread(category,f, fill=0)  %>%
  setNames(c("id", paste("f", cats, sep="")))

head(rfm2)


allData = left_join(customer, rfm, by="id") %>%
  left_join(rfm2, by="id")
summary(allData)
names(allData)

head(allData)

train=sqldf("SELECT a.*, c.logtarg as logtarg FROM allData a JOIN customer c ON (a.id = c.id AND c.train = 1)")
head(train)

purchase=sqldf("SELECT * FROM train WHERE logtarg > 0")

#########Training data has been ready
checkTrend = function(x, y, runningMC=10) {
	newDS = data.frame(x, y);
	orderedDS = newDS[order(newDS$x),]
	aggregateCount=0
	aggregateX=c()
	aggregateY=c()
	resultX=c()
	resultY=c()
	dsLength = nrow(orderedDS)
	for(row in 1:dsLength ) {
		aggregateCount = aggregateCount + 1;
		aggregateX = append(aggregateX, orderedDS$x[row]);
		aggregateY = append(aggregateY, orderedDS$y[row]);
		if (aggregateCount == runningMC || row == dsLength  ) {
			resultX = append(resultX, mean(aggregateX));
			resultY = append(resultY, mean(aggregateY));
			aggregateCount = 0;
			aggregateX=c()
			aggregateY=c()
		}
	}

	plot(resultX, resultY,pch=16, col=grey(.5))
}

checkTrend(purchase$tof, purchase$logtarg, 5)
checkTrend(purchase$tof, purchase$logtarg, 10)
checkTrend(purchase$tof, purchase$logtarg, 30)

checkTrend(purchase$r, purchase$logtarg, 5)
checkTrend(purchase$r, purchase$logtarg, 10)
checkTrend(purchase$r, purchase$logtarg, 30)

checkTrend(purchase$tof-purchase$r, purchase$logtarg, 5)
checkTrend(purchase$tof-purchase$r, purchase$logtarg, 10)
checkTrend(purchase$tof-purchase$r, purchase$logtarg, 30)

checkTrend(purchase$fitem, purchase$logtarg, 5)
checkTrend(purchase$fitem, purchase$logtarg, 10)
checkTrend(purchase$fitem, purchase$logtarg, 30)

checkTrend(purchase$ford, purchase$logtarg, 5)
checkTrend(purchase$ford, purchase$logtarg, 10)
checkTrend(purchase$ford, purchase$logtarg, 30)

checkTrend(purchase$m, purchase$logtarg, 5)
checkTrend(purchase$m, purchase$logtarg, 10)
checkTrend(purchase$m, purchase$logtarg, 30)

head(purchase)
library(glmnet)

dependVar=as.matrix(purchase[,c(4:38)])
fit = cv.glmnet(dependVar, purchase$logtarg, alpha=0, nfolds=5)
#fit = glmnet(dependVar, purchase$logtarg, alpha=0, nfolds=5)
yhat=predict(fit, dependVar)
mean((purchase$logtarg-yhat)^2)

head(dependVar)
colnames(purchase)

purchase$tof2=purchase$tof^2
purchase$logtof=log(purchase$tof+1)
purchase$fitem2=purchase$fitem^2
purchase$logfitem=log(purchase$fitem+1)
purchase$ford2=purchase$ford^2
purchase$logford=log(purchase$ford+1)
purchase$m2=purchase$m^2
purchase$logm=log(purchase$m+1)
purchase$freq=purchase$ford/purchase$tof
purchase$freq2=purchase$freq^2
purchase$logfreq=log(purchase$freq)

colnames(purchase)

dependVar2=as.matrix(purchase[,setdiff(c(4:38, 41), c(4))])
#dependVar2=as.matrix(purchase[,c(4:38, 40)])
fit2 = cv.glmnet(dependVar2, purchase$logtarg, alpha=0, nfolds=5)
yhat2 = predict(fit2, dependVar2)
mean((purchase$logtarg-yhat2)^2)
#
testAveMSE = function(data, neededColumns, avoidColums, y, testTimes=20, isBinomal=FALSE) {
	dependVars = as.matrix(data[,setdiff(neededColumns, avoidCol ums)]);
	allMse = c();
	for(i in 1:testTimes ) {
		if (isBinomal) {
			model = cv.glmnet(dependVars , y, family="binomial", alpha=0, nfolds=5)
		}
		else {
			model = cv.glmnet(dependVars , y, alpha=0, nfolds=5)
		}

		yhatPerModel = predict(model , dependVars )
		mse = mean((y-yhatPerModel )^2)
		allMse = append(allMse , mse)
	}
	mean(allMse)
}


### result of tof
#  1   2   3 
#168 142 190 
#####
# 1  2  3 
#33 30 37 
#####
#resultCollection
#  1   2   3 
#349 313 338 

### test transformation of tof
### original x is the best, no clue shows the log(x) is better than x
resultCollection=c();
for (i in 1:100) {
	s1 = testAveMSE(purchase, c(4:38), c(), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 40), c(), purchase$logtarg)
	s3 = testAveMSE(purchase, c(4:38, 41), c(4), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
print("tof")
table(resultCollection)

### test transformation of fitem
### the log(x) is the best
resultCollection=c();
for (i in 1:20) {
	s1 = testAveMSE(purchase, c(4:38), c(), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 42), c(), purchase$logtarg)
	s3 = testAveMSE(purchase, c(4:38, 43), c(6), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
print("fitem")
table(resultCollection)

### test transformation of ford
### the x^2 is the best
resultCollection=c();
for (i in 1:100) {
	s1 = testAveMSE(purchase, c(4:38), c(), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 44), c(), purchase$logtarg)
	s3 = testAveMSE(purchase, c(4:38, 45), c(7), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
print("ford")
table(resultCollection)

### test transformation of m
### log(x) is the best
resultCollection=c();
for (i in 1:100) {
	s1 = testAveMSE(purchase, c(4:38), c(), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 46), c(), purchase$logtarg)
	s3 = testAveMSE(purchase, c(4:38, 47), c(8), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
print("m")
table(resultCollection)

### check if freq helps for the prediction
resultCollection=c();
for (i in 1:40) {
	s1 = testAveMSE(purchase, c(4:38), c(), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 48), c(), purchase$logtarg)
	s3 = 10 #testAveMSE(purchase, c(4:38, 48), c(), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
table(resultCollection)

testAveMSE(purchase, c(4:38), c(), purchase$logtarg)
testAveMSE(purchase, c(4:38, 48), c(), purchase$logtarg)

###
## 	s3 = testAveMSE(purchase, c(4:38, 48, 47, 49, 43), c(8), purchase$logtarg)
resultCollection=c();
for (i in 1:30) {
	s1 = testAveMSE(purchase, c(4:38, 48, 43, 44, 47, 49), c(8), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 48, 47, 49, 43), c(), purchase$logtarg)
	s3 = testAveMSE(purchase, c(4:38, 48, 47, 49, 43), c(8), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
table(resultCollection)

###
##	s2 = testAveMSE(purchase, c(4:38, 48, 47, 49, 43), c(), purchase$logtarg)
resultCollection=c();
for (i in 1:10) {
	s1 = testAveMSE(purchase, c(4:38, 48, 43, 44, 47, 49), c(), purchase$logtarg)
	s2 = testAveMSE(purchase, c(4:38, 48, 47, 49, 43), c(), purchase$logtarg)
	s3 = testAveMSE(purchase, c(4:38, 48, 46, 49, 43), c(8), purchase$logtarg)
	best = min(s1, s2, s3)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
}
table(resultCollection)


#########################
#########################
#########################
#########################
#########################
### step# of the two-steps: tell if the customer will buy or not

colnames(train)
colnames(purchase)

train$tof2=train$tof^2
train$logtof=log(train$tof+1)
train$fitem2=train$fitem^2
train$logfitem=log(train$fitem+1)
train$ford2=train$ford^2
train$logford=log(train$ford+1)
train$m2=train$m^2
train$logm=log(train$m+1)
train$freq=train$ford/train$tof
train$freq2=train$freq^2
train$logfreq=log(train$freq)
train$r2=train$r^2
train$logr=log(train$r)
train$willBuy=(train$logtarg>0)

colnames(train)
head(train)


### test transformation of tof
resultCollection=c();
for (i in 1:80) {
	s1 = testAveMSE(train, c(4:38), c(), train$willBuy, 10, TRUE)
	s2 = testAveMSE(train, c(4:38, 41), c(), train$willBuy, 10, TRUE)
	s3 = testAveMSE(train, c(4:38, 41), c(4), train$willBuy, 10, TRUE)
	s4 = testAveMSE(train, c(4:38, 40), c(), train$willBuy, 10, TRUE)
	best = min(s1, s2, s3, s4)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
	if (best == s4) {
		resultCollection=append(resultCollection, 4);
	}
}
print("tof")
table(resultCollection)

### test transformation of r
resultCollection=c();
for (i in 1:80) {
	s1 = testAveMSE(train, c(4:38), c(), train$willBuy, 10, TRUE)
	s2 = testAveMSE(train, c(4:38, 52), c(), train$willBuy, 10, TRUE)
	s3 = testAveMSE(train, c(4:38, 52), c(5), train$willBuy, 10, TRUE)
	s4 = testAveMSE(train, c(4:38, 51), c(), train$willBuy, 10, TRUE)
	best = min(s1, s2, s3, s4)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
	if (best == s4) {
		resultCollection=append(resultCollection, 4);
	}
}
print("r")
table(resultCollection)

### test transformation of fitem
resultCollection=c();
for (i in 1:10) {
	s1 = testAveMSE(train, c(4:38), c(), train$willBuy, 10, TRUE)
	s2 = testAveMSE(train, c(4:38, 43), c(), train$willBuy, 10, TRUE)
	s3 = testAveMSE(train, c(4:38, 43), c(6), train$willBuy, 10, TRUE)
	s4 = testAveMSE(train, c(4:38, 42), c(), train$willBuy, 10, TRUE)
	best = min(s1, s2, s3, s4)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
	if (best == s4) {
		resultCollection=append(resultCollection, 4);
	}
}
print("fitem")
table(resultCollection)

### test transformation of ford
resultCollection=c();
for (i in 1:10) {
	s1 = testAveMSE(train, c(4:38), c(), train$willBuy, 10, TRUE)
	s2 = testAveMSE(train, c(4:38, 45), c(), train$willBuy, 10, TRUE)
	s3 = testAveMSE(train, c(4:38, 45), c(7), train$willBuy, 10, TRUE)
	s4 = testAveMSE(train, c(4:38, 44), c(), train$willBuy, 10, TRUE)
	best = min(s1, s2, s3, s4)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
	if (best == s4) {
		resultCollection=append(resultCollection, 4);
	}
}
print("ford")
table(resultCollection)

### test transformation of m
resultCollection=c();
for (i in 1:10) {
	s1 = testAveMSE(train, c(4:38), c(), train$willBuy, 10, TRUE)
	s2 = testAveMSE(train, c(4:38, 47), c(), train$willBuy, 10, TRUE)
	s3 = testAveMSE(train, c(4:38, 47), c(8), train$willBuy, 10, TRUE)
	s4 = testAveMSE(train, c(4:38, 46), c(), train$willBuy, 10, TRUE)
	best = min(s1, s2, s3, s4)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
	if (best == s4) {
		resultCollection=append(resultCollection, 4);
	}
}
print("m")
table(resultCollection)

### test transformation of freq
resultCollection=c();
for (i in 1:10) {
	s1 = testAveMSE(train, c(4:38), c(), train$willBuy, 10, TRUE)
	s2 = testAveMSE(train, c(4:38, 50), c(), train$willBuy, 10, TRUE)
	s3 = testAveMSE(train, c(4:38, 50), c(48), train$willBuy, 10, TRUE)
	s4 = testAveMSE(train, c(4:38, 49), c(), train$willBuy, 10, TRUE)
	best = min(s1, s2, s3, s4)
	if (best == s1) {
		resultCollection=append(resultCollection, 1);
	}
	if (best == s2) {
		resultCollection=append(resultCollection, 2);
	}
	if (best == s3) {
		resultCollection=append(resultCollection, 3);
	}
	if (best == s4) {
		resultCollection=append(resultCollection, 4);
	}
}
print("freq")
table(resultCollection)


#tof	2	2	3	3
#r	4	1	1	4
#fitem	9	0	0	1
#ford	10	0	0	0
#m	8	0	2	0
#freq	2	0	0	8















