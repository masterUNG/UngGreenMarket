<?php
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
				
		$OrderDateTime = $_GET['OrderDateTime'];
		$idUser = $_GET['idUser'];
		$NameUser = $_GET['NameUser'];
		$idShop = $_GET['idShop'];
		$NameShop = $_GET['NameShop'];
		$idProduct = $_GET['idProduct'];
		$NameProduct = $_GET['NameProduct'];
		$Price = $_GET['Price'];
		$Amount = $_GET['Amount'];
		$Sum = $_GET['Sum'];
		

							
		$sql = "INSERT INTO `orderTABLE`(`id`, `OrderDateTime`, `idUser`, `NameUser`, `idShop`, `NameShop`, `idProduct`, `NameProduct`, `Price`, `Amount`, `Sum`, `Status`) VALUES (Null,'$OrderDateTime','$idUser','$NameUser','$idShop','$NameShop','$idProduct','$NameProduct','$Price','$Amount','$Sum','Order')";

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