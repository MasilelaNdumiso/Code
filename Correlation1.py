# -*- coding: utf-8 -*-
"""
Created on Tue Aug 27 09:29:40 2024

@author: MasilelaNd
"""

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Step 1: Load your data into a DataFrame
# Assuming you have a CSV file with your data
file_path = 'C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Propogation/Lower B-Catchment/merged_file.csv'  # Replace with your file path
df = pd.read_csv(file_path)

# Step 2: Calculate the correlation matrix
corr_matrix = df.corr()

# Print the correlation matrix
print(corr_matrix)

# Step 3: Optional - Visualize the correlation matrix as a heatmap
plt.figure(figsize=(20, 16))
sns.heatmap(corr_matrix, annot=True, cmap='coolwarm', fmt='.2f', linewidths=0.5)
plt.title('Correlation Matrix')
plt.show()

