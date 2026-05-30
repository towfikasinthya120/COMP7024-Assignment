library(dplyr)
library(ggplot2)
library(knitr)
#loading datasets
players <- read.csv("players.csv")
sessions <- read.csv("sessions.csv")


head(players)
head(sessions)

#Converting signup date
players$signup_date <- as.Date(players$signup_date)

str(players)
summary(players$signup_date)

