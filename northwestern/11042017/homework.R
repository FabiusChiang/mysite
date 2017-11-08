##Exercise 6.137 ----------------------------------------------------

drawShadeInNorm <- function(begin, end, title, sigma) {
    begin <- begin * sigma
    end <- end * sigma
    cord.x <- c(begin,seq(begin,end,0.01),end) 
    cord.y <- c(0,dnorm(seq(begin,end,0.01), 0, sigma),0) 
    curve(dnorm(x,0,sigma),xlim=c(-6 * sigma,6 * sigma),main=title) 
    polygon(cord.x,cord.y,col='skyblue')
    abline(0,0)
}

drawShadeInNorm(6.9/(55/sqrt(104)), 6, "Exercise 6.137 (a)", 55/sqrt(104))


##Exercise 6.141 ----------------------------------------------------
x<-rnorm(15, 20, 5)
x