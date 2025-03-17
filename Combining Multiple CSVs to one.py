# -*- coding: utf-8 -*-
"""
Created on Thu Aug  1 11:53:32 2024

@author: MasilelaNd
"""



import os
import pandas as pd

# Define the directory containing the CSV files
input_dir = 'C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Lower B-Catchment'  # Change this to your actual directory path

# Get a list of all CSV files in the directory
csv_files = [f for f in os.listdir(input_dir) if f.endswith('.csv')]

# Initialize an empty DataFrame to store the merged data
merged_df = pd.DataFrame()

# Iterate through the list of files and read each one into a DataFrame
for i, file in enumerate(csv_files):
    file_path = os.path.join(input_dir, file)
    try:
        # Read the CSV file
        df = pd.read_csv(file_path)
        
        # Rename the second column to the file name (without the .csv extension)
        df.columns = ['Date', os.path.splitext(file)[0]]
        
        # Merge the dataframes on the 'Date' column
        if merged_df.empty:
            merged_df = df
        else:
            merged_df = pd.merge(merged_df, df, on='Date', how='outer')
    except ValueError as e:
        print(f"Skipping file {file} due to error: {e}")
    except pd.errors.EmptyDataError:
        print(f"Skipping empty file: {file}")

# Check if there are any data to save
if not merged_df.empty:
    # Save the merged DataFrame to a new CSV file
    output_file = os.path.join(input_dir, 'merged_file.csv')
    merged_df.to_csv(output_file, index=False)
    
    print(f"All files have been successfully merged into {output_file}")
else:
    print("No valid CSV files found to concatenate.")



import os
import pandas as pd

# Define the directory containing the CSV files
input_dir = 'C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/SGI VS SSI/SSI1'  # Change this to your actual directory path

# Get a list of all CSV files in the directory
csv_files = [f for f in os.listdir(input_dir) if f.endswith('.csv')]

# Initialize an empty DataFrame to store the merged data
merged_df = pd.DataFrame()

# Iterate through the list of files and read each one into a DataFrame
for i, file in enumerate(csv_files):
    file_path = os.path.join(input_dir, file)
    try:
        # Read the CSV file
        df = pd.read_csv(file_path)
        
        # Rename the second column to the file name (without the .csv extension)
        df.columns = ['Date', os.path.splitext(file)[0]]
        
        # Merge the dataframes on the 'Date' column
        if merged_df.empty:
            merged_df = df
        else:
            merged_df = pd.merge(merged_df, df, on='Date', how='outer')
    except ValueError as e:
        print(f"Skipping file {file} due to error: {e}")
    except pd.errors.EmptyDataError:
        print(f"Skipping empty file: {file}")

# Check if there are any data to save
if not merged_df.empty:
    # Convert the 'Date' column to datetime format to identify the earliest date
    merged_df['Date'] = pd.to_datetime(merged_df['Date'])
    
    # Find the earliest date in the DataFrame
    earliest_date = merged_df['Date'].min().strftime('%Y-%m-%d')
    
    # Save the merged DataFrame to a new CSV file with the earliest date in the filename
    output_file = os.path.join(input_dir, f'merged_file_{earliest_date}.csv')
    merged_df.to_csv(output_file, index=False)
    
    print(f"All files have been successfully merged into {output_file}")
else:
    print("No valid CSV files found to concatenate.")


