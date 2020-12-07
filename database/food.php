<?php 

	include_once 'conn.php';

	$data = array();
    $query = mysqli_query($conn, 'SELECT * FROM food');
	while ($row = mysqli_fetch_assoc($query)) {
		$data[] = $row;
	}

	echo json_encode($data);

 ?>