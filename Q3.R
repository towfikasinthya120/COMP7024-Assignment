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

#visualisation 2
ggplot(
  high_value_players,
  aes(
    x = total_play_time,
    y = avg_score
  )
) +
  geom_point() +
  labs(
    title = "Relationship Between Play Time and Score",
    x = "Total Play Time",
    y = "Average Score"
  )

#Summary table
q3_summary <- high_value_players %>%
  summarise(
    number_of_high_value_players = n(),
    avg_total_play_time = mean(total_play_time),
    avg_score = mean(avg_score),
    avg_sessions = mean(total_sessions),
    avg_unique_games = mean(unique_games_played)
  )

q3_summary

kable(
  q3_summary,
  digits = 2,
  caption = "Summary Statistics of High-Value Players"
)