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
				
		$name = $_GET['name'];
		$surname = $_GET['surname'];
		$username = $_GET['username'];
		$password = $_GET['password'];
		$houseno = $_GET['houseno'];
		$villageNo = $_GET['villageNo'];
		$subdistrict = $_GET['subdistrict'];
		$district = $_GET['district'];				
		$province = $_GET['province'];
		$postalcode = $_GET['postalcode'];
		$tel = $_GET['tel'];
		$chooseType = $_GET['chooseType'];
							
							
		$sql = "INSERT INTO `usertabie`(`id`, `chooseType`, `name`, `surname`, `username`, `password`, `houseno`, `villageNo`, `subdistrict`, `district`, `province`, `postalcode`, `tel`, `name1`, `storename`, `address`, `phone`, `urlImage`, `Token`) 

		VALUES (Null,'$chooseType','$name','$surname','$username','$password','$houseno','$villageNo','$subdistrict','$district','$province','$postalcode','$tel','','','','','','')";

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