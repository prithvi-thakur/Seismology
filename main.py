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
#  plt.rcParams['axes.labelsize'] = 14
#  plt.rcParams['font.titlesize'] = 16
#  plt.rcParams['xtick.labelsize'] = 14
#  plt.rcParams['ytick.labelsize'] = 14
#  plt.rcParams['legend.fontsize'] = 16

# Read data from the downloaded CSV file
class input_data:

    data = pd.read_csv("data.html", skiprows=13)
    latitude = np.array(data["Latitude"])
    longitude = np.array(data["Longitude"])
    DateTime = np.array(data["DateTime"])
    Mw = np.array(data["Magnitude"])

#  Change the time (yyyy-mm-dd-h-m-s) to continuous format
def continuous_time(DateTime):
   
    # pre allocate
    time_ = np.zeros(len(DateTime))
    i = 0
    for el in DateTime:
        y = float(el[0:4])
        m = float(el[5:7])
        d = float(el[8:10])
        h = float(el[11:13])
        min = float(el[14:16])
        s = float(el[17:22])

        time_[i] = y + (m + (d + (h + (min + s/60)/60)/24)/30)/12 
        i = i+1

    return time_

#  return Mw, time_
inp = input_data()
tt = continuous_time(inp.DateTime)
print(max(tt))


















