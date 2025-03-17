


library(SPEI)
library(tidyverse)
library(SCI)
library(writexl)
library(readr)
library(readxl)


# Directory containing CSV files
input_dir <- "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Streamflow/Stations"
output_dir <- "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Streamflow/Stations/SSI12"

# Get the list of CSV files in the directory
files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)

# Process each file
 for (file in files) {
  # Read the CSV file
  df <- read_csv(file)
  df$Date <- as.Date(df$Date, format = "%m/%d/%Y")
  start_date <- c(as.numeric(format(df$Date[1], "%Y")), as.numeric(format(df$Date[1], "%m")))
  ts_file <- ts(df$`Discharge`, start = start_date, frequency = 12)
  spi <- spi(ts_file, scale = 12, distribution = "Gamma", na.rm = T)
  results <- data.frame(Date = df$Date, SPI = spi$fitted)
  output_file <- file.path(output_dir, paste0(tools::file_path_sans_ext(basename(file)), "_SSI12.csv"))
  write_csv(results, output_file)
  cat("Processing is done for the file:", basename(file), "\n")
  
}

C:\Users\MasilelaNd\OneDrive - dwa.gov.za\Documents\Drought Projects\CHIRPS vs SAWS Paper
  
