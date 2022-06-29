#******************************** DATA COLLECTION *******************************#
# create directory if no exist
if(!file.exists("data")){
  dir.create("data")
}
setwd("./data")
getwd()
#-------------------------------------------------------------------

# download CSV file in R-studio
getwd()
setwd("./data")
getwd()
fileurl <-"https://people.sc.fsu.edu/~jburkardt/data/csv/biostats.csv"
download.file(fileurl,destfile = "biotecs.csv",method = "curl")
list.files("./data")
getwd()
download_date <- date()
download_date
#---------------------------------------------------------------------

# read data from CSV file 

biotecs=read.table(file = "./biotecs.csv",sep = ",",header = TRUE)
head(biotecs)  #head function shows first 5 items of table


# read file using read.csv
new_biotecs=read.csv("./biotecs.csv")
head(new_biotecs)
#---------------------------------------------------------------------
#read data from excel file(not working)
package.install("xlsx")
library('xlsx')
excel_file=read.xlsx(file = "./biotecs.csv",sep = ",",header = TRUE)
# error occurs in this package installation
#---------------------------------------------------------------------
# using library "readxl"
library("readxl")
xlsx_example <- readxl_example('geometry.xls')
dris <- read_excel(xlsx_example)
setwd('./data')
my_cam <- read_excel('./biotecs1.xlsx')
head(my_cam)
#----------------------------------------------------------------------
# write data in xls format (not working)
devtools::install_github("ropensci/writexl")
library(writexl)
write_xlsx(df,'file_formated.xlsx')
#----------------------------------------------------------------------
# web scrapping
# read data from the web page
library(rvest)
myurl <- "https://en.wikipedia.org/wiki/Brazil_national_football_team"
file <- read_html(myurl)
tables <- html_nodes(file , 'table')
table1 <- html_table(tables[34],fill = TRUE)
print(table1)
#----------------------------------------------------------------------
# sqlite database 
# import rsqlite library
library(RSQLite)
# import mtcars as R data
data("mtcars")
mtcars$car_names <- rownames(mtcars)
rownames(mtcars) <-c()
head(mtcars)
# just check the file storage directory
getwd()
setwd("./data")

# connect to the database
conn = dbConnect(RSQLite::SQLite() , "carDB_db")
# write mtcars into database carDB_db as table cars_data
dbWriteTable(conn,"car_data",mtcars)
#now check database
dbListTables(conn)
dbListFields(conn,"car_data")
dbReadTable(conn,"car_data")
dbDisconnect(conn)

#------------------AirPassengers-------------------------------

library(RSQLite)
data("Loblolly")
Loblolly$figures <- rownames(Loblolly)
rownames(Loblolly) <-c()
head(Loblolly)  

# connect and create a new database
con1<-dbConnect(RSQLite::SQLite(),"my_database")
# add new tables in database
dbWriteTable(con1,"lo_data",mtcars)
dbWriteTable(con1,"air_data",airquality)
dbListTables(con1)
dbReadTable(con1,"air_data")
dbReadTable(con1,"lo_data")
#-------------------perform selection query--------------------

