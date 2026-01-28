<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Contact Us - Luxury Inn</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1582719478181-2f98c06b08c3?auto=format&fit=crop&w=1400&q=80');
	background-size: cover;
	background-attachment: fixed;
	background-position: center;
	color: white;
}

.overlay {
	background-color: rgba(0, 0, 0, 0.75);
	padding: 60px 30px;
	min-height: 100vh;
}

h1, h4 {
	color: #17a2b8;
}
</style>
</head>
<body>
	<div class="overlay">
		<div class="container">
			<h1 class="text-center mb-4">Contact Luxury Inn</h1>
			<p class="lead text-justify">We're here to help! Reach out to us
				anytime for inquiries, bookings, or feedback.</p>
			<div class="row mt-4">
				<div class="col-md-6">
					<h4>Hotel Contact Info</h4>
					<p>
						📍 123 Paradise Avenue, Central City, India<br> ☎️
						+91-9876543210<br> ✉️ contact@luxuryinn.com
					</p>
				</div>
				<div class="col-md-6">
					<h4>Send Us a Message</h4>
					<form>
						<div class="form-group">
							<label>Your Name</label> <input type="text" class="form-control"
								required>
						</div>
						<div class="form-group">
							<label>Your Email</label> <input type="email"
								class="form-control" required>
						</div>
						<div class="form-group">
							<label>Message</label>
							<textarea class="form-control" rows="4" required></textarea>
						</div>
						<button type="submit" class="btn btn-info">Send</button>
					</form>
				</div>
			</div>
			<div class="mt-4 text-center">
				<a href="index.jsp" class="btn btn-light">Back to Home</a>
			</div>
		</div>
	</div>
</body>
</html>