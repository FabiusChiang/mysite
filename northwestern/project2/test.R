#test binomial

library(glmnet)

x1=c(1,20,6,80,10, 8, 9,  7, 6, 4, 8, 13, 11,
1,20,6,80,10, 8, 9,  7, 6, 4, 8, 13, 11,
1,20,6,80,10, 8, 9,  7, 6, 4, 8, 13, 11,
1,20,6,80,10, 8, 9,  7, 6, 4, 8, 13, 11
)

x2=c(100,600,6,700,10, 65,50, 30, 35, 45, 20, 331, 44,
100,600,6,700,10, 65,50, 30, 35, 45, 20, 331, 44,
100,600,6,700,10, 65,50, 30, 35, 45, 20, 331, 44,
100,600,6,700,10, 65,50, 30, 35, 45, 20, 331, 44
)

y=c(0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0,
0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0,
0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0,
0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0)

train=data.frame(x1=x1, x2=x2, y=y)

neededColumns=c(1:2)
avoidColumns=c()
dependVars = as.matrix(train[,setdiff(neededColumns, avoidColumns)]);
model = cv.glmnet(dependVars , train$y, family="binomial", alpha=0, nfolds=5)
yWillBuyOdd=predict(model , dependVars)
yWillBuy=exp(yWillBuyOdd)/(1+exp(yWillBuyOdd))

data.frame(yWillBuy, y)
