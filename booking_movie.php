<?php

// session_start(); // Uncomment this if needed for session data

include "./db.php";
include "./authenticate.php";

// Check if the user is authenticated
if ($user) {
    // Make sure to extract the user_id from the $user array/object, assuming $user['id'] is the user ID
    $user_id = $user['id'];  // Assuming 'id' is the key for user_id in the $user array
} else {
    // echo "";
    header("location:login.php");
    exit;  // Stop execution if the user is not set
}

// Prepare the SQL query to fetch paid reservations
$query = "
    SELECT 
        reservations.id, 
        payment_status, 
        play_slot, 
        created_at, 
        GROUP_CONCAT(seats.row, seats.number) AS seat_name, 
        users.name AS user_name, 
        cinemas.name AS cinema_name, 
        movies.name AS movie_name 
    FROM 
        reservations
    INNER JOIN movies ON reservations.movie_id = movies.id  
    INNER JOIN cinemas ON reservations.cinema_id = cinemas.id 
    INNER JOIN users ON reservations.user_id = users.id
    INNER JOIN seats_reserved ON reservations.id = seats_reserved.reservation_id 
    INNER JOIN seats ON seats_reserved.seat_id = seats.id 
    WHERE 
        reservations.user_id = ? AND payment_status = 1  -- Only show reservations with 'payment_status = 1' (i.e., paid)
    GROUP BY 
        reservations.id, 
        payment_status, 
        play_slot, 
        created_at,  
        users.name, 
        cinemas.name, 
        movies.name;
";

// Prepare the statement
$stmt = $conn->prepare($query);

// Bind the user_id parameter to the placeholder
$stmt->bind_param("i", $user_id);

// Execute the query
$stmt->execute();

// Get the result
$result = $stmt->get_result();

?>

<!doctype html>
<html lang="en">

<head>
    <title>Your Ticket's</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <!-- Fonts and icons -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    
    <link href="assets/lib/font-awesome-icons/css/all.min.css" rel="stylesheet" />

    <!-- Material Kit CSS -->
    <link href="assets/css/material-dashboard.css?v=2.1.0" rel="stylesheet" />
    <link href="assets/css/custom.css" type="text/css" rel="stylesheet" />
    <link href="assets/css/web.css" type="text/css" rel="stylesheet" />
</head>

