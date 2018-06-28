# Case study 1: education data

library(dplyr)
library(downloader)
library(ggplot2)
library(readxl)
library(tidyr)

# download data
download(
  'https://cepa.stanford.edu/sites/default/files/reardon_gender_achievement_gaps_june2018.xlsx',
  'data/reardon_gender_achievement_gaps_june2018.xlsx')

# read in the data
genderGaps <- read_excel('data/reardon_gender_achievement_gaps_june2018.xlsx',sheet='Data')

# make column names shorter (just for the ones we'll use)
genderGaps <- genderGaps %>% 
  rename(
    ID       = `NCES District ID`,
    LEA_Name = `LEA Name`,
    state    = `Fips State Code`,
    gap_math = `EB Male-Female Math Achievement Gap (Grade Equivalent Units)`,
    gap_ela  = `EB Male-Female ELA Achievement Gap (Grade Equivalent Units)`,
    ses      = `SES Composite - All Adults`,
    students = `Average Number of Students in a Grade-Subject-Year`
  )


# plot something similar to the upshot piece
# (make the data longer before plotting)
genderGaps_long <- genderGaps %>% 
  select(ID,LEA_Name,state,ses,students,gap_math,gap_ela) %>% 
  gather(key="subject",value="gap",-ID,-LEA_Name,-state,-ses,-students)
  
genderGaps_long %>% 
  ggplot(aes(x=-ses,y=-gap,color=subject,size=students,alpha=0.3)) +
  geom_point() +
  geom_line(y=0,color="grey") +
  theme_minimal()


# univariate linear model
m1 <- lm(data=genderGaps, gap_math ~ ses)
summary(m1)

m2 <- lm(data=genderGaps, gap_ela ~ ses)
summary(m2)







