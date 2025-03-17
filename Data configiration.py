# -*- coding: utf-8 -*-
"""
Created on Tue Jun  4 10:08:35 2024

@author: MasilelaNd
"""

import pandas as pd
import os
import numpy as np

df = pd.read_csv("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/2010 - 2024 CHIRPS data/51702.csv")
df.rename( columns={'Unnamed: 0':'Date'}, inplace=True )

df['Date']= pd.to_datetime(df['Date'])
df['Date'] = pd.to_datetime(df['Date'], format='%Y%m%d')

df = df.resample('M', on='Date').sum()


for files in os.listdir("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/1981 - 2009 CHIRPS data"):
    if files[-4:]== '.csv':
        dataset = pd.read_csv("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/1981 - 2009 CHIRPS data"+'\\'+files)
        dataset.rename( columns={'Unnamed: 0':'Date'}, inplace=True )
        dataset['Date']= pd.to_datetime( dataset['Date'])
        dataset = dataset.resample('M', on='Date').sum()
        print("Processing is done for the dataset:"+files[:-4])
 
    
 
import os
import pandas as pd

# Directory containing the CSV files
input_dir = "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Middle B-Catchment"
output_dir = "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Middle B-Catchment"

# Create the output directory if it does not exist
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

# Loop through all files in the specified directory
for files in os.listdir(input_dir):
    # Check if the file extension is '.csv'
    if files[-4:] == '.csv':
        # Read the CSV file into a pandas DataFrame
        dataset = pd.read_csv(os.path.join(input_dir, files))
        
        # Rename the column 'Unnamed: 0' to 'Date'
        dataset.rename(columns={'Unnamed: 0': 'Date'}, inplace=True)
        
        
        # Convert the 'Date' column from 'YYYYMMDD' to datetime format
        dataset['Date'] = pd.to_datetime(dataset['Date'], format='%Y%m%d')
        
        # Resample the data to monthly frequency, summing up all values in each month
        dataset = dataset.resample('M', on='Date').sum()
        
        # Define the output file path
        output_file = os.path.join(output_dir, files)
        
        # Save the processed DataFrame to a new CSV file
        dataset.to_csv(output_file, index=True)
        
        # Print a message indicating the processing is done for the current file
        print(f"Processing is done for the dataset: {files[:-4]} and saved to {output_file}")



######Joining the CSV files 

# Define the paths to the two Excel workbooks
workbook1_path = "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/1981 - 2009 Monthly CHIRPS Data/65438.csv"
workbook2_path = "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/2010 - 2024 Monthly CHIRPS Data/65438.csv"
combined_workbook_path = "C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/1981 - 2024/65438.csv"

# Read the Excel files into pandas DataFrames
df1 = pd.read_csv(workbook1_path)
df2 = pd.read_csv(workbook2_path)

# Concatenate the DataFrames
combined_df = pd.concat([df1, df2], ignore_index=True)

# Save the combined DataFrame to a new Excel file
combined_df.to_csv(combined_workbook_path, index=False)

print(f"Combined workbook saved to {combined_workbook_path}")