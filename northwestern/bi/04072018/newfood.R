library(car)

newfood = data.frame(
sales=c(225,323,424,268,224,331,254,492,167,226,210,289,204,288,245,161,161,
246,128,154,163,151,180,150),
price=c(24,24,24,24,24,24,24,24,29,29,29,29,29,29,29,29,34,34,34,34,34,34,34,34),
ad=c(0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1),
loc=c(0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1),
income=c(7.3,8.3,6.9,6.5,7.3,8.3,6.9,6.5,6.5,8.4,6.5,6.2,6.5,8.4,6.5,6.2,
7.2,8.1,6.6,6.1,7.2,8.1,6.6,6.1),
volume=c(34,41,32,28,34,41,23,37,33,39,30,27,37,43,30,19,32,42,29,24,32,36,29,24),
city=c(3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2))


# newfood
# newfood[1:4,1:6]

attach(newfood)

fit = lm(sales ~ ad)
summary(fit)
# abline(fit)
plot(fit)


deviance(lm(sales~1, newfood))
deviance(lm(sales~ad, newfood))
deviance(lm(sales~ad+volume, newfood))
deviance(lm(sales~volume, newfood))
deviance(lm(sales~price+ad+loc+volume+income, newfood))

fit2 = lm(sales ~ volume+price+ad+loc+income)
anova(fit2)
fit22 = lm(sales ~ price+ad+loc+volume+income)
anova(fit22)

drop1(fit2)
summary(fit2)
vif(fit2)

fit3 = lm(price ~ ad+loc+volume+income)
summary(fit3)

coef(fit3)

cor(newfood)

cor(data.frame(income = newfood$income, volume = newfood$volume ))