package com.codegnan.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.codegnan.util.DBConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/RegisterCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try (Connection conn = DBConnection.getConnection()) {
			String sql = "INSERT INTO customers (name, email, password) VALUES (?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, email);
			stmt.setString(3, password);

			int rowsInserted = stmt.executeUpdate();
			if (rowsInserted > 0) {
				request.setAttribute("message", "Registration successful. Please login.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("customer_login.jsp");
				dispatcher.forward(request, response);
			} else {
				request.setAttribute("error", "Registration failed.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("customer_register.jsp");
				dispatcher.forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", "Error: " + e.getMessage());
			RequestDispatcher dispatcher = request.getRequestDispatcher("customer_register.jsp");
			dispatcher.forward(request, response);
		}
	}
}
