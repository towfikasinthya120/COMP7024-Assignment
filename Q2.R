library(dplyr)
library(ggplot2)
library(knitr)

# Loading required datasets
games <- read.csv("games.csv")
sessions <- read.csv("sessions.csv")

# Checking the datasets
head(games)
head(sessions)

# Join sessions with games to get genre information
q2_data <- left_join(sessions, games, by = "game_id")

# Check merged data
head(q2_data)

# Calculate genre-level behaviour statistics
q2_summary <- q2_data %>%
  group_by(genre) %>%
  summarise(
    total_play_time = sum(play_time_minutes),
    number_of_sessions = n(),
    unique_players = n_distinct(player_id),
    avg_play_time_per_player = total_play_time / unique_players,
    score_efficiency = sum(score) / sum(play_time_minutes)
  )

# View results
q2_summary
