# This program is written for MSIT 421 to benchmark computer performance. In assignment
# one, it is not required that you write such a program or even follow the logic. All 
# you need to do it run it in R Studio. 
#
# Be patient, this program may take several minutes. 
# 
# The program performs an insertion sort algorithm on three sets of randomized datasets
# and returns the average time. The 3 datasets are random samples of 10,000 numbers, 
# with each sample ranging between 1 and 999,999. 
#
# The insertion sort function is created. Insertion sort is a "slow" algorithm that 
# starts by comparing the second number in the list to the first item. If the 
# second item is lower, it sorts it to the top. The algorithm proceeds sequently 
# through the whole list and compares every next number to the numbers that have
# already been sorted until it finishes with all 10,000 numbers. 
#
insertion_sort <- function (x) {
  n <- length(x)
    for(i in 2:n){
      s <- x[i]
      p <- i-1
      while(all(p > 0 , s < x[p])) {
        x[p+1] <- x[p]
        p <- p-1
      } ## end while
      x[p+1] <- s
    }
  x
}

# the first random sample of 10,000 number is created

a<-sample(1:999999,10000)

# the start time is recorded for this sample. 

start.time1 <- proc.time()

# The insertion sort function is called and the first dataset is passed to it

sorted1 <-insertion_sort(a)

# The start time is subtracted from end time to determine the amount of time 
# the algorithm ran.  

time.taken1 <- proc.time() - start.time1

# The same process as was done for the first dataset is done for the other two 
# random samples of 10,000 numbers. 

b<-sample(1:999999,10000)
start.time2 <- proc.time()
sorted2 <-insertion_sort(b)
time.taken2 <- proc.time() - start.time2

c<-sample(1:999999,10000)
start.time3 <- proc.time()
sorted3 <-insertion_sort(c)
time.taken3 <- proc.time() - start.time3

# The 3 times are averaged. 

time.taken <- c(time.taken1[3], time.taken2[3], time.taken3[3])
time.average <- mean(time.taken)

# The times are displayed.

cat("The times of the 3 runs are: ", time.taken1[3], time.taken2[3], time.taken3[3])
cat("The average running time is: ", time.average, " seconds")
