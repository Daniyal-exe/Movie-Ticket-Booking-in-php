<?php
require_once('tcpdf/tcpdf.php');
include "./db.php";
include "./authenticate.php";

if (!$user || !isset($_GET['id'])) {
    header("location: booking_movie.php");
    exit;
}

$reservation_id = $_GET['id'];
$user_id = $user['id'];

// Fetch reservation details
$query = "
    SELECT 
        r.id,
        r.play_slot,
        r.payment_status,
        r.created_at,
        GROUP_CONCAT(CONCAT(s.row, s.number)) AS seats,
        m.name AS movie_name,
        c.name AS cinema_name,
        c.address AS cinema_address,
        u.name AS user_name,
        sc.price_per_seat
    FROM reservations r
    INNER JOIN movies m ON r.movie_id = m.id
    INNER JOIN cinemas c ON r.cinema_id = c.id
    INNER JOIN users u ON r.user_id = u.id
    INNER JOIN seats_reserved sr ON r.id = sr.reservation_id
    INNER JOIN seats s ON sr.seat_id = s.id
    INNER JOIN schedules sc ON (r.movie_id = sc.movie_id AND r.cinema_id = sc.cinema_id)
    WHERE r.id = ? AND r.user_id = ?
    GROUP BY r.id
";

$stmt = $conn->prepare($query);
$stmt->bind_param("ii", $reservation_id, $user_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    header("location: booking_movie.php?error=Ticket not found");
    exit;
}

$ticket = $result->fetch_object();

// Create new PDF document
$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

// Set document information
$pdf->SetCreator('Movie Booking System');
$pdf->SetAuthor('Cinema');
$pdf->SetTitle('Movie Ticket - ' . $ticket->movie_name);

// Remove default header/footer
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);

// Add a page
$pdf->AddPage();

// Set font
$pdf->SetFont('helvetica', '', 12);

// Create ticket content
$html = '
<h1 style="text-align: center; color: #333;">Movie Ticket</h1>
<hr>
<table cellpadding="5">
    <tr>
        <td><strong>Booking ID:</strong></td>
        <td>' . $ticket->id . '</td>
    </tr>
    <tr>
        <td><strong>Movie:</strong></td>
        <td>' . $ticket->movie_name . '</td>
    </tr>
    <tr>
        <td><strong>Cinema:</strong></td>
        <td>' . $ticket->cinema_name . '</td>
    </tr>
    <tr>
        <td><strong>Address:</strong></td>
        <td>' . $ticket->cinema_address . '</td>
    </tr>
    <tr>
        <td><strong>Date & Time:</strong></td>
        <td>' . $ticket->play_slot . '</td>
    </tr>
    <tr>
        <td><strong>Seats:</strong></td>
        <td>' . $ticket->seats . '</td>
    </tr>
    <tr>
        <td><strong>Price per Seat:</strong></td>
        <td>Rs. ' . $ticket->price_per_seat . '</td>
    </tr>
    <tr>
        <td><strong>Total Amount:</strong></td>
        <td>Rs. ' . ($ticket->price_per_seat * (substr_count($ticket->seats, ',') + 1)) . '</td>
    </tr>
</table>
<hr>
<p style="text-align: center; font-size: 10px;">Please show this ticket at the cinema counter</p>
<p style="text-align: center; font-size: 10px;">Thank you for choosing our cinema!</p>
';

// Print text using writeHTMLCell()
$pdf->writeHTML($html, true, false, true, false, '');

// Generate QR code with ticket information
$qr_code_data = "ID: {$ticket->id}\nMovie: {$ticket->movie_name}\nDate: {$ticket->play_slot}\nSeats: {$ticket->seats}";
$pdf->write2DBarcode($qr_code_data, 'QRCODE,H', 160, 160, 30, 30);

// Close and output PDF document
$pdf->Output('movie_ticket_' . $ticket->id . '.pdf', 'D');

$stmt->close();
$conn->close();
?> 