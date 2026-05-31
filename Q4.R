library(dplyr) 
library(ggplot2) 
library(knitr) 

#Loading Datasets
players <- read.csv("players.csv") 
sessions <- read.csv("sessions.csv") 

head(players) 
head(sessions) 

#Creating Age groups
players$age_group <- cut(
  players$age,
  breaks = c(17, 24, 34, 44, Inf),
  labels = c("18-24", "25-34", "35-44", "45+")
)

# Check age groups
table(players$age_group)

#Merge Datasets
q4_data <- left_join(
  sessions,
  players,
  by = "player_id"
)

head(q4_data)

#Creating Summary Statistics
q4_summary <- q4_data %>%
  group_by(age_group) %>%
  summarise(
    unique_players = n_distinct(player_id),
    total_sessions = n(),
    avg_play_time = mean(play_time_minutes),
    avg_score = mean(score)
  )

q4_summary

#Testing code
# Verify age groups
table(players$age_group)

# Verify merged dataset
head(q4_data)

# Verify summary table
q4_summary