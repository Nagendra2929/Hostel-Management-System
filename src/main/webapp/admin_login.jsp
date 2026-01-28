<%@ page language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1470&q=80');
	background-size: cover;
	background-repeat: no-repeat;
	background-attachment: fixed;
	font-family: 'Segoe UI', sans-serif;
}

.login-box {
	margin-top: 12%;
	background: rgba(255, 255, 255, 0.92);
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 0 25px rgba(0, 0, 0, 0.3);
}

.login-box h3 {
	margin-bottom: 25px;
	color: #333;
}

.form-control {
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.btn-primary {
	background-color: #007bff;
	border: none;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-light {
	background-color: #f8f9fa;
	border: 1px solid #ccc;
}

.alert {
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="container text-center">
		<div class="row justify-content-center">
			<div class="col-md-4 login-box">
				<h3>Admin Login</h3>
				<%
				if (request.getAttribute("error") != null) {
				%>
				<div class="alert alert-danger">
					<%=request.getAttribute("error")%>
				</div>
				<%
				}
				%>
				<form action="AdminLoginServlet" method="post">
					<div class="form-group">
						<input type="text" name="username" class="form-control"
							placeholder="Username" required />
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