data = data.frame(
x=c(0,0,0, 15,15,15, 30,30,30, 45,45,45, 60,60,60, 75,75,75),
y=c(8,6,8, 12,10,14, 25,21,24, 31,33,28, 44,39,42, 48,51,44))

fit = lm(y~x, data)
summary(fit)

predict(fit, data.frame(x=c(50)), interval="confidence");

predict(fit, data.frame(x=c(50)), interval="predict");

plot(fit)

coef(fit)

#################################

