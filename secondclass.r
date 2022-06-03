# subsetting
x <- matrix(1:6,2,3)
x
x[,1 , drop=FALSE]
y <- c("a","b","c","d","a")
y[y>"a"]
y<- y>"a"
y
#subsitting lists
a<-list(weekday = 1:6,prob= 0.6,item = "umbrella")
a["weekday"]
a[["weekday"]]
a[c(1,3)]
a$prob
#removing NA values
s <- c(1,2,NA,4,NA,NA,8)
st <- is.na(s)
s[!st]
#airulaity example
View(airquality)
air <- airquality
air[1:10 , ]
good <- complete.cases(air)
air[good,][1:10,]
#for loop
m <- matrix(1:25,5,5)
for (i in seq_len(nrow(m))) {
  for(j in seq_len(ncol(m))){
   
      print(m[i,j])
  }
  print("****")
  
}
#functions
my_data=data.frame(x=rnorm(100),y=rnorm(100))
my_data

f <- function(a,b=0)
{
  print(a)
  print(b)
}
f(65)

#vectorized operations
x <- matrix(1:4,2,2) ; y <-matrix(rep(10,4),2,2)
x + y
x * y
x / y
x %*% y # for matrix real matrix multiplication



# date & time
d <- Sys.time()
d
p <- as.POSIXlt(d)
names(unclass(p))
p$sec
p$mday
p$mon
p$wday
p$zone

# for time difference

x <- Sys.time()
x1 <- as.POSIXlt(x)
y <- Sys.time()
y1 <- as.POSIXlt(y)
x1-y1

# for lapply
x <- list(a=1:4,b=rnorm(100),c=1:10)
lapply(x,mean)
lapply(x, sd)
# for sapply
x <- list(a=1:4,b=rnorm(100),c=1:10)
sapply(x,mean)
sapply(x, sd)
# for apply function
m <- matrix(rnorm(100),20,10)
m
apply(m,2, sum)
apply(m,1, sum)

#for split data

v <-c(rnorm(100),runif(100),rnorm(100))
f <- gl(3,10)
s <- split(v,f)
s
sapply(s, sum)

# for airquality example

s <- split(airquality,airquality$Month)
s
sapply(s, function(x) sum(x[c("Ozone","Solar.R","Wind")],na.rm = TRUE))








