m <- matrix(nrow = 3 , ncol = 3)
m
n<-matrix(1:6,nrow = 2,ncol = 3)
n
dim(n)
dim(n)<-c(3,2)
n
attributes(n)
a <- matrix(1:3,nrow = 3,ncol = 3)
a
v<-c(1,2,NaN,3,4,5)
is.na(v)
is.nan(v)
name <- data.frame(no_day = 1:7 , days=c("monday","tuesday","wednesday","thrusday","friday","saturday","sunady"))
name
names(name)
u <- matrix(1:9,nrow = 3,ncol = 3)
u
dimnames(u)
dimnames(u)<- list(c("r1","r2","r3"),c("c1","c2","c3"))
u
