#!/usr/bin/env bash

declare -A HOTELS
HOTELS[Ericeira]='http://overpass-api.de/api/interpreter?data=node["highway"!~"."]["created_by"!="JOSM"](38.956,-9.421,38.969,-9.402);out;'
HOTELS[Tavira]='http://overpass-api.de/api/interpreter?data=node["highway"!~"."]["created_by"!="JOSM"](37.111051,-7.661719,37.128913,-7.618461);out;'
HOTELS[ClubeCampo]='http://overpass-api.de/api/interpreter?data=node["highway"!~"."]["created_by"!="JOSM"](37.847341,-8.079071,37.913800,-7.921314);out;'
# All the other hotels come here

for hotel in "${!HOTELS[@]}"
do
  echo "Key    : $hotel"
  echo "Value  : ${HOTELS[$hotel]}"

  wget --output-document=$hotel.php ${HOTELS[$hotel]}

  TOPSTRING=$'<?php\n\n$xmlstr=<<<XML'
  ENDSTRING=$'XML;\n\n?>'

  # Add php declarations to the file
  echo "$TOPSTRING" | cat - $hotel.php > temp && mv temp $hotel.php
  echo "$ENDSTRING" >> $hotel.php

  if [ ! -d "hotels" ] 
	  then mkdir hotels
  fi

  mv $hotel.php 'hotels/'$hotel.php

  PHP=`which php`
  $PHP parse.php

  # Add javascript declaration to the json file and save it as jsonp
  FILE='hotels/'$hotel.json

  if [ -f "$FILE" ]; then
  	  echo 'jsonstr = ' | cat - 'hotels/'$hotel.json > temp && mv temp 'hotels/'$hotel.jsonp
	  echo ';' >> 'hotels/'$hotel.jsonp
  fi
done

# Remove .json files because they have no use
rm 'hotels/'*.json
