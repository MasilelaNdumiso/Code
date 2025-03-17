# -*- coding: utf-8 -*-
"""
Created on Fri May 31 13:50:06 2024

@author: MasilelaNd
"""

#Data Extracted for G2 secondary basin South Africa (Stellenbosch, Strand, Fish Hoek, Malmesbury & Cape Town)
import geopandas as gpd
import os 
import rasterio
import scipy.sparse as sparse
import pandas as pd 
import numpy as np

# Creating an empty pandas dataframe called "table'
table = pd.DataFrame(index = np.arange(0,1))

## stations = pd.read_csv("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/Western Cape Primary Catchment CHIRPS Points.csv")
# Read the points shapefile using geopandas
stations = gpd.read_file("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/CHIRPS Near SAWS EC selection.shp")
stations.plot()
stations['long'] = stations['geometry'].x 
stations['lati'] = stations['geometry'].y 

Matrix = pd.DataFrame()

# Iterate through the rasters and save the data as individual arrays to a Matrix  
for files in os.listdir("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/CHIRPS 1981 - 2024"):
    if files[-4:]== '.tif':
        dataset = rasterio.open("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/CHIRPS 1981 - 2024"+'\\'+files)
        data_array = dataset.read(1)
        data_array_sparse = sparse.coo_matrix(data_array, shape = (269, 430))
        date = files[:-4]
        Matrix[date] = data_array_sparse.toarray().tolist()
    
        print("Processing is done for the raster:"+files[:-4])
        
       
# Iterate through the stations and get the corresponding row and column for the related x,y coordinates 
for index, row in stations.iterrows():
    station_name = str(row['OBJECTID']) 
    lon = float(row['POINT_X']) 
    lat = float(row['POINT_Y'])
    x,y = (lon,lat) 
    row, col = dataset.index(x,y) 
    print('processing'+station_name)
    
    #Pick the rainfall frrom each stored raster array and record it into the previously created 'table'
    for records_date in Matrix.columns.tolist():
        a = Matrix[records_date]
        rf_value = a.loc[int(row)][int(col)]
        table[records_date] = rf_value
        transpose_mat = table.T 
        transpose_mat.rename(columns = {0: "Rainfall(mm)"}, inplace = True) 
    transpose_mat.to_csv("C:/Users/MasilelaNd/OneDrive - dwa.gov.za/Documents/Drought Projects/Pilot Drought Dashboard info/Pilot Drought Dashboard info/New folder"+"\\"+station_name+".csv")