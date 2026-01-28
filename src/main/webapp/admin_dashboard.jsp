<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1470&q=80');
	/* Clean desk admin background */
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.dashboard {
	background-color: rgba(255, 255, 255, 0.95);
	padding: 30px;
	border-radius: 15px;
	margin-top: 60px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
}

.btn-custom {
	font-size: 14px;
	padding: 8px 0;
	margin: 6px 0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="dashboard col-md-6 offset-md-3 text-center">
			<h2 class="mb-4">Welcome Admin</h2>
			<a href="view_rooms.jsp" class="btn btn-primary btn-block btn-custom">View
				All Rooms</a> <a href="add-room.jsp"
				class="btn btn-success btn-block btn-custom">Add New Room</a> <a
				href="manage_bookings.jsp" class="btn btn-info btn-block btn-custom">Manage
				Bookings</a>
			<!-- ✅ New Button -->
			<a href="LogoutServlet" class="btn btn-danger btn-block btn-custom">Logout</a>
		</div>
	</div>
</body>
</html>