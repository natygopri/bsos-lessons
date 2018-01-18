# Linear models

animals <- read.csv('data/animals.csv',
                   na.strings = '')
fit <- lm(formula = hindfoot_length ~ species_id*log(weight),
  data=animals)

summary (fit)
# Metadata matters

fit <- lm(
  ...,
  data = animals)

# Exercise 1

...

# GLM families

fit <- glm(log(weight)~species_id,family=gaussian,data=animals)

summary(fit)
# Exercise 2

fit1<-glm(weight~species_id,family=poisson,data=animals)
summary (fit1)
anova(fit1, test='Chisq')
# Logistic regression
animals$sex
animals$sex <- factor(animal$sex)
fit <- glm(sex~hindfoot_length, family= binomial,data=animals)
summary (fit)  
# Exercise 3

...

# Random intercept
#before loading the package you need to download the package before
library(lme4)
fit <-lmer(
  hindfoot_length ~ (1|species_id)+log(weight),
  data = animals)
summary(fit)
# Exercise 4

...

# Random slope

fit <- lmer(
  hindfoot_length ~ 
    log(weight)+ (log(weight)| species_id),
  data = animals)
summary(fit)
ranef(fit)
