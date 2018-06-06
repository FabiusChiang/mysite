library(tidyverse)
library(sqldf)
library(glmnet)

setwd("C://workspace//mysite//northwestern//project2")

ord=read.csv("orders.csv")
ord$t = as.numeric(as.Date("2014/11/25") - as.Date(ord$orddate, "%d%b%Y"))/365.25

customer=read.csv("customer.csv")
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

allData = left_join(customer, rfm, by="id") %>%
  left_join(rfm2, by="id")

train=sqldf("SELECT a.*, c.logtarg as logtarg FROM allData a JOIN customer c ON (a.id = c.id AND c.train = 1)")

addTransformation = function(targetDS) {
    targetDS$tof2=targetDS$tof^2
    targetDS$logtof=log(targetDS$tof+1)
    targetDS$fitem2=targetDS$fitem^2
    targetDS$logfitem=log(targetDS$fitem+1)
    targetDS$ford2=targetDS$ford^2
    targetDS$logford=log(targetDS$ford+1)
    targetDS$m2=targetDS$m^2
    targetDS$logm=log(targetDS$m+1)
    targetDS$freq=targetDS$ford/targetDS$tof
    targetDS$freq2=targetDS$freq^2
    targetDS$logfreq=log(targetDS$freq)
    targetDS$r2=targetDS$r^2
    targetDS$logr=log(targetDS$r)
    targetDS$willBuy=(targetDS$logtarg>0)
    colnames(targetDS)

    return(targetDS[,-c(1, 2, 39)])
}

newt = addTransformation(train)

colnames(newt)

translateGeneToFields = function(geneArray, dataDS) {
    initColumn=1
    pickedFields = c();
    for(i in 1:length(geneArray)) {
        if (geneArray[i] == 1) {
            pickedFields = append(pickedFields, initColumn+i)
        }
    }
    return(as.matrix(dataDS[, pickedFields]));
}

translateGeneToBenchmarkProbability = function(geneArray) {
    octVal = 0;
    for(i in length(geneArray): 1) {
        octVal = octVal + 2^(i-1) * geneArray[i];
    }
    return (0.028+octVal*0.001)
}

splitGene = function(start, end, gene) {
    pickedGene = c();
    for(i in start : end ){
        pickedGene = append(pickedGene, gene[i])
    }
}

calculateLiveScore = function (gene) {
    binomialGene = splitGene(1, 48, gene)
    probabilityGene = splitGene(1+48, 48+8, gene)
    amountGene = splitGene(48+8+1, 48+8+48, gene)
    getScorePerPrediction(binomialGene, probabilityGene, amountGene, train)
}

getScorePerPrediction = function(binomialGene, proBabilityGene, amountGene, dataDS) {
    binomialY = dataDS$willBuy
    binomialXs = translateGeneToFields(binomialGene, dataDS)
    modelB = cv.glmnet(binomialXs , binomialY, family="binomial", alpha=0, nfolds=5)
    yHatB = predict(modelB , binomialXs)

    benchmarkProbability = translateGeneToBenchmarkProbability(proBabilityGene)

    activeBuyers = sqldf("SELECT * FROM dataDS WHERE logtarg > 0")
    amountY = activeBuyers$logtarg
    amountXs = translateGeneToFields(amountGene, activeBuyers)
    modelA = cv.glmnet(amountXs , amountY, alpha=0, nfolds=5)
    
    amountXsForPredict = translateGeneToFields(amountGene, dataDS)
    yHatA = predict(modelA , amountXsForPredict)
    finalResult = yHatA * (yHatB > benchmarkProbability)
    mse = mean((finalResult - dataDS$logtarg)^2)
    return(mse)
}

reproduceChildren = function(momGene, dadGene) {
    totalGeneLength = length(momGene)
    exchangeStartPos = round(runif(1, 1, length(momGene)))
    exchangeGeneLength = round(runif(1, 1, length(momGene) - 1))
    childA = rep(momGene)
    childB = rep(dadGene)
    for(i in 0:(exchangeGeneLength-1) ) {
        toExchangePos = exchangeStartPos + i
        if (toExchangePos > totalGeneLength) {
            toExchangePos = toExchangePos - totalGeneLength
        }
        temp = childA[toExchangePos];
        childA[toExchangePos] = childB[toExchangePos];
        childB[toExchangePos] = temp;
    }
    childA = mutationGene(childA)
    childB = mutationGene(childB)
    return(list(childA, childB))
}

mutationGene = function(gene) {
    mutationRatio = 4/length(gene)
    return (gene)
}

removeDuplicatedIndividuals = function(genes) {

}