<?php 
	include_once 'conn.php';

	if($_SERVER['REQUEST_METHOD'] == "POST"){
	    $response = array();
	    $name = $_POST['username'];
	    $password = md5($_POST['password']);
	    
	    $cek = "SELECT * FROM user WHERE username='$name' and password = '$password'";

	    $result = mysqli_fetch_array(mysqli_query($conn, $cek));

	    if(isset($result)){
			$response['value'] = 0;
	        $response['message'] = 'Login Berhasil';

			$response['id'] = $result['id'];
	        $response['username'] = $result['username'];
	        $response['full_name'] = $result['full_name'];
	        $response['gender'] = $result['gender'];
	        $response['email'] = $result['email'];
	        $response['address'] = $result['address'];
	        $response['created_at'] = $result['created_at'];

	        echo json_encode($response);


	    } else{
            $response['value'] = 1;
            $response['message'] = "login gagal ! Periksa Username anda";
            echo json_encode($response);
        }

	    
    }

 ?>
