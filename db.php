<?php
$host="localhost:3308"; //remove 3308 if you have 3306 connection
$username="root";
$password=""; //add your workbench password if you are using one
$db_name="movie_ticket_booking";
// Create connection
$conn = new mysqli($host, $username, $password, $db_name);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
