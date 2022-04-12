rm(list=ls()) # removes all variables stored previously 
library(Hmisc)
data <- read.csv("C:/Users/91901/Desktop/Covid_19_Project R/COVID19_line_list_data.csv")

describe(data) #hmisc command

#cleaned up death column 
data$death_dummy <- as.integer(data$death != 0)

#death rate
sum(data$death_dummy) / nrow(data)

# Age
# claim : people who die are older than the people who survive

dead = subset(data, death_dummy == 1)
alive = subset(data, death_dummy == 0)

mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)

# Checking with t test

t.test(alive$age, dead$age, alternative = "two.sided", conf.level = 0.95)

# normally if p-value < 0.05, we reject the null hypothesis 
# here p-value ~ 0, so we reject the null hypothesis 
# the claim that people who die are older than people who survive is statistically significant.


# GENDER
# claim : Gender has no effect on the death occurred by corona virus 

men = subset(data, gender == "male")
women = subset(data,gender == "female")

mean(men$death_dummy, na.rm = TRUE) # 8.5%
mean(women$death_dummy, na.rm = TRUE) # 3.7%

# Checking with t test

t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.99)

# 99 % confidence: men have from 0.8% to 8.8% higher chance of dying.
# p-value = 0.002 < 0.05, so we reject the null hypothesis 
# we can reject the claim that gender has no effect on the death rate
# men have a higher death rate than women