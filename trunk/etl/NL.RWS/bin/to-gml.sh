#!/bin/bash
#
# Transforms Dutch local data from Shape or MapInfo  format to flat GML v2
# (no reprojection as this would generate 3D coordinates)
#
# Author: Just van den Broecke
#

# really need these specific PROJ projection strings as most transforms
# with EPSG 28992 (Dutch RD) and EPSG 4258 (ETRS89) are broken
proj28992="+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.999908 +x_0=155000 +y_0=463000 +ellps=bessel +units=m +towgs84=565.2369,50.0087,465.658,-0.406857330322398,0.350732676542563,-1.8703473836068,4.0812 +no_defs"
proj4258="+proj=longlat +ellps=GRS80 +datum=WGS84 +no_defs  <>"

# default geotype
geotype=MULTILINESTRING

# Transformation
function transform() {
    echo "transforming $1 to $2 ..."
    
    # http://trac.osgeo.org/gdal/wiki/ConfigOptions
    # Otherwise we'll loose the CP1252 encoded chars
    # export OGR_FORCE_ASCII=NO

    # The main conversion command: converts Shpe in RD to GML in ETRS89
    ogr2ogr -nlt $geotype -t_srs "$proj4258" -s_srs "$proj28992" -f "GML" $2 $1

    # In some cases we need to convert char encoding to UTF-8
    # If source is 7-bit ASCII text (as with RWS NWB) this is valid UTF-8-encoded Unicode already and
    # no conversion is needed. Best is to always check with the Unix tool "enca".

    # EXAMPLE
    # need to make UTF-8 encoded GML and change namespace id for gml2
    # cat $2 | iconv -f CP1252 -t UTF-8 | sed s/gml:/gml2:/g | sed s/:gml/:gml2/g > temp.gml
    # mv temp.gml $2
    cat $2 | sed s/gml:/gml2:/g | sed s/:gml/:gml2/g > temp.gml
    mv temp.gml $2

    echo "transforming $1 to $2 DONE"
}

# Arg parsing
# See http://www.linux.com/archive/feature/118031
while getopts t:s OPTION
  do
    case "$OPTION" in
     t) geotype="$OPTARG";;
    [?]) echo "Usage: $0 [-t (MULTIPOLYGON|MULTILINESTRING|POINT) ] sourcefile destfile"
      exit 1;;
    esac
  done

shift $(($OPTIND - 1))

# Remaining args are source and dest file
transform $1 $2

