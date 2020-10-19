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
			
		$id = $_GET['id'];		
		$name1 = $_GET['name1'];
		$storename = $_GET['storename'];		
		$address = $_GET['address'];
		$phone = $_GET['phone'];		
		$urlImage = $_GET['urlImage'];		
		//$token = $_GET['token'];
							
		$sql = "UPDATE usertabie SET name1 = '$name1', storename = '$storename', address = '$address' , phone = '$phone', urlImage = '$urlImage'WHERE id = '$id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome greenmaket";
   
}

	mysqli_close($link);
?>