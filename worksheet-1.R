## The Editor

vals <- seq(1,100)

vals <- seq(from = 1,
            to=100)

## Vectors

counts <-c(3,4,7,5,2)
list<-list(1,2,3)
  ## Exercise 2
typeof(counts)
typeof(c(counts, list))


## Factors

education <- factor(
  c("college", "highschool", "college", "middle", "middle"),
  levels = c("middle", "highschool", "college"))

## Data Frames
df<- data.frame(education, counts)

## Exercise 3
data<- data.frame(species=c("a","b","c","d"),abund=c(3,4,5,6))
...

## Names

names(df) <- c('ed','ct')

## Subsetting ranges

days <- c(
  "Sunday", "Monday", "Tuesday", "Wednesday",
  "Thursday", "Friday", "Saturday")
weekdays <- days[2:6]
weekdays
weekend <- days[c(1,7)]
weekend
## Exercise 4

...

## Functions

function(...) {
  ...
  return(...)
}
