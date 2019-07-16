#!/usr/bin/env bash

# VG Ericeira Block
# Leaving Highways and nodes created by JOSM outside
wget --output-document=poi.php 'http://overpass-api.de/api/interpreter?data=node["highway"!~"."]["created_by"!="JOSM"](38.956,-9.421,38.969,-9.402);out;'

TOPSTRING=$'<?php\n\n$xmlstr=<<<XML'
ENDSTRING=$'XML;\n\n?>'

# Add php declarations to the file
echo "$TOPSTRING" | cat - poi.php > temp && mv temp poi.php
echo "$ENDSTRING" >> poi.php

PHP=`which php`
$PHP parse.php

# Add javascript declaration to the json file and save it as jsonp

FILE=pois.json

if [ -f "$FILE" ]; then
	echo 'jsonstr = ' | cat - pois.json > temp && mv temp pois.jsonp
	echo ';' >> pois.jsonp
fi
