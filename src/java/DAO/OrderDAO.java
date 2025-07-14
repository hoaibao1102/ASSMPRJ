/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.OrderDTO;
import DTO.StartDateDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
public class OrderDAO implements IDAO<OrderDTO, String> {

    @Override
    public boolean create(OrderDTO entity) {
        String sql = "INSERT INTO Orders (idBooking, idUser, idTourTicket, BookingDate, NumberTicket, TotalPrice, Status, Note, startDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getIdBooking());
            ps.setInt(2, entity.getIdUser());
            ps.setString(3, entity.getIdTour());
            ps.setString(4, entity.getBookingDate());
            ps.setInt(5, entity.getNumberTicket());
            ps.setDouble(6, entity.getTotalPrice());
            ps.setInt(7, entity.getStatus());
            ps.setString(8, entity.getNote());
            ps.setDate(9, entity.getStartDate());

            int n = ps.executeUpdate();
            return n > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    @Override
    public List<OrderDTO> readAll() {
        return null;
    }

    @Override
    public OrderDTO readbyID(String id) {
        String sql = "SELECT * FROM Orders Where idBooking = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                OrderDTO newT = new OrderDTO(rs.getInt("idUser"),
                        rs.getString("idTourTicket"),
                        rs.getString("BookingDate"),
                        rs.getInt("NumberTicket"),
                        rs.getDouble("TotalPrice"),
                        rs.getInt("Status"),
                        rs.getString("idBooking"),
                        rs.getString("Note"),
                        rs.getDate("startDate"));
                return newT;
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    @Override
    public boolean update(OrderDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<OrderDTO> search(String searchTerm) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders Where idUser = ?  ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, searchTerm);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDTO newT = new OrderDTO(rs.getInt("idUser"),
                        rs.getString("idTourTicket"),
                        rs.getString("BookingDate"),
                        rs.getInt("NumberTicket"),
                        rs.getDouble("TotalPrice"),
                        rs.getInt("Status"),
                        rs.getString("idBooking"),
                        rs.getString("Note"),
                        rs.getDate("startDate"));
                list.add(newT);
            }
            return list;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public String generateBookingId(String idTour) {
        String prefix = idTour + "B"; // Ví dụ: NT001B
        String sql = "SELECT TOP 1 idBooking FROM Orders WHERE idBooking LIKE ? ORDER BY idBooking DESC";

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, idTour + "%");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String lastId = rs.getString("idBooking"); // VD: NT001B03
                String numberPart = lastId.substring(prefix.length()); // "03"
                int nextNumber = Integer.parseInt(numberPart) + 1;
                return String.format("%s%02d", prefix, nextNumber); // NT001B04
            } else {
                return prefix + "01"; // NT001B01 nếu chưa có booking nào

            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderDAO.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean updateStatus(String idBooking) {
        String sql = "UPDATE dbo.Orders SET Status = 1 WHERE idBooking = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, idBooking);
            int n = ps.executeUpdate();
            return n > 0;

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(OrderDAO.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

   

    public List<OrderDTO> getAllOrdersByUser(int userId) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM Orders Where idUser = ?  ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDTO newT = new OrderDTO(rs.getInt("idUser"),
                        rs.getString("idTourTicket"),
                        rs.getString("BookingDate"),
                        rs.getInt("NumberTicket"),
                        rs.getDouble("TotalPrice"),
                        rs.getInt("Status"),
                        rs.getString("idBooking"),
                        rs.getString("Note"),
                        rs.getDate("startDate"));
                list.add(newT);
            }
            return list;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
