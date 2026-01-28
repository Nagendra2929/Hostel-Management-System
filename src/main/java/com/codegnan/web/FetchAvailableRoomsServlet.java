package com.codegnan.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.codegnan.model.Room;
import com.codegnan.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/RoomListServlet")
public class FetchAvailableRoomsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Room> availableRooms = new ArrayList<>();

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM room WHERE is_available = 1");
				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				Room room = new Room();
				room.setId(rs.getInt("room_id"));
				room.setType(rs.getString("type"));
				room.setPrice(rs.getDouble("price"));
				availableRooms.add(room);
			}

			request.setAttribute("availableRooms", availableRooms);
			RequestDispatcher dispatcher = request.getRequestDispatcher("book_room.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("customer_dashboard.jsp");
		}
	}
}
