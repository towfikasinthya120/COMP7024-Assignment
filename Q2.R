# Q2: Genre-Level Behaviour and Efficiency

library(dplyr)
library(ggplot2)
library(knitr)

# Load required datasets
games <- read.csv("games.csv")
sessions <- read.csv("sessions.csv")

# Check the datasets
head(games)
head(sessions)

# Join sessions with games to get genre information
q2_data <- left_join(sessions, games, by = "game_id")

# Check merged data
head(q2_data)