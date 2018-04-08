# install.packages("car") # only do this once
# library(car)   # do this every R session
# setwd("/Users/ecm/teach/data/")
quality = read.csv("quality.csv")

plot(quality, pch=16)
round(cor(quality), 3)

fit = lm(defect~., quality)
summary(fit)
vif(fit)

attach(quanlity)

summary(lm(defect~temp, quality))
summary(lm(defect~density, quality))
summary(lm(defect~rate, quality))
summary(lm(defect~am, quality))
summary(lm(defect~rate+am, quality))
summary(lm(defect~am, quality))
t.test(defect~am, quality, var.equal=T)


plot(defect~rate, quality)
abline(lm(defect~rate, quality))
