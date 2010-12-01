#!/bin/bash
#
# Loads Dutch HY data into PostGIS using deegree3 FSLoader
#
# Author: Just van den Broecke
#
# To be loaded
# WATERDEEL_LIJN
# WATERDEEL_VLAK
# INRICHTINGSELEMENT_LIJN

MYPWD=$PWD

SETTINGS_SCRIPT="settings-`hostname`.sh"
. $SETTINGS_SCRIPT

DATA_ROOT_DIR=$GEODATA_HOME/top10nl/shape/oost-nl
DATA_RESULT_DIR=$DATA_ROOT_DIR/transformed

FEATURE_TYPES="WATERDEEL_LIJN WATERDEEL_VLAK INRICHTINGSELEMENT_LIJN INRICHTINGSELEMENT_PUNT"

# Load each GML spatial dataset file
for FEATURE_TYPE in $FEATURE_TYPES; do
    echo "Loading HY_${FEATURE_TYPE}.gml ..."
    $LOADER_SCRIPT $LOADER_ARGS $DATA_RESULT_DIR/HY_${FEATURE_TYPE}.gml
done

cd $MYPWD
