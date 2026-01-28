<%@ page language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Registration</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1470&q=80');
	background-size: cover;
	background-position: center;
	min-height: 100vh;
	color: white;
}

.register-box {
	background: rgba(0, 0, 0, 0.7);
	margin-top: 5%;
	padding: 30px;
	border-radius: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-6 register-box">
				<h3>Register as Customer</h3>
				<%
				if (request.getAttribute("error") != null) {
				%>
				<div class="alert alert-danger"><%=request.getAttribute("error")%></div>
				<%
				} else if (request.getAttribute("message") != null) {
				%>
				<div class="alert alert-success"><%=request.getAttribute("message")%></div>
				<%
				}
				%>
				<form action="RegisterCustomerServlet" method="post">
					<div class="form-group">
						<input type="text" name="name" class="form-control"
							placeholder="Full Name" required />
					</div>
					<div class="form-group">
						<input type="email" name="email" class="form-control"
							placeholder="Email" required />
					</div>
					<div class="form-group">
						<input type="text" name="phone" class="form-control"
							placeholder="Phone Number" required />
					</div>
					<div class="form-group">
						<input type="password" name="password" class="form-control"
							placeholder="Password" required />
					</div>
					<button type="submit" class="btn btn-success btn-block">Register</button>
					<a href="index.jsp" class="btn btn-light btn-block">Back</a>
				</form>
			</div>
		</div>
	</div>
</body>
</html>