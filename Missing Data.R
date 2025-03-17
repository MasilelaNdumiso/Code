library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)


# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Create a sample dataframe with more than 10 columns and some missing values
set.seed(123)
sample_data <- data.frame(
  Col1 = sample(c(1:10, NA), 100, replace = TRUE),
  Col2 = sample(c(1:10, NA), 100, replace = TRUE),
  Col3 = sample(c(1:10, NA), 100, replace = TRUE),
  Col4 = sample(c(1:10, NA), 100, replace = TRUE),
  Col5 = sample(c(1:10, NA), 100, replace = TRUE),
  Col6 = sample(c(1:10, NA), 100, replace = TRUE),
  Col7 = sample(c(1:10, NA), 100, replace = TRUE),
  Col8 = sample(c(1:10, NA), 100, replace = TRUE),
  Col9 = sample(c(1:10, NA), 100, replace = TRUE),
  Col10 = sample(c(1:10, NA), 100, replace = TRUE),
  Col11 = sample(c(1:10, NA), 100, replace = TRUE)
)

# Display the first few rows of the sample dataframe
head(sample_data)

# Calculate the percentage of missing values for each column
missing.values <- sample_data %>%
  pivot_longer(cols = everything(), names_to = "key", values_to = "val") %>%
  mutate(is.missing = is.na(val)) %>%
  group_by(key, is.missing) %>%
  summarise(num.missing = n(), .groups = 'drop') %>%
  filter(is.missing == TRUE) %>%
  select(-is.missing) %>%
  arrange(desc(num.missing))

# Calculate the percentage of missing values for each variable
missing.values <- missing.values %>%
  mutate(pct.missing = (num.missing / nrow(sample_data)) * 100)

# Print the percentage of missing values for each column
print(missing.values)

# Visualize the percentage of missing values using ggplot2
ggplot(missing.values, aes(x = reorder(key, -pct.missing), y = pct.missing)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Percentage of Missing Values in Sample Dataframe",
       x = "Variables",
       y = "Percentage of Missing Values") +
  theme_minimal() +
  coord_flip()
