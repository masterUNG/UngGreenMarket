<?php

//header('Access-Control-Allow-Origin: *');
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 's602021197', '00978300', "db602021197");
if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}



if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
		
		$idShop = $_GET['idShop'];	
		$NameProduct = $_GET['NameProduct'];
		$PathImage = $_GET['PathImage'];
		$Price = $_GET['Price'];
		$Detail = $_GET['Detail'];
	
							
		$sql = "INSERT INTO `productTABLE`(`id`, `idShop`, `NameProduct`, `PathImage`, `Price`, `Detail`) VALUES (Null,'$idShop','$NameProduct','$PathImage','$Price','$Detail')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Green Market";
   
}
	mysqli_close($link);
?>