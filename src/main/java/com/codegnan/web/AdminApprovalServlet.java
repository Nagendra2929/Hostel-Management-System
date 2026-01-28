package com.codegnan.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;

import com.codegnan.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/AdminApprovalServlet")
public class AdminApprovalServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try (Connection conn = DBConnection.getConnection()) {
			Enumeration<String> paramNames = request.getParameterNames();

			while (paramNames.hasMoreElements()) {
				String param = paramNames.nextElement();

				if (param.startsWith("status_")) {
					int bookingId = Integer.parseInt(param.substring(7));
					String newStatus = request.getParameter(param);

					if (newStatus != null && !newStatus.trim().isEmpty()) {
						// Update booking status
						PreparedStatement updateBookingStmt = conn
								.prepareStatement("UPDATE booking SET status = ? WHERE id = ?");
						updateBookingStmt.setString(1, newStatus);
						updateBookingStmt.setInt(2, bookingId);
						updateBookingStmt.executeUpdate();

						// Fetch room number
						PreparedStatement fetchRoomStmt = conn
								.prepareStatement("SELECT room_number FROM booking WHERE id = ?");
						fetchRoomStmt.setInt(1, bookingId);
						ResultSet rs = fetchRoomStmt.executeQuery();
						if (rs.next()) {
							int roomNumber = rs.getInt("room_number");

							// Update room availability
							PreparedStatement updateRoomStmt = conn
									.prepareStatement("UPDATE room SET is_available = ? WHERE room_id = ?");
							updateRoomStmt.setInt(1, "Available".equalsIgnoreCase(newStatus) ? 1 : 0);
							updateRoomStmt.setInt(2, roomNumber);
							updateRoomStmt.executeUpdate();
						}

						rs.close();
					}
				}
			}

			response.sendRedirect("ViewBookingsServlet");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("admin_dashboard.jsp");
		}
	}
}
