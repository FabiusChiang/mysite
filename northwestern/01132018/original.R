# This program is for use in MSIT 421 and performs two sorting algorithms on different 
# sized data sets and compares their performance.

# The sample sizes are defined. These are the number of items being sorted.

samples1 <-20
samples2 <-300
samples3 <- 500
samples4 <- 700
samples5 <- 900

# We define the number of trials for running the algorithms on the different sized
# datasets. 

number.of.trials <- 50

# We define matrices for each sample size that contain the numbers to be sorted for 
# each trial. 

sample1 <-matrix(nrow=number.of.trials, ncol=samples1)
sample2 <-matrix(nrow=number.of.trials, ncol=samples2)
sample3 <-matrix(nrow=number.of.trials, ncol=samples3)
sample4 <-matrix(nrow=number.of.trials, ncol=samples4)
sample5 <-matrix(nrow=number.of.trials, ncol=samples5)

# We populate the matrices defined above by random numbers between 1 and 999,999 
# for each sample size and for the required number of trials. 

for (i in seq(1, number.of.trials, 1))   {
sample1[i, ]<- rbind(sample(1:999999,samples1))
}

for (i in seq(1, number.of.trials, 1))   {
  sample2[i, ]<- rbind(sample(1:999999,samples2))
}

for (i in seq(1, number.of.trials, 1))   {
  sample3[i, ]<- rbind(sample(1:999999, samples3))
}

for (i in seq(1, number.of.trials, 1))   {
  sample4[i, ]<- rbind(sample(1:999999, samples4))
}

for (i in seq(1, number.of.trials, 1))   {
  sample5[i, ]<- rbind(sample(1:999999, samples5))
}

# The insertion sort function is defined. 

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

# The quick sort function is defined. 

quick_sort <- function(x) {
  #stop if vector has length 1
  if (length(x)<=1) {
    return(x)
  }
  #pick an element from the vector
  element <- x[1]
  partition <- x[-1]
  #reorder vector so that integers less than element
  # come before, all all integers greater come after.
  v1 <- partition[partition < element]
  v2 <- partition[partition>= element]
  # Recursively apply steps to smaller vectors.
  v1 <-quick_sort(v1)
  v2 <- quick_sort(v2)
  return(c(v1, element, v2))
}

# A matrix of start times is defined with 5 rows (the number of sample sizes) and the
# number of trials for each sample size as the column. 

# istart.times <- matrix( nrow= 5, ncol=number.of.trials)
# iend.times <- matrix( nrow= 5, ncol=number.of.trials)
# irun.times <- matrix( nrow= 5, ncol=number.of.trials)

# # The insertion sort function is called and run on the 50 sets of numbers for 
# # each sample size. The times are recorded. 

# for (i in seq(1, number.of.trials, 1))   {
#   istart.times[1, i] <-Sys.time()
#   insertsorted1 <-rbind(insertion_sort(sample1[i, ]))
#   irun.times[1, i] <- Sys.time() - istart.times[1, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   istart.times[2, i] <-Sys.time()
#   insertsorted2 <-rbind(insertion_sort(sample2[i, ]))
#   irun.times[2, i] <- Sys.time() - istart.times[2, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   istart.times[3, i] <-Sys.time()
#   insertsorted3 <-rbind(insertion_sort(sample3[i, ]))
#   irun.times[3, i] <- Sys.time() - istart.times[3, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   istart.times[4, i] <-Sys.time()
#   insertsorted4 <-rbind(insertion_sort(sample4[i, ]))
#   irun.times[4, i] <- Sys.time() - istart.times[4, i]
# }
# for (i in seq(1, number.of.trials, 1))   {
#   istart.times[5, i] <-Sys.time()
#   insertsorted5 <-rbind(insertion_sort(sample5[i, ]))
#   irun.times[5, i] <- Sys.time() - istart.times[5, i]
# }

# # The quick sort function is called and run on the 50 sets of numbers for 
# # each sample size. The times are recorded. 

# qstart.times <- matrix( nrow= 5, ncol=number.of.trials)
# qend.times <- matrix( nrow= 5, ncol=number.of.trials)
# qrun.times <- matrix( nrow= 5, ncol=number.of.trials)

# for (i in seq(1, number.of.trials, 1))   {
#   qstart.times[1, i] <-Sys.time()
#   quicksorted1 <-rbind(quick_sort(sample1[i, ]))
#   qrun.times[1, i] <- Sys.time() - qstart.times[1, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   qstart.times[2, i] <-Sys.time()
#   quicksorted2 <-rbind(quick_sort(sample2[i, ]))
#   qrun.times[2, i] <- Sys.time() - qstart.times[2, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   qstart.times[3, i] <-Sys.time()
#   quicksorted3 <-rbind(quick_sort(sample3[i, ]))
#   qrun.times[3, i] <- Sys.time() - qstart.times[3, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   qstart.times[4, i] <-Sys.time()
#   quicksorted4 <-rbind(quick_sort(sample4[i, ]))
#   qrun.times[4, i] <- Sys.time() - qstart.times[4, i]
# }

# for (i in seq(1, number.of.trials, 1))   {
#   qstart.times[5, i] <-Sys.time()
#   quicksorted5 <-rbind(quick_sort(sample5[i, ]))
#   qrun.times[5, i] <- Sys.time() - qstart.times[5, i]
# }

# # An average of insertion sort times and quick sort times are taken over the 50 trials 
# # for each set of numbers. 

# iRowM <- rowMeans(irun.times)
# qRowM <- rowMeans(qrun.times)

# # The performance of each sort is plotted. 

# plot(iRowM, type="l", xaxt="n", ylim=c(0, iRowM[5]), ylab="Run Time", xlab='Numbers sorted')
# title(main="Insertion Sort Performance")
# axis(1, at=1:5, labels=c(samples1, samples2, samples3, samples4, samples5))

# #plot(qRowM, type="l", xaxt="n", ylim=c(0, qRowM[5]), ylab="Run Time", xlab='Numbers sorted')
# #title(main="QuickSort Performance")
# #axis(1, at=1:5, labels=c(samples1, samples2, samples3, samples4, samples5))



