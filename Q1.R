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

#Creating experience groups
players$experience_level <- NA

players$experience_level[players$signup_date < as.Date("2023-01-01")] <- "Veteran"

players$experience_level[
  players$signup_date >= as.Date("2023-01-01") &
    players$signup_date <= as.Date("2023-12-31")
] <- "Intermediate"

players$experience_level[players$signup_date > as.Date("2023-12-31")] <- "New"

table(players$experience_level)
head(players)