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

attempLimit = 500
oobRecordsBag = rep(NA, attempLimit)
oobRecordsRF = rep(NA, attempLimit)

start_time <- Sys.time()
for(i in 1:500){
	model = randomForest(factor(y)~., data=bc[,-1], mtry=9)
	oob = getOOBOfRFModel(model)
	collectTheBestOOB(model, oob, 500)
	oobRecordsBag[i] = oob 
	#cat(i, oob, "\r\n")
}
end_time <- Sys.time()
end_time - start_time
bestModel

start_time <- Sys.time()
for(i in 1:500){
	model = randomForest(factor(y)~., data=bc[,-1])
	oob = getOOBOfRFModel(model)
	collectTheBestOOB(model, oob, 500)
	oobRecordsRF[i] = oob 
	#cat(i, oob, "\r\n")
}
end_time <- Sys.time()
end_time - start_time
bestModel

summary(oobRecordsBag)
summary(oobRecordsRF)

