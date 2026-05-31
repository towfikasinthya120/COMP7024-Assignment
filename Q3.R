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

#Define high-value criteria
playtime_threshold <- quantile(
  player_stats$total_play_time,
  0.75
)

score_threshold <- mean(
  player_stats$avg_score
)

playtime_threshold
score_threshold

#Identify high-value players
high_value_players <- player_stats %>%
  filter(
    total_play_time > playtime_threshold &
      avg_score > score_threshold
  )

head(high_value_players)

#visualisation 1
ggplot(
  high_value_players,
  aes(y = avg_score)
) +
  geom_boxplot() +
  labs(
    title = "Score Distribution of High-Value Players",
    y = "Average Score"
  )