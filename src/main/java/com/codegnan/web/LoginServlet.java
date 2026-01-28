package com.codegnan.web;

import java.io.IOException;

import com.codegnan.dao.CustomerDAO;
import com.codegnan.model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private CustomerDAO customerDAO;

	@Override
	public void init() throws ServletException {
		customerDAO = new CustomerDAO(); // Initialize DAO
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		Customer customer = customerDAO.authenticate(email, password); // Returns null if invalid

		if (customer != null) {
			HttpSession session = request.getSession();
			session.setAttribute("customerName", customer.getName());
			session.setAttribute("customerEmail", customer.getEmail());
			response.sendRedirect("customer_dashboard.jsp");
		} else {
			request.setAttribute("error", "Invalid email or password.");
			request.getRequestDispatcher("customer_login.jsp").forward(request, response);
		}
	}
}