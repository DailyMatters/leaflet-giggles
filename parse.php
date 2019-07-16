<?php 

foreach (glob("hotels/*.php") as $filename)
{
    include $filename;

	$result_array = array();

	$nodes = new SimpleXMLElement($xmlstr);

	foreach ( $nodes->node as $node ) {
		if ( isset( $node->{'tag'} )) {
			$result_array[] = $node;
		}
	}

	$result_array = json_encode($result_array);

	//Save tags somewhere else
	$filename_without_extension = pathinfo($filename, PATHINFO_FILENAME);
	file_put_contents('hotels/' . $filename_without_extension . '.json', $result_array);

}

?>
