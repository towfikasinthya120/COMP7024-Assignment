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

# Calculate genre-level behavior statistics
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

# Display table
kable(q2_summary,
      digits = 2,
      caption = "Genre-Level Behaviour and Score Efficiency")

# Visualisation 1: Score efficiency by genre
ggplot(q2_summary, aes(x = genre, y = score_efficiency)) +
  geom_col() +
  labs(
    title = "Score Efficiency by Genre",
    x = "Genre",
    y = "Score per Minute"
  )

# Visualisation 2: Relationship between players and total play time
ggplot(q2_summary, aes(x = unique_players, y = total_play_time)) +
  geom_point(size = 3) +
  geom_text(aes(label = genre), vjust = -0.5) +
  labs(
    title = "Relationship Between Number of Players and Total Play Time",
    x = "Number of Unique Players",
    y = "Total Play Time"
  )

# Display table
kable(q2_summary,
      digits = 2,
      caption = "Genre-Level Behaviour and Score Efficiency")

#Visualisation of Score efficiency visualistion
ggplot(q2_summary, aes(x = genre, y = score_efficiency)) +
  geom_col() +
  labs(
    title = "Score Efficiency by Genre",
    x = "Genre",
    y = "Score per Minute"
  )
#Visualisation of Relationship between number of players and total play time
ggplot(q2_summary, aes(x = unique_players, y = total_play_time)) +
  geom_point(size = 3) +
  geom_text(aes(label = genre), vjust = -0.5) +
  labs(
    title = "Relationship Between Number of Players and Total Play Time",
    x = "Number of Unique Players",
    y = "Total Play Time"
  )


