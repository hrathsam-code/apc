<?php

// Configuration
$accessLicenseNumber = "Add License Key Here";
$userId = "Add User Id Here";
$password = "Add Password Here";

$endpointurl = 'Add URL Here';
$outputFileName = "XOLTResult.xml";

try {
	
	// Create AccessRequest XMl
	$accessRequestXML = new SimpleXMLElement ( "<AccessRequest></AccessRequest>" );
	$accessRequestXML->addChild ( "AccessLicenseNumber", $accessLicenseNumber );
	$accessRequestXML->addChild ( "UserId", $userId );
	$accessRequestXML->addChild ( "Password", $password );
	
	// Create AddressValidationRequest XMl
	$xavRequestXML = new SimpleXMLElement ( "<AddressValidationRequest ></AddressValidationRequest >" );
	$request = $xavRequestXML->addChild ( 'Request' );
	$request->addChild ( "RequestAction", "XAV" );
	$request->addChild ( "RequestOption", "3" );
	
	$address = $xavRequestXML->addChild ( 'AddressKeyFormat' );
	$address->addChild ( "AddressLine", "Address Line" );
	$address->addChild ( "PoliticalDivision2", "Alpharetta" );
	$address->addChild ( "PoliticalDivision1", "GA" );
	$address->addChild ( "PostcodePrimaryLow", "30009" );
	$address->addChild ( "CountryCode", "US" );
	
	$requestXML = $accessRequestXML->asXML () . $xavRequestXML->asXML ();
	
	$form = array (
			'http' => array (
					'method' => 'POST',
					'header' => 'Content-type: application/x-www-form-urlencoded',
					'content' => "$requestXML" 
			) 
	);
	
	// get request
	$request = stream_context_create ( $form );
	$browser = fopen ( $endpointurl, 'rb', false, $request );
	if (! $browser) {
		throw new Exception ( "Connection failed." );
	}
	
	// get response
	$response = stream_get_contents ( $browser );
	fclose ( $browser );
	
	if ($response == false) {
		throw new Exception ( "Bad data." );
	} else {
		// save request and response to file
		$fw = fopen ( $outputFileName, 'w' );
		fwrite ( $fw, "Request: \n" . $requestXML . "\n" );
		fwrite ( $fw, "Response: \n" . $response . "\n" );
		fclose ( $fw );
		
		// get response status
		$resp = new SimpleXMLElement ( $response );
		echo $resp->Response->ResponseStatusDescription . "\n";
	}
	
	Header ( 'Content-type: text/xml' );
} catch ( Exception $ex ) {
	echo $ex;
}

?>

