<%@ page language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Login</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.pexels.com/photos/261395/pexels-photo-261395.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260');
	background-size: cover;
	background-position: center;
	height: 100vh;
	color: white;
	font-family: 'Segoe UI', sans-serif;
}

.login-box {
	margin-top: 10%;
	background: rgba(0, 0, 0, 0.7);
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(255, 255, 255, 0.2);
}

h3 {
	margin-bottom: 20px;
	color: #ffc107;
}
</style>
</head>
<body>
	<div class="container text-center">
		<div class="row justify-content-center">
			<div class="col-md-4 login-box">
				<h3>Customer Login</h3>
				<%
				if (request.getAttribute("error") != null) {
				%>
				<div class="alert alert-danger">
					<%=request.getAttribute("error")%>
				</div>
				<%
				}
				%>
				<form action="CustomerLoginServlet" method="post">
					<div class="form-group">
						<input type="email" name="email" class="form-control"
							placeholder="Email" required />
					</div>
					<div class="form-group">
						<input type="password" name="password" class="form-control"
							placeholder="Password" required />
					</div>
					<button type="submit" class="btn btn-primary btn-block">Login</button>
					<a href="index.jsp" class="btn btn-light btn-block">Back</a>
				</form>
			</div>
		</div>
	</div>
</body>
</html>