library(tidyverse)
library(sqldf)
library(glmnet)

#setwd("C://workspace//mysite//northwestern//project2")
setwd("C://Users//fjiang4//share//mysite//northwestern//project2")

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

train = addTransformation(train)

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

splitGene(4, 8, c(2,4,6,8,10,1,3,5,7,9))

splitGene = function(start, end, gene) {
    pickedGene = c();
    for(i in start : end ){
        pickedGene = append(pickedGene, gene[i])
    }
	return(pickedGene)
}

calculateLiveScore = function (gene) {
    binomialGene = splitGene(1, 48, gene)
    probabilityGene = splitGene(1+48, 48+8, gene)
    amountGene = splitGene(48+8+1, 48+8+48, gene)
    return(getScorePerPrediction(binomialGene, probabilityGene, amountGene, train))
}

getScorePerPrediction = function(binomialGene, proBabilityGene, amountGene, dataDS) {
    allScores = c();
    for(i in 1:3) {
        allScores = append(allScores, getSingleScorePerPrediction(binomialGene, proBabilityGene, amountGene, dataDS))
    }
    return(mean(allScores))
}

getSingleScorePerPrediction = function(binomialGene, proBabilityGene, amountGene, dataDS) {
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
    geneLength = length(gene)
    mutationRatio = 4/geneLength
    randomRatios = runif(geneLength)
    for(i in 1:geneLength) {
        if (randomRatios[i] < mutationRatio) {
            gene[i] = reverseSingleGene(gene[i])
        }
    }
    return (gene)
}

reverseSingleGene = function(g) {
    if (g == 1) {
        return(0)
    }
    else {
        return(1)
    }
}

removeDuplicatedIndividuals = function(genes) {
    geneLength = length(genes)
    distinctIndividuals = list()
    for(i in 1: geneLength) {
        noDuplicated = TRUE
        if (i != geneLength) {
            for(j in (i+1): geneLength) {
                if (isSameIndividuals(genes[[i]], genes[[j]])) {
                    noDuplicated = FALSE
                    break
                }
            }
        }
        if (noDuplicated) {
            distinctIndividuals = append(distinctIndividuals, list(genes[[i]]))
        }
    }
    return (distinctIndividuals)
}

isSameIndividuals = function(geneA, geneB) {
    for(i in 1:length(geneA)) {
        if (geneA[i] != geneB[i]) {
            return(FALSE)
        }
    }
    return(TRUE)
}

initializePopulation = function (geneLength, individualCount) {
    population = list()
    for(i in 1:individualCount) {
        population[[i]] = as.integer(runif(geneLength,0,3))
    }
    return(population)
}

pickCouples = function(scores, couplesCount) {
    result = list();
    standardScores = standardizeScores(scores)
    for(i in 1: couplesCount) {
        couple = pickACoupleWithScoreAsDensity(standardScores)
        result[[i]] = couple
    }
    return(result)
}

standardizeScores = function(scores) {
    scoresLength = length(scores)
    total = sum(scores)
    result = rep(NA, scoresLength)
    for(i in 1:scoresLength) {
        result[i] = scores[i]/total
    }
    return(result)
}

pickACoupleWithScoreAsDensity = function(standardScores) {
    mom = 0;
    dad = 0;
    repeat{
        rdecimals = runif(2);
        mom = pickIndividualWithScoreAsDensity(standardScores, rdecimals[1])
        dad = pickIndividualWithScoreAsDensity(standardScores, rdecimals[2])
        if (mom != dad){
            break;
        }
    }
    return(c(mom, dad))
}

pickIndividualWithScoreAsDensity = function(standardScores, rdecimal) {
    cumulative = 0;
    for(i in 1:length(standardScores)) {
        cumulative = cumulative + standardScores[i];
        if (cumulative > rdecimal){
            return(i);
        }
    }
}

population = list()
populationScores = c()

main = function(){
    population = initializePopulation(104, 3);

    for(i in 1: length(population)) {
        populationScores = append(populationScores, calculateLiveScore(population[[i]]))
    }
print(populationScores)

    for(i in 1: 5) {
        evolve()
    }
}

evolve = function() {
    initialCount = length(population)
    parents = pickCouples(populationScores, as.integer(initialCount/2))

    allChildren = list()
    for(i in 1: length(parents)) {
        parent = parents[[i]]
        children = reproduceChildren(population[[parent[1]]], population[[parent[2]]])
        allChildren = append(allChildren, children)
    }

    newPopulation = removeDuplicatedIndividuals(append(population, allChildren))
print(newPopulation)
    newScores = rep(NA, length(newPopulation));
    for(i in 1: length(newPopulation)) {
        newScores[i] = calculateLiveScore(newPopulation[[i]])
    }
    sortedAllScores = sort(newScores)
    aliveBenchmark = sortedAllScores[initialCount]
    topScore = sortedAllScores[1]


    nextGeneration = list()
    nextGenerationScore = c()
    for(i in 1: length(newScores)) {
        if (newScores[i] <= aliveBenchmark && length(nextGeneration) <= initialCount) {
            nextGeneration = append(nextGeneration, list(newPopulation[[i]]))
            nextGenerationScore = append(nextGenerationScore, newScores[i])
            if (newScores[i] == topScore) {
                cat("Top score", topScore, ":", newPopulation[[i]], "\r\n")
            }
        }
    }
    population = nextGeneration
    populationScores = nextGenerationScore
}

main()
