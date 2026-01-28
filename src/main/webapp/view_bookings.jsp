<%@ page import="java.util.List"%>
<%@ page import="com.codegnan.dao.BookingDAO"%>
<%@ page import="com.codegnan.model.Booking"%>
<%
BookingDAO bookingDAO = new BookingDAO();
List<Booking> bookings = bookingDAO.getAllBookings();
%>
<!DOCTYPE html>
<html>
<head>
<title>All Bookings</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image: url('images/admin-bg.jpg');
	background-size: cover;
	background-repeat: no-repeat;
}

.booking-container {
	background: rgba(255, 255, 255, 0.97);
	padding: 25px;
	margin-top: 50px;
	border-radius: 15px;
}
</style>
</head>
<body>
	<div class="container booking-container">
		<h2 class="text-center">All Bookings</h2>
		<table class="table table-bordered table-hover">
			<thead class="thead-dark">
				<tr>
					<th>ID</th>
					<th>Customer Name</th>
					<th>Email</th>
					<th>Room Number</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Booking booking : bookings) {
				%>
				<tr>
					<td><%=booking.getId()%></td>
					<td><%=booking.getCustomerName()%></td>
					<td><%=booking.getCustomerEmail()%></td>
					<td><%=booking.getRoomNumber()%></td>
					<td><%=booking.getStatus()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>