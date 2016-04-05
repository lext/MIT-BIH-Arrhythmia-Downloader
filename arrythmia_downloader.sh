#!/bin/bash

# MIT-BIH Arrythmia Database downloader
#
# (c) Aleksei Tiulpin, 2016
#
# Center for Machine Vision and Signal Analysis
# University of Oulu, Finland

# This script is using WFDB software for conversion

SRC_FLD="mit_arrythmia_dat"
RES_FLD="mit_arrythmia"

# First, download the dataset and save it to mit_arrythmia_dat directory:
mkdir $SRC_FLD
mkdir $RES_FLD

cd $SRC_FLD

wget http://physionet.org/physiobank/database/mitdb/{100..234}.dat
wget http://physionet.org/physiobank/database/mitdb/{100..234}.hea
wget http://physionet.org/physiobank/database/mitdb/{100..234}.atr

cd ..

# Now we will start the actual conversion

for filename in $SRC_FLD/*.dat
do
	f="$(echo $filename | cut -c$((${#SRC_FLD}+2))-$((${#filename}-4)))"
	rdsamp -r "$SRC_FLD/$f" > "$RES_FLD/$f.txt"
done

rm -rf $SRC_FLD
