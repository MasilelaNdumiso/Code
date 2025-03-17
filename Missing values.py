# -*- coding: utf-8 -*-
"""
Created on Mon Jul 29 13:34:53 2024

@author: MasilelaNd
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Create a sample dataframe with more than 10 columns and some missing values
np.random.seed(123)
data = {
    f'Col{i}': np.random.choice(list(range(1, 11)) + [np.nan], 100, replace=True)
    for i in range(1, 12)
}

file_path = r'C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Streamflow/all.csv'

# Read the CSV file into a DataFrame
df = pd.read_csv(file_path)

sample_data = pd.DataFrame(df)

# Display the first few rows of the sample dataframe
print(sample_data.head())


# Calculate the percentage of missing values for each column
missing_values = sample_data.isnull().sum().reset_index()
missing_values.columns = ['column', 'num_missing']
missing_values['pct_missing'] = (missing_values['num_missing'] / len(sample_data)) * 100

# Print the percentage of missing values for each column
print(missing_values)

# Visualize the percentage of missing values using matplotlib
plt.figure(figsize=(100, 60))
plt.barh(missing_values['column'], missing_values['pct_missing'], color='steelblue')
plt.xlabel('Percentage of Missing Values')
plt.title('Percentage of Missing Values in Sample Dataframe')
plt.gca().invert_yaxis()
plt.show()

output_file_path = r'C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Streamflow/all_missing.csv'

# Assuming 'df' is your DataFrame
missing_values.to_csv(output_file_path, index=False)
