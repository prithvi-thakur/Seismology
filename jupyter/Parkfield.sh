#!bin/bash

# Central-Southern California map
#

# Things to do in terminal prior to plotting the data:
# 1. Figure out the xmin/xmax and ymin/ymax of the data sets by using the gmtinfo command
#    a. topography.xy - xmin = 0, xmax = 237.5, ymin = -18.98, ymax = 0
#    b. spectrum.xy - xmin = 0, xmax = 199.99390877, ymin = 6.53e-06, ymax = 0.8641337
# 2. Change the c-shell script to an executable file by using chmod +x fileName.csh

# Add preferences here
#gmt gmtset MAP_FRAME_PEN 3

gmt gmtset FORMAT_GEO_MAP DD #set labels on the map to decimal degrees

gmt gmtset MAP_FRAME_TYPE fancy #make outline of the map a single line with ticks

gmt gmtset FONT_TITLE 24p #size of the title font

gmt gmtset MAP_TITLE_OFFSET -0.4c #offset the map title down by 0.4 cm

gmt gmtset FONT_LABEL 14p #size of the label fonts

gmt gmtset MAP_LABEL_OFFSET 0.3c #offset the labels up by 0.3 cm

gmt gmtset FONT_ANNOT_PRIMARY 12p #size of the primary annotation font

#set the -R flag: LONleft/LONright/ LATbottom/ LATtop
region="-R-122/-119/35/37"

#set the -J flag:
#-JM6i= mercator projection with longest axis=6 inches
#-JX7i/2i= XY projection 7 inches horizontal and 2 inches vertical 
#
projection="-JM6i"

#used with the opening/first postscript file
open="-K -V"

#used when adding to an existing postscript file
add="-O -K -V"

#used when adding the last object to postscript file
close="-O -V"

#output file names
psFile=$0.ps

pdfFile=$0.pdf

#topo=./socal_3as.grd
topo=./etopo1_bedrock.grd

#gmt surface socal_3as.xyz -Gtopo.grd -I3s $region 

#topo=topo.grd

#Start code here
misc="-X2 -Y14" #Shift the map in the page
gmt psbasemap $region $projection -P -B1/1WSen $misc $open > $psFile
#-B flag parameters: -B20g10f5:"x-axis label":/5g2.5f1:"y-axis label"::."Title of Plot":WSen
# 20g10f5:"x-axis label": 
#					20 = label increment
#					g10 = grid spacing
#					f5 = small tick mark spacing
#					:"x-axis label": = name
#					/ separates x and y labelling scheme
# 5g2.5f1:"y-axis label":
#					5 = label increment
#					g2.5 = grid spacing
#					f1 = small tick mark spacing
#					:"y-axis label": = name
# :."Title of the  plot":
#
# WSen = how the axis is drawn. W = west, S = south, E = east, N = north.
# if the letter is capitalized gmt will add label axes, draw tick marks and corresponding outline.

#make color pallete
gmt makecpt -Crelief -T-4000/4000/0.01 -Z > topo.cpt

gmt grdgradient $topo -A135 -Ne0.8 -Gshadow.grd

gmt grdimage $topo $region $projection $add -Ctopo.cpt >> $psFile

gmt pscoast $region $projection $add -W2 -Dh -Na -Ia -Lf89.4/14/10/200+lkm >> $psFile

gmt makecpt -Cbathy -T0/20/2 -Z > seis.cpt

#PROJECT DATA
awk -F "," 'NR>1 {print($3,$2,$4,$5)}' Parkfield_Time2.htm | project -C-120.18/35.6 -E-121/36.4 -W-0.06/0.06 -Lw > projection5.dat

#awk -F "," 'NR>1 {print($3,$2,$4,$5)}' Parkfield_Time1.csv | psxy $region $projection $add -W.1 -Sc0.01 -Cseis.cpt >> $psFile

awk -F " " '{print($1,$2,$3, $4*(0.05))}' projection5.dat | psxy $region $projection $add -W.1 -Scc -Cseis.cpt >> $psFile

psscale -D1/3.2/4/0.3 -B5:Depth:/:km: -Cseis.cpt $add >> $psFile

# View dashed line along fault strike
psxy $region $projection $add -W1 -Ss.2 -G255/0/0 <<END>> $psFile
-120.18 35.625
-120.45 35.9
-120.98 36.4
END

psxy $region $projection $add -Wthin,red,- <<END>> $psFile
-120.18 35.625
-120.98 36.4
END

# View transect line
#psxy $region $projection $add -Wthick,red <<END>> $psFile
#-122 34
#-116 38
#END

pstext $region $projection $add -N -F+f12p,Helvetica-Bold,black <<END>> $psFile
-120.86 36.4 14 0 5 MC P1
END

pstext $region $projection $add -N -F+f12p,Helvetica-Bold,black <<END>> $psFile
-120.1 35.625 14 0 5 MC P2
END

pstext $region $projection $add -N -F+f10p,Helvetica-Bold,black <<END>> $psFile
-120.2 35.9 14 0 5 MC Parkfield
END


#PROJECT DATA
#awk -F "," 'NR>1 {print($3,$2,$4)}' Parkfield_Time1.csv | project -C-120.625/36 -E-121/36.4 -W-0.06/0.06 -Lw > projection3.dat

#MAKE SCATTER PLOT
#region="-R-0.07/0.07/-16/0"
#projection="-JX6i/3i"
#misc="-Y-9"
#awk '{print($5,$3*(-1.0))}' projection3.dat | psxy $region $projection -B2:Distance:/4:Depth:WSen -W1 -Sc.02 -G200 $misc $close >> $psFile


ps2pdf $psFile $pdfFile

open $pdfFile

echo "end of script"
