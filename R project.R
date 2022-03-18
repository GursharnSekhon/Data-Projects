library(readr)



  ###setting working directory 

getwd()
setwd("C:/Users/gursh/Desktop/R Studio")
getwd()


car<- read.csv("cardata.csv")  ### read data from working directory (csv)

write.csv(car, file = "CarDF", row.names = FALSE) 

car

read.csv("cardata.csv")
View("cardata.csv")
head(car)
tail(car)
str(car)

Veiw(car)


  ### change chr variables into factor where applicable

class(car1)
levels(car1)


levels(car1$Car.brand)

car1 <- read.csv("cardata.csv", stringsAsFactors = TRUE)
str(car1)  ### Car model and brand changed to factors

  ### Changing Column names and tidying data




colnames(car1) <- c("X","Make","Model", "Year", "Sold In Thousands", "Max Speed km/h","%of Sales Among Brand", "Sales in 2018 x 1000", "Price")
car1

cardroppedcol <- car1[-c(1,7)]  ### Dropping columns that I don't need for my  analysis purposes.
cardroppedcol


  ### Vectors, Subsetting Data & Matricies

carsubset <-    car1[1:10,]  ##1:10 specifies the rows I have selected and the "," means I want to pull all the variables (columns)

carsubset

v1 <- c("Toyota", "Corolla", 1966,  43000, 220, 1200, 12000)   #### Turned into chr variable because character variable is most flexible... now we know this will be the same for the rest
str(v1)

v2 <- c("Ford", "F-Series", 1977, 40000, 210, 400, 27000)
v3 <- c("Volkswagen", "Golf", 1974, 30000, 240, 2500, 18000)
v4 <- c("Volkswagen", "Beetle", 1938, 23000, 254, 259,15000)
v5 <- c("Vaz",2101, 1970, 19000,180, 10, 12000)
v6 <- c("Honda","Civic",1972,18000,270,400,17000)
v7 <- c("Ford","Escort",1968,17800,200,200,18000)
v8 <- c("Honda","Accord",1976,17000,280,100,14000)
v9 <- c("Ford","Model T",1908,15600,80,0,0)
v10 <- c("Volkswagen","Passat",1973,15400,260,1000,17000)

carmatrix <-   rbind(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
carmatrix

rownames(carmatrix) <- c(1:10)


colnames(carmatrix) <- c("Make", "Model", "Year", "Sold In Thousands", "Max Speed km/h", "Sales in 2018 x 1000", "Price")
carmatrix

attributes(carmatrix)
str(carmatrix)


is.data.frame(car)

is.matrix(carmatrix)


  ### Creating Dataframes 

SleepQuality <- factor(c("Good", "Excellent","Excellent", "Good", "Good",  "Good", "Good", "Poor", "Poor", "Poor"), 
                       levels = c("Poor", "Good", "Excellent"))

levels(SleepQuality)


df1 <- data.frame( Age = 41:50,
                   (SleepQuality),
                   stringsAsFactors = TRUE)

str(df1)


df1

levels(df1$X.SleepQuality.)

SleepHours <- c(8L,8L,7L, 7L, 6L, 5L, 6L, 5L, 4L, 4L)

df2 <- cbind(df1, SleepHours)
df2


















