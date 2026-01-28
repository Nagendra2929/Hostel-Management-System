<%@ page import="java.util.List"%>
<%@ page import="com.codegnan.dao.RoomDAO"%>
<%@ page import="com.codegnan.model.Room"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
RoomDAO roomDAO = new RoomDAO();
List<Room> rooms = roomDAO.getAllRooms();
%>
<!DOCTYPE html>
<html>
<head>
<title>All Rooms</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1500&q=80');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.room-table {
	background-color: rgba(255, 255, 255, 0.95);
	padding: 30px;
	border-radius: 15px;
	margin-top: 60px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
}

.top-right {
	position: absolute;
	top: 20px;
	right: 30px;
}
</style>
</head>
<body>

	<!-- ✅ Logout Button -->
	<div class="top-right">
		<a href="LogoutServlet" class="btn btn-danger btn-sm">Logout</a>
	</div>

	<div class="container">
		<div class="room-table">
			<h3 class="text-center mb-4">All Rooms</h3>

			<%
			int availableCount = 0;
			for (Room room : rooms) {
				if ("available".equalsIgnoreCase(room.getStatus())) {
					availableCount++;
				}
			}
			%>
			<p class="text-center text-success font-weight-bold">
				Total Available Rooms Today:
				<%=availableCount%>
			</p>

			<table class="table table-bordered table-hover">
				<thead class="thead-dark">
					<tr>
						<th>ID</th>
						<th>Type</th>
						<th>Price (₹)</th>
						<th>Status</th>
						<th>Date Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Room room : rooms) {
					%>
					<tr>
						<td><%=room.getId()%></td>
						<td><%=room.getType()%></td>
						<td><%=room.getPrice()%></td>
						<td><%=room.getStatus()%></td>
						<td><%=room.getAvailabilityDate()%></td>
						<td><a href="edit-room.jsp?id=<%=room.getId()%>"
							class="btn btn-sm btn-warning">Edit</a> <a
							href="DeleteRoomServlet?id=<%=room.getId()%>"
							class="btn btn-sm btn-danger"
							onclick="return confirm('Are you sure?')">Delete</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<!-- ✅ Back Button -->
			<a href="admin_dashboard.jsp" class="btn btn-secondary mt-3">Back
				to Dashboard</a>
		</div>
	</div>
</body>
</html>