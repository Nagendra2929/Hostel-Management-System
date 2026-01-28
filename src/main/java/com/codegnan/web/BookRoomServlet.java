package com.codegnan.web;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import com.codegnan.dao.BookingDAO;
import com.codegnan.dao.CustomerDAO;
import com.codegnan.dao.RoomDAO;
import com.codegnan.model.Booking;
import com.codegnan.model.Room;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/BookRoomServlet")
public class BookRoomServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("customerName");
		String email = request.getParameter("customerEmail");
		int roomId = Integer.parseInt(request.getParameter("roomNumber"));
		int numberOfDays = Integer.parseInt(request.getParameter("numberOfDays"));

		CustomerDAO customerDAO = new CustomerDAO();

		// Insert customer if not already exists
		if (!customerDAO.customerExists(email)) {
			boolean customerInserted = customerDAO.insertCustomer(name, email);
			if (!customerInserted) {
				request.setAttribute("errorMessage", "Customer insertion failed.");
				RequestDispatcher rd = request.getRequestDispatcher("booking.jsp");
				rd.forward(request, response);
				return;
			}
		}

		// Fetch room details (type and price)
		RoomDAO roomDAO = new RoomDAO();
		Room room = roomDAO.getRoomById(roomId);
		if (room == null) {
			request.setAttribute("errorMessage", "Room not found.");
			RequestDispatcher rd = request.getRequestDispatcher("booking.jsp");
			rd.forward(request, response);
			return;
		}

		// Calculate booking dates
		LocalDate now = LocalDate.now();
		LocalDate to = now.plusDays(numberOfDays);
		Date fromDate = Date.valueOf(now);
		Date toDate = Date.valueOf(to);

		// Prepare booking
		Booking booking = new Booking();
		booking.setCustomerName(name);
		booking.setCustomerEmail(email);
		booking.setRoomNumber(roomId);
		booking.setRoomType(room.getType());
		booking.setPrice(room.getPrice());
		booking.setFromDate(fromDate);
		booking.setToDate(toDate);
		booking.setStatus("booked");

		BookingDAO bookingDAO = new BookingDAO();
		boolean bookingCompleted = bookingDAO.bookRoomTransactionally(booking);

		if (bookingCompleted) {
			request.setAttribute("booking", booking);
			RequestDispatcher rd = request.getRequestDispatcher("invoice.jsp");
			rd.forward(request, response);
		} else {
			request.setAttribute("errorMessage", "Booking failed. Room might have been already booked.");
			RequestDispatcher rd = request.getRequestDispatcher("booking.jsp");
			rd.forward(request, response);
		}
	}
}