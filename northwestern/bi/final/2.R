library(randomForest)


setwd("C://workspace//mysite//northwestern//bi//final")


bc=read.csv("breastcancer.csv")

head(bc)

getModelPerRandomForest = function(ntree) {
	return(randomForest(factor(y)~., data=bc[,-1], ntree=ntree))
}

getOOBOfRFModel = function(randomForestModel) {
    oob = (randomForestModel$confusion[1,2] +randomForestModel$confusion[2,1])/
        (randomForestModel$confusion[1,1]+randomForestModel$confusion[1,2]
        +randomForestModel$confusion[2,1]+randomForestModel$confusion[2,2])
    return(oob)
}

bestOOB = 100
bestModel = 0
bestNTree = 0

collectTheBestOOB = function(model, oob, ntree) {
    if(oob < bestOOB) {
        bestOOB <<- oob
        bestModel <<- model
	  bestNTree <<- ntree
    }
}

attempLimit = 10000
oobRecords = rep(NA, attempLimit)

for(i in 1:attempLimit){
    forOOBMean = rep(NA, 10)
    for(j in 1:10) {
        model = getModelPerRandomForest(i)
        forOOBMean[j] = getOOBOfRFModel(model)
		collectTheBestOOB(model, forOOBMean[j], i)
    }
    moob = mean(forOOBMean)
    oobRecords[i] = moob
    cat(i, moob, "\r\n")
}

varImpPlot(bestModel)
partialPlot(bestModel, bc, "x3")


install.packages("pROC")
library(pROC)
plot.roc(bc$y, bestModel$votes[,2], print.auc=T)

head(bc)
lnm=glm(y~x1+x2+x3+x4+x5+x6+x7+x8+x9, bc, family=binomial)
summary(lnm)

library(glmnet)
xs = as.matrix(bc[, -1])
fit.ridge=glmnet(xs, bc$y, family="binomial", alpha=0)
fit.cv=cv.glmnet(xs, bc$y, family="binomial", alpha=0)
fit.cv$lambda.min
phat = predict(fit.ridge, s=fit.cv$lambda.min, newx=xs, type="resp")
auc(bc$y, phat)

fit.lasso=glmnet(xs, bc$y, family="binomial", alpha=1)
fit.lassocv=cv.glmnet(xs, bc$y, family="binomial", alpha=0)
fit.cv$lambda.min
phat = predict(fit.ridge, s=fit.cv$lambda.min, newx=xs, type="resp")
auc(bc$y, phat)


