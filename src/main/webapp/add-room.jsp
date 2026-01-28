<!DOCTYPE html>
<html>
<head>
<title>Add Room</title>
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

.form-container {
	background-color: rgba(255, 255, 255, 0.95);
	padding: 30px;
	border-radius: 15px;
	margin-top: 60px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
}

h3 {
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container">
		<div class="form-container col-md-6 offset-md-3">
			<h3 class="text-center">Add New Room</h3>
			<form action="AddRoomServlet" method="post">
				<div class="form-group">
					<label>Room Type</label> <select name="type" class="form-control"
						required>
						<option value="Single">Single</option>
						<option value="Double">Double</option>
						<option value="Deluxe">Deluxe</option>
						<option value="Suite">Suite</option>
					</select>
				</div>
				<div class="form-group">
					<label>Room Price (Rs)</label> <input type="number" name="price"
						class="form-control" required>
				</div>
				<div class="form-group">
					<label>Status</label> <select name="status" class="form-control">
						<option value="available">Available</option>
						<option value="booked">Booked</option>
					</select>
				</div>
				<button type="submit" class="btn btn-success btn-block">Add
					Room</button>
				<a href="admin_dashboard.jsp" class="btn btn-secondary btn-block">Cancel</a>
			</form>
		</div>
	</div>
</body>
</html>