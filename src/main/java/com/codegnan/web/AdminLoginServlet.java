package com.codegnan.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.codegnan.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		try (Connection conn = DBConnection.getConnection()) {
			String sql = "SELECT * FROM admin WHERE username=? AND password=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				HttpSession session = request.getSession();
				session.setAttribute("adminUsername", username);
				response.sendRedirect("admin_dashboard.jsp"); // Make sure this file exists in WebContent
			} else {
				request.setAttribute("error", "Invalid admin credentials.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("admin_login.jsp");
				dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Server error occurred.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("admin_login.jsp");
			dispatcher.forward(request, response);
		}
	}
}
