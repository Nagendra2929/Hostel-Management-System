<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Luxury Inn - Hotel Management System</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	font-family: 'Segoe UI', sans-serif;
	background:
		url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1400&q=80')
		no-repeat center center fixed;
	background-size: cover;
	color: white;
}

.welcome-section {
	height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: rgba(0, 0, 0, 0.6);
	text-align: center;
}

.btn-custom {
	width: 130px;
	margin: 4px;
	font-size: 0.875rem;
	padding: 6px 12px;
}

.room-section {
	background-color: rgba(0, 0, 0, 0.75);
	border-radius: 15px;
	padding: 30px;
	margin-bottom: 40px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.6);
}

.room-section img {
	border-radius: 10px;
	width: 100%;
	height: 250px;
	object-fit: cover;
}

.room-title {
	color: #ffc107;
}

h2.section-heading {
	margin-top: 60px;
	margin-bottom: 40px;
	text-align: center;
	color: #fff;
	font-weight: bold;
}

footer {
	background-color: rgba(0, 0, 0, 0.6);
	color: white;
	padding: 15px 0;
	text-align: center;
}

.navbar {
	z-index: 10;
}
</style>
</head>
<body>

	<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<a class="navbar-brand font-weight-bold" href="#">Luxury Inn</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end"
			id="navbarNav">
			<div class="navbar-nav">
				<a href="about.jsp" class="btn btn-outline-light btn-custom">About</a>
				<a href="contact.jsp" class="btn btn-outline-light btn-custom">Contact</a>
				<a href="admin_login.jsp" class="btn btn-outline-light btn-custom">Admin
					Login</a> <a href="customer_login.jsp"
					class="btn btn-primary btn-custom">Customer Login</a> <a
					href="customer_register.jsp" class="btn btn-success btn-custom">Register</a>
			</div>
		</div>
	</nav>

	<!-- Full Screen Welcome Section -->
	<div class="welcome-section">
		<h1 class="display-4 font-weight-bold">Welcome to Luxury Inn</h1>
		<p class="lead">A Premium Hotel Booking Experience</p>
	</div>

	<!-- Our Rooms Section -->
	<div class="container mt-5">
		<h2 class="section-heading">Our Room Categories</h2>

		<!-- Single Room -->
		<div class="row room-section">
			<div class="col-md-5">
				<img
					src="https://images.pexels.com/photos/271743/pexels-photo-271743.jpeg"
					alt="Single Room">
			</div>
			<div class="col-md-7">
				<h4 class="room-title">Single Room – ₹1000/night</h4>
				<p>A cozy retreat for solo travelers with essential comfort and
					style.</p>
				<ul>
					<li>Single Bed</li>
					<li>Air Conditioning</li>
					<li>Free Wi‑Fi</li>
					<li>Private Bathroom</li>
				</ul>
			</div>
		</div>

		<!-- Double Room -->
		<div class="row room-section">
			<div class="col-md-5">
				<img
					src="https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg"
					alt="Double Room">
			</div>
			<div class="col-md-7">
				<h4 class="room-title">Double Room – ₹1500/night</h4>
				<p>Perfect for two, with spacious layout and modern amenities.</p>
				<ul>
					<li>Double/Twin Beds</li>
					<li>Smart TV & Mini‑Fridge</li>
					<li>Complimentary Breakfast</li>
					<li>24/7 Support</li>
				</ul>
			</div>
		</div>

		<!-- Deluxe Room -->
		<div class="row room-section">
			<div class="col-md-5">
				<img
					src="https://www.shutterstock.com/image-photo/hotel-room-interior-modern-seaside-600nw-1387008533.jpg"
					alt="Deluxe Room">
			</div>
			<div class="col-md-7">
				<h4 class="room-title">Deluxe Room – ₹2500/night</h4>
				<p>Enjoy refined luxury with king‑size bed and plush
					environment.</p>
				<ul>
					<li>King‑Size Bed</li>
					<li>Balcony View</li>
					<li>Luxury Toiletries</li>
					<li>Coffee & Workspace</li>
				</ul>
			</div>
		</div>

		<!-- Suite -->
		<div class="row room-section">
			<div class="col-md-5">
				<img
					src="https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg"
					alt="Suite">
			</div>
			<div class="col-md-7">
				<h4 class="room-title">Suite – ₹4000/night</h4>
				<p>Indulge in grandeur with separate bedroom, living area &
					premium service.</p>
				<ul>
					<li>Separate Bedroom & Lounge</li>
					<li>Jacuzzi</li>
					<li>Butler Service</li>
					<li>Complimentary Wine</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer> &copy; 2025 Codegnan - Hotel Management
		System </footer>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>