<body class="dark-edition">
    <div class="wrapper">
        <div class="sidebar" data-color="primary" data-background-color="black" data-image="./assets/img/sidebar-5.jpg">
            <?php require "./layout/partials/sidebar.php"; ?>
        </div>
        <div class="main-panel">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-transparent navbar-absolute fixed-top">
                <div class="container-fluid">
                    <div class="navbar-wrapper">
                        <button class="navbar-toggler" type="button" data-toggle="collapse"
                            aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="navbar-toggler-icon icon-bar"></span>
                            <span class="navbar-toggler-icon icon-bar"></span>
                            <span class="navbar-toggler-icon icon-bar"></span>
                        </button>

                        <div class="input-group c-input-rounded-wrapper">
                            <!-- <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1"><i class='fa fa-search'></i></span>
                            </div> -->
                            <!-- <input type="text" name="search" id="search" placeholder="Search..." class="c-input-rounded"> -->
                        </div>
                    </div>

                    <div class="d-inline justify-content-end">
                        <ul class="navbar-nav navbar-expand-md">
                            <div class="d-none d-md-none d-sm-none d-lg-flex">
                                <?php
                                if ($user) {
                                    $cartCount = isset($_SESSION["cart"]) ? count(unserialize($_SESSION['cart'])) : 0;
                                    ?>
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="<?php echo $cartCount > 0 ? './cart.php' : 'javascript:void();' ?>">
                                            <span class="rounded-circle-fa-icon ticket-cart">
                                                <i class="fa fa-ticket-alt"></i>
                                                <sup class="badge badge-pill badge-success ticket-count">
                                                    <?= $cartCount ?>
                                                </sup>
                                            </span>
                                        </a>
                                    </li>
                                    <?php
                                }
                                ?>
                                <li class="nav-item">
                                    <?php
                                    if (!$user) {
                                        ?>
                                        <a class="nav-link" href="login.php" title="login">
                                            <span class="rounded-circle-fa-icon">
                                                <i class="fas fa-sign-in-alt"></i></span>
                                        </a>
                                        <?php
                                    } else {
                                        ?>
                                        <a class="nav-link" href="functions/logout.php" title="logout">
                                            <span class="rounded-circle-fa-icon">
                                                <i class="fas fa-sign-out-alt"></i></span>
                                        </a>
                                    <?php }
                                    ?>
                                </li>
                            </div>
                        </ul>
                    </div>
            </nav>
            <!-- End Navbar -->

            <div class="content">
                <div class="container-fluid p-0">
                <?php if (isset($_SESSION['msg'])) { ?>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <?php 
                        echo htmlspecialchars($_SESSION['msg']); 
                        unset($_SESSION['msg']); // Remove the message after displaying
                        ?>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                <?php } ?>

                <?php if (isset($_SESSION['error'])) { ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <?php 
                        echo htmlspecialchars($_SESSION['error']); 
                        unset($_SESSION['error']); // Remove the error after displaying
                        ?>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                <?php } ?>

                    <h1 class="text-capitalize text-white font-weight-bold">Reservation List</h1>
                    <div class="cinema-movies-list">
                        <?php
                        // If no reservations found
                        if ($result->num_rows > 0) {
                            ?>
                            <div class="container-xl m-0">
                                <div class="row mx-0">
                                    <div class="col-12">
                                        <table class="table table-responsive-sm table-bordered">
                                            <thead>
                                                <tr class="border-top border-dark">
                                                    <th>id</th>
                                                    <th>User</th>
                                                    <th>Cinema</th>
                                                    <th>Movie</th>
                                                    <th>Reservation Date/time</th>
                                                    <th>Payment Status</th>
                                                    <th>Seats Reserved</th>
                                                    <th>Created at</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php
                                                // Loop through the results and display them
                                                while ($reservation = $result->fetch_object()) {
                                                    ?>
                                                    <tr>
                                                        <td><?php echo htmlspecialchars($reservation->id); ?></td>
                                                        <td><?php echo htmlspecialchars($reservation->user_name); ?></td>
                                                        <td><?php echo htmlspecialchars($reservation->cinema_name); ?></td>
                                                        <td><?php echo htmlspecialchars($reservation->movie_name); ?></td>
                                                        <td><?php echo date("d-M-Y h:i A", strtotime($reservation->play_slot)); ?></td>
                                                        <td><?php echo $reservation->payment_status ? "Paid" : "Pending"; ?></td>
                                                        <td><?php echo htmlspecialchars($reservation->seat_name); ?></td>
                                                        <td><?php echo date("d-M-Y h:i A", strtotime($reservation->created_at)); ?></td>
                                                        <td>
                                                            <button class="btn btn-success btn-sm mr-2" onclick="window.location.href='generate_ticket.php?id=<?php echo $reservation->id; ?>'">
                                                                <i class="fa fa-download"></i> Download
                                                            </button>
                                                            <button class="btn btn-danger btn-sm" onclick="confirmDelete(<?php echo $reservation->id; ?>)">
                                                                <i class="fa fa-trash"></i> Delete
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <?php
                                                }
                                                ?>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <?php
                        } else {
                            echo "No upcoming reservations found for the logged-in user.";
                        }

                        // Close the statement
                        $stmt->close();
                        ?>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <?php require "./layout/partials/footer.php"; ?>
        </div>
    </div>

    <!-- Core JS Files -->
    <script src="./assets/js/core/jquery.min.js"></script>
    <script src="./assets/js/core/popper.min.js"></script>
    <script src="./assets/js/core/bootstrap-material-design.min.js"></script>
    <script src="./assets/js/material-dashboard.js?v=2.1.0"></script>

    <script>
    function confirmDelete(reservationId) {
        if (confirm('Are you sure you want to delete this ticket?')) {
            window.location.href = `delete_reservation.php?id=${reservationId}`;
        }
    }
    </script>
</body>

</html>

<?php
// Close the database connection
$conn->close();
?>
