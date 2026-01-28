package com.codegnan.web;

import java.io.IOException;

import com.codegnan.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int bookingId = Integer.parseInt(request.getParameter("bookingId"));
		int roomId = Integer.parseInt(request.getParameter("roomId"));

		BookingDAO dao = new BookingDAO();
		boolean deleted = dao.deleteBooking(bookingId, roomId);

		if (deleted) {
			response.sendRedirect("manage_bookings.jsp");
		} else {
			request.setAttribute("errorMessage", "Deletion failed.");
			request.getRequestDispatcher("manage_all_bookings.jsp").forward(request, response);
		}
	}
}