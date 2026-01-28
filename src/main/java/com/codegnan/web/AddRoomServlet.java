package com.codegnan.web;

import java.io.IOException;

import com.codegnan.dao.RoomDAO;
import com.codegnan.model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/AddRoomServlet")
public class AddRoomServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type");
		double price = Double.parseDouble(request.getParameter("price"));
		String status = request.getParameter("status");

		Room room = new Room();
		room.setType(type);
		room.setPrice(price);
		room.setStatus(status);

		RoomDAO dao = new RoomDAO();
		boolean success = dao.insertRoom(room);

		if (success) {
			response.sendRedirect("admin_dashboard.jsp");
		} else {
			request.setAttribute("errorMessage", "Failed to add room.");
			request.getRequestDispatcher("add-room.jsp").forward(request, response);
		}
	}
}