library(dplyr)
library(ggplot2)
library(knitr)

#Loading Datasets
players <- read.csv("players.csv")
sessions <- read.csv("sessions.csv")

head(players)
head(sessions)

#create Player Statistics
player_stats <- sessions %>%
  group_by(player_id) %>%
  summarise(
    total_sessions = n(),
    total_play_time = sum(play_time_minutes),
    avg_play_time = mean(play_time_minutes),
    avg_score = mean(score),
    unique_games_played = n_distinct(game_id)
  )

head(player_stats)