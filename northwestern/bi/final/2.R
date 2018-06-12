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

 2