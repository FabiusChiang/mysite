iris[,1:4]

princomp(iris[,1:4], cor=TRUE)
summary(princomp(iris[,1:4], cor=TRUE), loadings=TRUE)

prcomp(iris[,1:4])
summary(prcomp(iris[,1:4]))

library(psych)
principal(iris[,1:4], nfactor=2, rotate="none")


table(iris$Species)

table(kmeans(iris[,1:4], 3)$cluster)