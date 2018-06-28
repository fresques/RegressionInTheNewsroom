# Case study: session attendees

library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)

# read in the data
people <- read_csv('data/sessionAttendees.csv')

people %>% head()

people %>% str()


# univariate linear model
m1 <- lm(data=genderGaps, gap_math ~ ses)
summary(m1)