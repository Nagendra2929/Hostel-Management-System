<%@ page import="com.codegnan.dao.RoomDAO"%>
<%@ page import="com.codegnan.model.Room"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String idParam = request.getParameter("id");
if (idParam == null || idParam.isEmpty()) {
	response.sendRedirect("view_rooms.jsp");
	return;
}

int roomId = Integer.parseInt(idParam);
RoomDAO dao = new RoomDAO();
Room room = dao.getRoomById(roomId);
if (room == null) {
	response.sendRedirect("view_rooms.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Room</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=1500&q=80');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.edit-box {
	background: rgba(255, 255, 255, 0.96);
	padding: 30px;
	margin-top: 80px;
	border-radius: 15px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
}
</style>
</head>
<body>
	<div class="container edit-box col-md-6 offset-md-3">
		<h2 class="text-center mb-4">Edit Room</h2>
		<form action="UpdateRoomServlet" method="post">
			<input type="hidden" name="id" value="<%=room.getId()%>">

			<div class="form-group">
				<label>Room Type</label> <input type="text" name="type"
					class="form-control" value="<%=room.getType()%>" required>
			</div>

			<div class="form-group">
				<label>Price (Rs)</label> <input type="number" name="price"
					class="form-control" value="<%=room.getPrice()%>" required>
			</div>

			<div class="form-group">
				<label>Status</label> <select name="status" class="form-control">
					<option value="available"
						<%=room.getStatus().equals("available") ? "selected" : ""%>>Available</option>
					<option value="booked"
						<%=room.getStatus().equals("booked") ? "selected" : ""%>>Booked</option>
				</select>
			</div>

			<div class="form-group">
				<label>Booking Status Date</label> <input type="date"
					name="bookingStatusDate" class="form-control"
					value="<%=room.getBookingStatusDate() != null ? room.getBookingStatusDate().toString() : ""%>">
			</div>

			<button type="submit" class="btn btn-success">Update Room</button>
			<a href="view_rooms.jsp" class="btn btn-secondary">Cancel</a>
		</form>
	</div>
</body>
</html>