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

#Merging sessions with players
q1_data <- left_join(sessions, players, by = "player_id")

head(q1_data)
nrow(q1_data)

#creating the summary table
q1_summary <- q1_data %>%
  group_by(experience_level) %>%
  summarise(
    unique_players = n_distinct(player_id),
    total_play_time = sum(play_time_minutes),
    avg_play_time_session = mean(play_time_minutes),
    avg_play_time_player = total_play_time / unique_players,
    avg_score = mean(score)
  )

q1_summary
