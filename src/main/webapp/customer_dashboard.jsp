<%@ page language="java" session="true"%>
<%
String customerName = (String) session.getAttribute("customerName");
if (customerName == null) {
	response.sendRedirect("customer_login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Dashboard</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<style>
body {
	background-image:
		url('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1470&q=80');
	background-size: cover;
	background-position: center;
	min-height: 100vh;
	color: white;
}

.dashboard-box {
	background: rgba(0, 0, 0, 0.7);
	margin-top: 10%;
	padding: 30px;
	border-radius: 10px;
}
</style>
</head>
<body>
	<div class="container text-center">
		<div class="row justify-content-center">
			<div class="col-md-6 dashboard-box">
				<h2>
					Welcome,
					<%=customerName%></h2>
				<p>Book your hotel rooms easily from here.</p>
				<a href="booking.jsp" class="btn btn-outline-light btn-block">Book
					a Room</a> <a href="LogoutServlet"
					class="btn btn-danger btn-block mt-3">Logout</a>
			</div>
		</div>
	</div>
</body>
</html>