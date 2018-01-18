## Tidy data concept

# evaluate the next command to create response
response <- read.csv(text = "
trial, drug_A, drug_B, placebo
1,     0.22,   0.58,   0.31
2,     0.12,   0.98,   0.47
3,     0.42,   0.19,   0.40
")

## Reshaping multiple columns in category/value pairs

library(tidyr)
tidy_response <- gather(response,
  key="treatment",
  value = "response",-trial)
# we want to keep trial as is  so we say -trial
#since we're creating new variables we need to put quotations
 tidy_response
# evaluate the next command to create counts
counts <- read.csv(text = "
site, species, n
1,    lynx,    2
1,    hare,    341
2,    lynx,    7
2,    hare,    42
3,    hare,    289
")


wide_counts <- spread(counts,
  key = species,
  value = n)
wide_counts <- spread(counts,
                      key = species,
                      value = n, fill=0) 
#this modified line assigns 0 instead of NA 

## Exercise 1
tidy_counts<-gather(wide_counts, key="species", value="N",-site)
## Read comma-separated-value (CSV) files

library(data.table)
cbp <- fread('data/cbp15co.csv')
str(cbp)
cbp <- fread(
  'data/cbp15co.csv',
  na.strings = '')
#Very important!! specifying the missings!

## Subsetting and sorting

library(dplyr)

cbp_health_care <- filter(
  cbp,NAICS=='62----')
  

library(stringr)
# this library includes many features to deal with strings
cbp_health_care <- filter(
  cbp,
  str_detect(NAICS,'^62'),
  !is.na(as.integer(NAICS)))


#the last line is saying that we're only keeping the ones with just numbers
cbp_health_care <- select(cbp_health_care,
  FIPSTATE,FIPSCTY,
  NAICS,
  EMPFLAG, EMP_NF,EMP
)
cbp_health_care <- select(cbp_health_care,
                          starts_with('FIP'),
                          NAICS,
                          starts_with('EMP')
)
# identifies patterns also (starts_with!)
str(cbp_health_care)
## Exercise 2
cbp_construction <- filter(
  cbp,NAICS=='23----')

cbp_construction<-select(cbp_construction,AP)
str(cbp_construction)


## Chainning with pipes
# All the previous command have in common 
#that all call the dataframe first. 
#The pipe operator allows us to connect
#the different commands but does not save the intermediate result
library(magrittr)


cbp_health_care <- cbp %>%
  filter(
          str_detect(NAICS, '^62'),
          !is.na(as.integer(NAICS))) %>%
  select(
          starts_with('FIPS'),
          NAICS,
          starts_with('EMP'))

## Grouping and aggregation

state_cbp_health_care <- cbp_health_care %>% mutate(
  FIPS=str_c(FIPSTATE,FIPSCTY))
#create state... including the concatenated variable FIPS based on the id of state and county
state_cbp_health_care <- cbp_health_care %>%
  group_by(FIPSTATE) %>%
  summarize(EMP_tot = sum(EMP))
  str(state_cbp_health_care)  
# Equivalent to collapse in stata
state_cbp_health_care <- cbp_health_care %>%
  group_by(FIPSTATE) %>%
  summarize(EMP = sum(EMP),
            country=n())

## Exercise 3

state_cbp_health_care <- cbp_health_care %>% mutate(
  FIPS=str_c(FIPSTATE,FIPSCTY))

state_cbp_health_care <- state_cbp_health_care %>%
  group_by(FIPSTATE, FIPSCTY) %>%
  summarize(EMP_tot = sum(EMP))%>%
  summarize(EMP_TOT=sum(EMP_tot),counties=n())
str(state_cbp_health_care)

head(state_cbp_health_care)
