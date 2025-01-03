<?php
include "./db.php";
include "./authenticate.php";

// Make sure session is started
session_start();

// Check if user is logged in
if (!$user) {
    header("location:login.php");
    exit;
}

if (isset($_GET['id'])) {
    $reservation_id = $_GET['id'];
    $user_id = $user['id'];

    // First verify that this reservation belongs to the logged-in user
    $verify_query = "SELECT id FROM reservations WHERE id = ? AND user_id = ?";
    $stmt = $conn->prepare($verify_query);
    $stmt->bind_param("ii", $reservation_id, $user_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // The reservation exists and belongs to the user
        // Due to CASCADE delete in database, deleting from reservations will automatically
        // delete related records from seats_reserved table
        $delete_query = "DELETE FROM reservations WHERE id = ? AND user_id = ?";
        $stmt = $conn->prepare($delete_query);
        $stmt->bind_param("ii", $reservation_id, $user_id);
        
        if ($stmt->execute()) {
            $_SESSION['msg'] = "Reservation deleted successfully. Your refund will be processed within 24 hours.";
            header("location: booking_movie.php");
            exit;
        } else {
            $_SESSION['error'] = "Failed to delete reservation";
            header("location: booking_movie.php");
            exit;
        }
    } else {
        header("location: booking_movie.php?error=Invalid reservation");
    }
    $stmt->close();
} else {
    header("location: booking_movie.php?error=Invalid request");
}

$conn->close();
?> 