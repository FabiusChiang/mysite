##Exercise 1.118 ----------------------------------------------------

cord.x <- c(1.75,seq(1.75,6,0.01),6) 
cord.y <- c(0,dnorm(seq(1.75,6,0.01)),0) 
curve(dnorm(x,0,1),xlim=c(-6,6),main='Exercise 1.118 - Z > 1.75') 
polygon(cord.x,cord.y,col='skyblue')
abline(0,0)
