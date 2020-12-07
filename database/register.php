<?php 
	include 'conn.php';


    if($_SERVER['REQUEST_METHOD'] == "POST"){
	    $response = array();

	    $username = mysqli_real_escape_string($conn, $_POST['username']);
	    $fullName = mysqli_real_escape_string($conn, $_POST['full_name']);
	    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
	    $email = mysqli_real_escape_string($conn, $_POST['email']);
    	$password = md5(mysqli_real_escape_string($conn, $_POST['password']));
	    $address = mysqli_real_escape_string($conn, $_POST['address']);
    	$create = mysqli_real_escape_string($conn, $_POST['created_at']);
	    
	    $res_username = mysqli_fetch_array(mysqli_query($conn, "select username from user where username = '$username'"));
	    $res_email = mysqli_fetch_array(mysqli_query($conn, "select email from user where email = '$email'"));

	    if(isset($res_username)) {
	    	$response['value'] = 2;
	    	$response['message']= 'Username is already taken';
	    	echo json_encode($response);
	    } else if(isset($res_email)) {
			$response['value'] = 3;
	    	$response['message']= 'Email is already taken';
	    	echo json_encode($response);
	    } else {
	    	// INSERT into user (`username`, `full_name`, `gender`, `email`, `password`, `address`, `created_at`) VALUES ('bin', 'adsad', 'asdad', 'asdad', 'asdad', 'asdas', '2020-11-09 16:34:48')
	    	$query = "INSERT INTO user VALUES (NULL, '$username', '$fullName', '$gender', '$email', '$password', '$address', '$create')";
	    	$results = mysqli_query($conn, $query);

		    if($results > 0){
		        $response['value'] = 0;
		        $response['message'] = 'Register Success';
		        echo json_encode($response);

		    } else{
	            $response['value'] = 1;
	            $response['message'] = "Register Failed";
	            echo json_encode($response);
		    }	
	    }
    }

 ?>