package com.codegnan.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.codegnan.model.Booking;

public class BookingDAO {

	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel_db";
	private static final String JDBC_USER = "root";
	private static final String JDBC_PASS="Nagendra@9";

	// Legacy insertBooking method (not used now)
	public boolean insertBooking(Booking booking) {
		String sql = "INSERT INTO booking (customer_name, customer_email, room_number, status) VALUES (?, ?, ?, ?)";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, booking.getCustomerName());
			ps.setString(2, booking.getCustomerEmail());
			ps.setInt(3, booking.getRoomNumber());
			ps.setString(4, booking.getStatus());

			int rowsInserted = ps.executeUpdate();
			return rowsInserted > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Legacy update method (not used now)
	public boolean updateRoomStatus(int roomId, String status) {
		String sql = "UPDATE rooms SET status = ? WHERE id = ?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, status);
			ps.setInt(2, roomId);

			int rowsUpdated = ps.executeUpdate();
			return rowsUpdated > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ✅ Final version: Transactional method to insert booking and update room
	// fields including dates
	public boolean bookRoomTransactionally(Booking booking) {
		String selectRoomSQL = "SELECT status FROM rooms WHERE id = ? FOR UPDATE";
		String insertBookingSQL = "INSERT INTO booking (customer_name, customer_email, room_number, status) VALUES (?, ?, ?, ?)";
		String updateRoomSQL = "UPDATE rooms SET status = ?, booking_status_date = ?, from_date = ?, to_date = ? WHERE id = ?";

		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {
			conn.setAutoCommit(false); // Begin transaction

			// Step 1: Check room availability
			try (PreparedStatement selectStmt = conn.prepareStatement(selectRoomSQL)) {
				selectStmt.setInt(1, booking.getRoomNumber());
				ResultSet rs = selectStmt.executeQuery();
				if (!rs.next()) {
					conn.rollback();
					return false;
				}
				String status = rs.getString("status");
				if (!"available".equalsIgnoreCase(status)) {
					conn.rollback();
					return false; // Already booked
				}
			}

			// Step 2: Insert booking
			try (PreparedStatement insertStmt = conn.prepareStatement(insertBookingSQL)) {
				insertStmt.setString(1, booking.getCustomerName());
				insertStmt.setString(2, booking.getCustomerEmail());
				insertStmt.setInt(3, booking.getRoomNumber());
				insertStmt.setString(4, booking.getStatus());

				int bookingInserted = insertStmt.executeUpdate();
				if (bookingInserted == 0) {
					conn.rollback();
					return false;
				}
			}

			// Step 3: Update room info with booking dates
			try (PreparedStatement updateStmt = conn.prepareStatement(updateRoomSQL)) {
				updateStmt.setString(1, "booked");
				updateStmt.setDate(2, booking.getFromDate()); // booking_status_date
				updateStmt.setDate(3, booking.getFromDate());
				updateStmt.setDate(4, booking.getToDate());
				updateStmt.setInt(5, booking.getRoomNumber());

				int roomUpdated = updateStmt.executeUpdate();
				if (roomUpdated == 0) {
					conn.rollback();
					return false;
				}
			}

			conn.commit(); // ✅ All good
			return true;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	public List<Booking> getAllBookings() {
		List<Booking> list = new ArrayList<>();
		String sql = "SELECT * FROM booking";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Booking b = new Booking();
				b.setId(rs.getInt("id"));
				b.setCustomerName(rs.getString("customer_name"));
				b.setCustomerEmail(rs.getString("customer_email"));
				b.setRoomNumber(rs.getInt("room_number"));
				b.setFromDate(rs.getDate("from_date"));
				b.setToDate(rs.getDate("to_date"));
				b.setStatus(rs.getString("status"));
				list.add(b);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean updateBookingDates(int bookingId, Date fromDate, Date toDate) {
		String sql = "UPDATE booking SET from_date = ?, to_date = ? WHERE id = ?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setDate(1, fromDate);
			ps.setDate(2, toDate);
			ps.setInt(3, bookingId);

			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Delete booking by room ID
	public boolean deleteBookingByRoomId(int roomId) {
		String sql = "DELETE FROM booking WHERE room_number = ?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, roomId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Booking> getAllBookingsWithRoomDates() {
		List<Booking> list = new ArrayList<>();
		String sql = "SELECT b.id AS booking_id, b.customer_name, b.customer_email, b.room_number, b.status, "
				+ "r.from_date, r.to_date FROM booking b JOIN rooms r ON b.room_number = r.id";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Booking b = new Booking();
				b.setId(rs.getInt("booking_id"));
				b.setCustomerName(rs.getString("customer_name"));
				b.setCustomerEmail(rs.getString("customer_email"));
				b.setRoomNumber(rs.getInt("room_number"));
				b.setStatus(rs.getString("status"));
				b.setFromDate(rs.getDate("from_date"));
				b.setToDate(rs.getDate("to_date"));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean deleteBooking(int bookingId, int roomId) {
		String deleteSql = "DELETE FROM booking WHERE id = ?";
		String updateRoomSql = "UPDATE rooms SET status = 'available', from_date = NULL, to_date = NULL WHERE id = ?";
		try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {
			conn.setAutoCommit(false);

			try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
					PreparedStatement updateStmt = conn.prepareStatement(updateRoomSql)) {

				deleteStmt.setInt(1, bookingId);
				updateStmt.setInt(1, roomId);

				deleteStmt.executeUpdate();
				updateStmt.executeUpdate();

				conn.commit();
				return true;
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}