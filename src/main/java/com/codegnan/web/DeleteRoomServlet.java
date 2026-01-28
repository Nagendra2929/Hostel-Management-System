package com.codegnan.web;

import java.io.IOException;

import com.codegnan.dao.RoomDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/DeleteRoomServlet")
public class DeleteRoomServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));

		RoomDAO dao = new RoomDAO();
		boolean success = dao.deleteRoom(id);

		if (success) {
			response.sendRedirect("admin_dashboard.jsp");
		} else {
			request.setAttribute("errorMessage", "Failed to delete room.");
			request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
		}
	}
}