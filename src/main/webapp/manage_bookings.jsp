<%@ page import="java.util.List"%>
<%@ page import="com.codegnan.dao.BookingDAO"%>
<%@ page import="com.codegnan.model.Booking"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
BookingDAO bookingDAO = new BookingDAO();
List<Booking> bookings = bookingDAO.getAllBookingsWithRoomDates();
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage All Bookings</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1521791136064-7986c2920216?auto=format&fit=crop&w=1500&q=80');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.booking-table {
	background-color: rgba(255, 255, 255, 0.96);
	padding: 30px;
	border-radius: 15px;
	margin-top: 50px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
}

.action-buttons {
	display: flex;
	gap: 10px;
}

/* Fallback for Bootstrap 4 (no gap utility) */
.action-buttons>* {
	margin-right: 8px;
}

.action-buttons>*:last-child {
	margin-right: 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="booking-table">
			<h3 class="text-center mb-4">All Customer Bookings</h3>

			<%
			if (bookings.isEmpty()) {
			%>
			<div class="alert alert-info text-center">No bookings
				available.</div>
			<%
			} else {
			%>
			<table class="table table-bordered table-hover">
				<thead class="thead-dark">
					<tr>
						<th>Customer Name</th>
						<th>Email</th>
						<th>Room No</th>
						<th>From Date</th>
						<th>To Date</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Booking b : bookings) {
					%>
					<tr>
						<form action="UpdateBookingServlet" method="post">
							<input type="hidden" name="bookingId" value="<%=b.getId()%>">
							<input type="hidden" name="roomId"
								value="<%=b.getRoomNumber()%>">
							<td><%=b.getCustomerName()%></td>
							<td><%=b.getCustomerEmail()%></td>
							<td><%=b.getRoomNumber()%></td>
							<td><input type="date" name="fromDate" class="form-control"
								value="<%=b.getFromDate() != null ? b.getFromDate().toString() : ""%>"
								required></td>
							<td><input type="date" name="toDate" class="form-control"
								value="<%=b.getToDate() != null ? b.getToDate().toString() : ""%>"
								required></td>
							<td><%=b.getStatus()%></td>
							<td>
								<div class="action-buttons">
									<button type="submit" class="btn btn-sm btn-primary">Update</button>
									<a
										href="DeleteBookingServlet?bookingId=<%=b.getId()%>&roomId=<%=b.getRoomNumber()%>"
										class="btn btn-sm btn-danger"
										onclick="return confirm('Are you sure to delete this booking?')">Delete</a>
								</div>
							</td>
						</form>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			}
			%>

			<div class="text-center mt-3">
				<a href="admin_dashboard.jsp" class="btn btn-secondary">Back to
					Dashboard</a>
			</div>
		</div>
	</div>
</body>
</html>