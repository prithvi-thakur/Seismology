########################################################
# EARTHQUAKE STATISTICS AND B-VALUE VARIATION
# Parkfield region, San Andreas Fault
# 
# Author: Prithvi Thakur
# Date: 09-03-2018

# [INFO] 1. Plot earthquakes in time
#        2. Plot the magnitude-frequency distribution
#        3. Project earthquakes on the fault plane
#        4. Cluster the earthquakes and analyze b-balues
#########################################################

import numpy as np                  # for everything
import matplotlib.pyplot as plt     # for plotting
import scipy.stats as stats         # for linear regression
from sklearn.cluster import KMeans  # for k-means clustering
import pandas as pd                 # to read csv files

# Change default plot settings
plt.rcParams['font.size'] = 16
plt.rcParams['axes.labelsize'] = 14
plt.rcParams['font.titlesize'] = 16
plt.rcParams['xtick.labelsize'] = 14
plt.rcParams['ytick.labelsize'] = 14
plt.rcParams['legend.fontsize'] = 16

# Read data from the downloaded CSV file
# Return the latitude and longitude
class input_data: 
    data = pd.read_csv('data.html')
    latitude = np.array(data["Latitude"])
    longitude = np.array(data["Longitude"])
    DateTime = np.array(data["DateTime"])
    Mw = np.array(data["Magnitude"])

    def time_series(self):
        # Change the time (yyyy-mm-dd-h-m-s) to continuous format
        
        return Mw, time_
