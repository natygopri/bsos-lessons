## Getting started

library(dplyr)
animals <- read.csv('data/animals.csv',
  na.strings = '') %>%
  select(year, species_id,sex,weight) %>%
  na.omit()
#The last line is to get rif of observations with one na

## Constructing layered graphics in ggplot

library(ggplot2)
ggplot(animals,
       aes(x=species_id, y=weight)) + #variables in the y and x axis
      geom_point()

ggplot(animals,
       aes(x = species_id, y = weight)) +
      geom_boxplot()
ggplot(animals,
       aes(x = species_id, y = weight)) +
  geom_boxplot() + geom_point()

ggplot(animals,
  aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(color = 'red',
             stat = 'summary',
             fun.y='mean')

ggplot(animals,
  aes(x = species_id, y = weight,
    color= species_id)) +
  geom_boxplot() +
  geom_point(stat = 'summary',
             fun.y = 'mean')

## Exercise 1
dm <-filter(animals, species_id=="DM")
ggplot(dm, aes(x=year, y = weight, color=sex)) +
geom_point(stat='summary', fun.y = 'mean')

## Adding a regression line
#Rewritting the levels in the data to change the label in the graph
levels(animals$sex) <- c('Female', 'Male')

ggplot(dm,
  aes(x = year, y = weight, color=sex)) +
  geom_point(size = 3,
    stat = 'summary', fun.y = 'mean') +
    geom_smooth(method = 'lm')

ggplot(dm,
  aes(x = year, y = weight,
    shape = sex, color = sex)) +
  geom_point(size = 3,
    stat = 'summary', fun.y = 'mean') +
  geom_smooth(method='lm')
ggplot(dm,
       aes(x = year, y = weight,
           shape = sex, color = sex)) +
  geom_point(size = 3,
             stat = 'summary', fun.y = 'mean') +
  geom_smooth(method='lm', color='black')

# Storing and re-plotting

year_wgt <- ggplot(dm,
  aes(x = year, y = weight,
    color = sex, shape = sex)) +
  geom_point(size = 3,
    stat = 'summary',
    fun.y = 'mean') +
  geom_smooth(method = 'lm')

year_wgt <- year_wgt +
  scale_color_manual(
    values = c("black","red"))
year_wgt
## Exercise 2
histo<-ggplot(dm,
       aes(x = weight,
           fill = sex)) +
  geom_histogram(binwidth=0.5)


## Axes, labels and themes



histo <- histo + labs(title =
  'Dipodomys merriami weight distribution',
  x = 'Weight (g)',
  y = 'Count')
histo
histo <- histo + scale_x_continuous(
  limits = c(20,60),
  breaks = c(20, 30, 40, 50, 60))

histo <- histo + theme_bw()+ theme(
  legend.position = c(0.2, 0.5), # 0 to one right left top bottom
  plot.title = element_text(
  face='bold',vjust=2),
  axis.title.y =  element_text(size=13,vjust=0))


## Facets

animals_common <- filter(
  animals, species_id %in% c('DM','PP','DO'))

faceted <- ggplot(animals_common, aes(x = weight)) +
  geom_histogram() +
  facet_wrap( ~ species_id) +
  labs(title =
       "Weight of most common species",
       x = "Count",
       y = "Weight (g)")

faceted_all <- faceted +
  geom_histogram(data =
    select(animals_common,-species_id),
    alpha=0.2)
faceted_all
faceted_density <- ggplot(  animals_common,
  aes(x = weight, fill=species_id)) +
  geom_histogram(aes(y=..density..)) +
  facet_wrap( ~ species_id) +
  labs(title =
       "Weight of most common species",
       x = "Count",
       y = "Weight (g)")

## Exercise 3

...