dbGetQuery(con1,"SELECT* FROM air_data LIMIT 5")
dbGetQuery(con1,"SELECT car_names,mpg FROM lo_data WHERE gear=4")
#-------------------using params------------------------------
s<- 3
m<- 15
dbGetQuery(con1,"SELECT car_names,mpg,drat FROM lo_data 
                  WHERE drat>=? AND mpg >= ? AND car_names LIKE 'M%' ", params =c(s,m))
#-----------------------Delete & INsert -----------------------

dbExecute(con1,"DELETE FROM lo_data WHERE car_names= 'Mazda RX4'")
dbGetQuery(con1,"SELECT* FROM lo_data LIMIT 5")
dbExecute(con1,"INSERT INTO lo_data VALUES(21.0, 6, 160.0, 110, 3.90, 2.620, 16.46,  0,  1, 4 ,4,'Mazda RX4')")
dbGetQuery(con1,"SELECT* FROM lo_data LIMIT 5")
dbReadTable(con1,"lo_data")

res<- dbSendQuery(con1,"SELECT car_names FROM lo_data LIMIT 5")
dbFetch(res)
dbDisconnect(con1)
#---------------------------------------------------------------

#***************************DATA WRANGLING**************************#
#--------- Data.table module -----------------------------------
library(data.table)
DF = data.frame(x=rnorm(9) , y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,10)
DT = data.table(x=rnorm(9) , y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,6)
#you can use data table directly to add rows and coloumns
DT[,w:=z^2]
head(DT,5)
DT[,a:=x>0]
head(DT,5)

#using above Data collection of mtcars
# sort using data.table buit-in function
data.table::fsort(mtcars$carb)

#------------------------------------------------------------------
# subseting 
X <- mtcars
X <- X[(X$cyl>4 & X$carb < 4),]
print(X)
#Sorting
X <- sort(X$cyl,decreasing = FALSE,na.last = TRUE)
# use order if you sort in a table
X <- X[order(X$cyl),]

#------------------------------------------------------------------

# removal of missing values
# test missing value

y <- c(1:4,NA,6:8,NA)
is.na(y)
tab <- data.frame('v1'=1:3,'v2'=c(NA,NA,5),'V3'=c(1,2,NA))
print(tab)
is.na(tab)
# check address in which na value exist
which(is.na(tab))  
# sumall na values
sum(is.na(tab))  
# check na values exist in a coloumn
colSums(is.na(tab))

# impute na 
df<- data.frame("v1"=c(1:3,99),"v2"=c(99,4,5,6),"v3"=1:4)
print(df)
df[df==99]<- NA
print(df)
df[is.na(df)]<- "-"
print(df)

#exclude missing values

complete.cases(df)
df[complete.cases(df),]
df[!complete.cases(df),]
na.omit(df)
#exercise

data<- datasets::airquality
sum(is.na(data))
colSums(is.na(data))
print(data)
data[is.na(data$Ozone)] <- mean(head(data$Ozone),na.rm = TRUE)
data[is.na(data$Solar.R)]=mean(head(data$Solar.R),na.rm = TRUE)
data<-round(data,1)
colSums(data)
colSums(is.na(data))
omdata<-na.omit(data)
print(omdata)
colSums(omdata)


#-----------------------------------------------------------------
#split & Apply 
spin=split(InsectSprays$count,InsectSprays$spray)
soo=sapply(spin,sum)
soo
#-----------------------------------------------------------------
# merge & join dataframes
tab1=data.frame('names'=c("hi","ti","ni","si","ki"),'age'=1:5)
tab2=data.frame('height'=c(5,6,5,4,6))
#for col bind
bind=cbind(tab1,tab2)
print(bind)
#for row bind 
rbind(bind,bind)

df1=data.frame(letters,affon=1:26)
df2=data.frame(LETTERS,affon=c(1:10,15:20,25:30,35:38))
merge(df1,df2)
merge(df1,df2,by.x = "letters",by.y ="affon" )

#----------------------------------------------------------------
library(dplyr)
getwd()
setwd("./rstudio")
setwd("./MY-R")
setwd("./data")
sleep=read.table(file = "./msleep.csv",sep = ",",header = TRUE)
head(sleep)
sleeptime<- select(sleep,?..name,genus,sleep_total)
sleeptime
sleeporder <- filter(sleep,order=='Carnivora')
sleeporder
# multiply two coloumns and make new one sleep_awake
sleepmutate <- mutate(sleep,sleep_awake=sleep_total* awake)
sleepmutate

# pipeline 

library(datasets)
cars <- mtcars %>% select(car_names,mpg,cyl) %>% filter(cyl==6) %>% mutate(mpg_cyl=mpg*cyl)
cars

#mutate using ifelse
name <- c("harry",'terry','merry',"carry","werry","uerry")
section <-c("green","blue","red","purple","yellow","pink")
numbers <- c(56,78,98,44,66,84)
gradebook <- data.frame(name,section,numbers)
print(gradebook)
result<- mutate(gradebook,class_result=ifelse(numbers>50,"pass","fail"))
result1<- mutate(result,grade=ifelse(numbers %in% 50:60,"D",
                                       ifelse(numbers %in% 60:70,"C",
                                       ifelse(numbers %in% 70:80,"B",
                                        ifelse(numbers %in% 80:90,"A",
                                               ifelse(numbers %in% 90:100,"A+",
                                       "F"))))))
                                        
result1




#------------------------------------------------------------------------------------------
#world cloud example
library(tm)
library(wordcloud)
wordcloud(txt_data)
dt=read.csv(file = "./msleep.csv",sep = ",",header = TRUE)
#wd<-head(dt$?..name,10)
wordcloud(wd,scale = c(5,0,5),random.order = FALSE,
          rot.per = 0.35,use.r.layout = FALSE,colors=(10))

#------------------------------------------------------------------------------------------