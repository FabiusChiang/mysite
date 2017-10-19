##Exercise 4.59 ----------------------------------------------------

density0To2 <- function(x) {
    p <- 0.5
    if (x <0 || x >2) {
        p<- 0
    }
    p
}

drawShadeInEquallyLikely <- function(begin, end, title) {
    seqX <- seq(begin,end,0.001)
    cord.x <- c(begin,seqX,end) 
    seqY <- rep(0.5, length(seqX))
    cord.y <- c(0,seqY,0) 
    P<-Vectorize(density0To2)
    curve(P,xlim=c(-2,4),main=title,n=10000) 
    polygon(cord.x,cord.y,col='skyblue')
    abline(0,0)
}

## (a)
drawShadeInEquallyLikely(0, 0, "Exercise 4.59 (a) Density curve 0~2")


## (b)
drawShadeInEquallyLikely(0, 1.6, "Exercise 4.59 (b) Density curve 0~2 and shade for 0-1.6")


## (c)
drawShadeInEquallyLikely(0.5, 1.7, "Exercise 4.59 (a) Density curve 0~2 and shade for 0.5-1.7")


## (d)
drawShadeInEquallyLikely(0.95, 2, "Exercise 4.59 (d) Density curve 0~2 and shade for 0.95-2")

##Exercise 4.62 ----------------------------------------------------
## (a) 
## The P(0.52 ≤ ṗ ≤ 0.60) is
pnorm(0.60, 0.56, 0.019) - pnorm(0.52, 0.56, 0.019)
pnorm((0.60-0.56)/0.019, 0, 1) - pnorm((0.52-0.56)/0.019, 0, 1)

## P(ṗ ≥ 0.72) is 
pnorm(0.72, 0.56, 0.019, lower.tail=F)
pnorm(0.4, 0.56, 0.019)