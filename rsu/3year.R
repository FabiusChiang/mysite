getYInCurve <- function(x) {
    r1 <- 0.375-x
    r2 <- 0.375-(1-r1)*x
    r3 <- 0.375-(1-r1-r2)*x
    y <- r1+r2+r3-1
    y
}

xa <- seq(f=0.03,t=0.20,b=0.005)

ya <- lapply(xa, getYInCurve)

matrix(c(xa, ya), nc=2)
  

# curve(getYInCurve, 0.03, 0.20,main="Fitting for equation", xlab="x", ylab="Discrepancy") 
