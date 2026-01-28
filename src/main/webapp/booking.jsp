<%@ page import="java.util.List"%>
<%@ page import="com.codegnan.dao.RoomDAO"%>
<%@ page import="com.codegnan.model.Room"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
RoomDAO roomDAO = new RoomDAO();
List<Room> rooms = roomDAO.getAvailableRooms();
int availableRoomCount = roomDAO.getAvailableRoomCount();

String customerName = (String) session.getAttribute("customerName");
String customerEmail = (String) session.getAttribute("customerEmail");
%>

<!DOCTYPE html>
<html>
<head>
<title>Book a Room</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1500&q=80');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.booking-form {
	background: rgba(255, 255, 255, 0.95);
	padding: 30px;
	border-radius: 15px;
	margin-top: 60px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
	position: relative;
}

h2 {
	font-weight: bold;
}

.top-right {
	position: absolute;
	top: 20px;
	right: 30px;
}

.room-count {
	background-color: #17a2b8;
	color: white;
	padding: 10px 15px;
	border-radius: 30px;
	font-size: 16px;
	font-weight: bold;
	display: inline-block;
	margin-bottom: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
}
</style>
</head>
<body>
	<!-- ✅ Logout Button -->
	<div class="top-right">
		<a href="LogoutServlet" class="btn btn-danger btn-sm">Logout</a>
	</div>

	<div class="container">
		<div class="booking-form col-md-6 offset-md-3">
			<div class="form-title">
				<h2>Book a Room</h2>
				<div class="room-count">
					Available:
					<%=availableRoomCount%></div>
			</div>

			<%
			if (rooms.isEmpty()) {
			%>
			<div class="alert alert-warning text-center">No available rooms
				at the moment. Please check back later.</div>
			<%
			} else {
			%>
			<form action="BookRoomServlet" method="post">
				<div class="form-group">
					<label>Customer Name</label> <input type="text" name="customerName"
						class="form-control"
						value="<%=customerName != null ? customerName : ""%>" required>
				</div>
				<div class="form-group">
					<label>Customer Email</label> <input type="email"
						name="customerEmail" class="form-control"
						value="<%=customerEmail != null ? customerEmail : ""%>" required>
				</div>
				<div class="form-group">
					<label>Select Room</label> <select name="roomNumber"
						class="form-control" required>
						<%
						for (Room room : rooms) {
						%>
						<option value="<%=room.getId()%>">Room
							<%=room.getId()%> -
							<%=room.getType()%> (₹<%=room.getPrice()%>)
						</option>
						<%
						}
						%>
					</select>
				</div>
				<div class="form-group">
					<label>From Date</label> <input type="date" name="fromDate"
						class="form-control" required>
				</div>
				<div class="form-group">
					<label>To Date</label> <input type="date" name="toDate"
						class="form-control" required>
				</div>

				<!-- ✅ Added numberOfDays input -->
				<div class="form-group">
					<label>Number of Days</label> <input type="number"
						name="numberOfDays" class="form-control" min="1" required>
				</div>

				<button type="submit" class="btn btn-success btn-block">Book
					Now</button>
			</form>
			<%
			}
			%>

			<%
			String errorMessage = (String) request.getAttribute("errorMessage");
			if (errorMessage != null) {
			%>
			<div class="alert alert-danger mt-3"><%=errorMessage%></div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>