package com.codegnan.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.codegnan.model.Booking;
import com.codegnan.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/ViewBookingsServlet")
public class ViewBookingsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("adminUsername") == null) {
			response.sendRedirect("admin_login.jsp");
			return;
		}

		List<Booking> bookings = new ArrayList<>();
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM booking");
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				int bookingId = rs.getInt("id");
				String customerName = rs.getString("customer_name");
				String customerEmail = rs.getString("customer_email");
				int roomNumber = rs.getInt("room_number");
				String status = rs.getString("status");

				bookings.add(new Booking(bookingId, customerName, customerEmail, roomNumber, status));
			}

			request.setAttribute("bookings", bookings);
			RequestDispatcher dispatcher = request.getRequestDispatcher("manage_bookings.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("admin_dashboard.jsp");
		}
	}
}
