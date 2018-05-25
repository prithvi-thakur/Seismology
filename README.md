# Seismology
A collection of small projects on earthquakes using GMT and Python. Look at final ppt.pdf for the results.

Cluster the earthquakes in space and compute b-values (https://www.wikiwand.com/en/Gutenberg%E2%80%93Richter_law) for each cluster.

Steps:

1. Download data from NCEDC for any specified time period. (In this repo, Parkfield_EQ_.htm, Parkfield_Time1.csv, etc.).
2. Run Parkfield.sh. Additional information in the file. This is a shell script for projection of earthquake data along the fault. It uses generic mapping tools.
3. Run the python program bValues.ipynb. This program clusters the projected data using k-means clustering and computes the b-values for each cluster.
