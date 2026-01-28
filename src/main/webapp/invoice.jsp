<%@ page import="com.codegnan.model.Booking"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.temporal.ChronoUnit"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
Booking booking = (Booking) request.getAttribute("booking");
if (booking == null) {
%>
<h3>No booking information found!</h3>
<%
return;
}

LocalDate fromDate = booking.getFromDate().toLocalDate();
LocalDate toDate = booking.getToDate().toLocalDate();
long totalDays = ChronoUnit.DAYS.between(fromDate, toDate);
if (totalDays == 0)
totalDays = 1; // Minimum 1 day charge
double totalAmount = totalDays * booking.getPrice(); // price per day
%>

<!DOCTYPE html>
<html>
<head>
<title>Booking Invoice</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1560347876-aeef00ee58a1?auto=format&fit=crop&w=1500&q=80');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.invoice-box {
	background: rgba(255, 255, 255, 0.97);
	padding: 30px;
	margin-top: 60px;
	border-radius: 15px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
}

h2 {
	font-weight: bold;
}

.table th {
	width: 30%;
}

.top-right {
	position: absolute;
	top: 20px;
	right: 30px;
}
</style>
</head>
<body>

	<div class="top-right">
		<a href="LogoutServlet" class="btn btn-danger btn-sm">Logout</a>
	</div>

	<div class="container invoice-box col-md-8 offset-md-2">
		<h2 class="text-center mb-4">Booking Invoice</h2>
		<table class="table table-bordered">
			<tr>
				<th>Customer Name</th>
				<td><%=booking.getCustomerName()%></td>
			</tr>
			<tr>
				<th>Email</th>
				<td><%=booking.getCustomerEmail()%></td>
			</tr>
			<tr>
				<th>Room Number</th>
				<td><%=booking.getRoomNumber()%></td>
			</tr>
			<tr>
				<th>Room Type</th>
				<td><%=booking.getRoomType()%></td>
			</tr>
			<tr>
				<th>From Date</th>
				<td><%=booking.getFromDate()%></td>
			</tr>
			<tr>
				<th>To Date</th>
				<td><%=booking.getToDate()%></td>
			</tr>
			<tr>
				<th>Days Booked</th>
				<td><%=totalDays%> day(s)</td>
			</tr>
			<tr>
				<th>Price per Day (₹)</th>
				<td><%=booking.getPrice()%></td>
			</tr>
			<tr>
				<th>Total Amount (₹)</th>
				<td><strong><%=totalAmount%></strong></td>
			</tr>
			<tr>
				<th>Status</th>
				<td><%=booking.getStatus()%></td>
			</tr>
		</table>
		<div class="text-center">
			<a href="booking.jsp" class="btn btn-primary">Book Another Room</a>
		</div>
	</div>
</body>
</html>