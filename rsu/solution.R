getYInCurve <- function(x) {
    r1 <- 0.375-x
    r2 <- 0.375-(1-r1)*x
    r3 <- 0.375-(1-r1-r2)*x
    r4 <- 0.375-(1-r1-r2-r3)*x
    y <- r1+r2+r3+r4-1
    y
}

getYInCurve(0.11)

xa <- seq(f=0.05,t=0.20,b=0.0005)

ya <- lapply(xa, getYInCurve)

matrix(c(xa, ya), nc=2)


curve(getYInCurve, 0.05, 0.20,main="Fitting for equation", xlab="x", ylab="Discrepancy") 