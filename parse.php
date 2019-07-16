<?php 

include 'poi.php';

$result_array = array();

$nodes = new SimpleXMLElement($xmlstr);

foreach ( $nodes->node as $node ) {
	if ( isset( $node->{'tag'} )) {
		$result_array[] = $node;
	}
}

$result_array = json_encode($result_array);

//Save tags somewhere else
file_put_contents('pois.json', $result_array);

?>
