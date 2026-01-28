package com.codegnan.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.codegnan.dao.BookingDAO;
import com.codegnan.model.Booking;
import com.codegnan.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/BookRoomFormServlet")
public class BookingServlet extends HttpServlet {

	private BookingDAO bookingDAO;

	@Override
	public void init() throws ServletException {
		bookingDAO = new BookingDAO();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false); // Do not create a new session
		if (session == null || session.getAttribute("customerName") == null
				|| session.getAttribute("customerEmail") == null) {
			response.sendRedirect("customer_login.jsp");
			return;
		}

		String customerName = (String) session.getAttribute("customerName");
		String customerEmail = (String) session.getAttribute("customerEmail");
		String roomNumberStr = request.getParameter("roomNumber");

		if (roomNumberStr == null || roomNumberStr.trim().isEmpty()) {
			request.setAttribute("error", "Please select a room.");
			request.getRequestDispatcher("booking.jsp").forward(request, response);
			return;
		}

		int roomNumber;
		try {
			roomNumber = Integer.parseInt(roomNumberStr);
		} catch (NumberFormatException e) {
			request.setAttribute("error", "Invalid room number.");
			request.getRequestDispatcher("booking.jsp").forward(request, response);
			return;
		}

		// Check if room is available
		boolean isAvailable = false;
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement("SELECT is_available FROM room WHERE room_id = ?")) {

			stmt.setInt(1, roomNumber);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				isAvailable = rs.getBoolean("is_available");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", "Database error.");
			request.getRequestDispatcher("booking.jsp").forward(request, response);
			return;
		}

		if (!isAvailable) {
			request.setAttribute("error", "Selected room is not available.");
			request.getRequestDispatcher("booking.jsp").forward(request, response);
			return;
		}

		// Save booking
		Booking booking = new Booking(customerName, customerEmail, roomNumber, "Pending");
		bookingDAO.insertBooking(booking);

		// Mark room as unavailable
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement("UPDATE room SET is_available = 0 WHERE room_id = ?")) {
			stmt.setInt(1, roomNumber);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// Forward to invoice.jsp
		request.setAttribute("booking", booking);
		request.getRequestDispatcher("invoice.jsp").forward(request, response);
	}
}
