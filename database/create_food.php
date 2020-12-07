<?php
	include 'conn.php';

	
if($_SERVER['REQUEST_METHOD'] == 'POST') {
	$response = array();

	$name = mysqli_real_escape_string($conn, $_POST['name']);
	$date = mysqli_real_escape_string($conn, $_POST['date']);

	$sql = "insert into food values (null, '$name',  '$date')";

	$result = mysqli_query($conn, $sql);


	    if($result > 0){
			$response['value'] = 0;
	        $response['message'] = 'Data has Input';

	        $response['value'] = $result['value'];

	        echo json_encode($response);


	    } else{
            $response['value'] = 1;
            $response['message'] = "Input has Failed";
            echo json_encode($response);
        }
}
?>
