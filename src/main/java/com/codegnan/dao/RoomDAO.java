package com.codegnan.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.codegnan.model.Room;

public class RoomDAO {
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel_db";
	private static final String JDBC_USER = "root";
	private static final String JDBC_PASS = "Nagendra@9";

	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
	}

	// Get all rooms
	public List<Room> getAllRooms() {
		List<Room> rooms = new ArrayList<>();
		String sql = "SELECT * FROM rooms";
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Room room = extractRoomFromResultSet(rs);
				rooms.add(room);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rooms;
	}

	// Get available rooms
	public List<Room> getAvailableRooms() {
		List<Room> rooms = new ArrayList<>();
		String sql = "SELECT * FROM rooms WHERE status = 'available'";
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Room room = extractRoomFromResultSet(rs);
				rooms.add(room);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rooms;
	}

	// Get booked rooms
	public List<Room> getBookedRooms() {
		List<Room> rooms = new ArrayList<>();
		String sql = "SELECT * FROM rooms WHERE status = 'booked'";
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Room room = extractRoomFromResultSet(rs);
				rooms.add(room);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rooms;
	}

	// Count available rooms
	public int getAvailableRoomCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM rooms WHERE status = 'available'";
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	// Get room by ID
	public Room getRoomById(int id) {
		Room room = null;
		try (Connection conn = getConnection();
				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM rooms WHERE id = ?")) {

			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				room = extractRoomFromResultSet(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return room;
	}

	// Insert room
	public boolean insertRoom(Room room) {
		String sql = "INSERT INTO rooms (type, price, status, booking_status_date, from_date, to_date) VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, room.getType());
			ps.setDouble(2, room.getPrice());
			ps.setString(3, room.getStatus());
			ps.setDate(4, room.getAvailabilityDate());
			ps.setDate(5, room.getFromDate());
			ps.setDate(6, room.getToDate());
			ps.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Update room
	public boolean updateRoom(Room room) {
		String sql = "UPDATE rooms SET type = ?, price = ?, status = ?, booking_status_date = ?, from_date = ?, to_date = ? WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, room.getType());
			ps.setDouble(2, room.getPrice());
			ps.setString(3, room.getStatus());
			ps.setDate(4, room.getBookingStatusDate());
			ps.setDate(5, room.getFromDate());
			ps.setDate(6, room.getToDate());
			ps.setInt(7, room.getId());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Update only status and booking date
	public boolean updateRoomStatusAndDate(Room room) {
		String sql = "UPDATE rooms SET status = ?, booking_status_date = ? WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, room.getStatus());
			stmt.setDate(2, room.getAvailabilityDate());
			stmt.setInt(3, room.getId());
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Update from and to dates (used in manage_bookings.jsp)
	public boolean updateBookingDates(int roomId, Date fromDate, Date toDate) {
		String sql = "UPDATE rooms SET from_date = ?, to_date = ? WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDate(1, fromDate);
			ps.setDate(2, toDate);
			ps.setInt(3, roomId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Delete room
	public boolean deleteRoom(int id) {
		String sql = "DELETE FROM rooms WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			ps.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Utility: map ResultSet to Room
	private Room extractRoomFromResultSet(ResultSet rs) throws SQLException {
		Room room = new Room();
		room.setId(rs.getInt("id"));
		room.setType(rs.getString("type"));
		room.setPrice(rs.getDouble("price"));
		room.setStatus(rs.getString("status"));
		room.setAvailabilityDate(rs.getDate("booking_status_date"));
		room.setFromDate(rs.getDate("from_date"));
		room.setToDate(rs.getDate("to_date"));
		return room;
	}

	// ✅ Add this in RoomDAO.java (if not already there)
	public boolean updateRoomDates(Room room) {
		String sql = "UPDATE rooms SET from_date = ?, to_date = ? WHERE id = ?";
		try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setDate(1, room.getFromDate());
			stmt.setDate(2, room.getToDate());
			stmt.setInt(3, room.getId());

			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}