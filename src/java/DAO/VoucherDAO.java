/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.VoucherDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class VoucherDAO {

    protected final String SELECT_QUERY = "SELECT * FROM Vouchers ";
    protected final String INSERT_QUERY = "INSERT INTO Vouchers (startDate ,discount, numbers, duration, title, status, minimumOrderValue)" +
                                            " VALUES(?, ?, ?, ?, ?, 1, ?)";
    protected final String DELETE_QUERY = "UPDATE Vouchers SET status = 0 WHERE voucherID = ?";
    protected final String UPDATE_QUERY = "UPDATE Vouchers SET status = 1, title = ?, startDate = ?, discount = ?, "
            + " numbers = ?, duration = ?, minimumOrderValue = ?  WHERE voucherID = ?";
    
    public boolean updateVoucher(int voucherID, VoucherDTO vcdto) {
        String sql = UPDATE_QUERY;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, vcdto.getTitle());
            ps.setString(2, vcdto.getStartDate());
            ps.setDouble(3, vcdto.getDiscount());
            ps.setInt(4, vcdto.getNumbers());
            ps.setInt(5, vcdto.getDuration());
            ps.setDouble(6, vcdto.getMinimumOrderValue());
            ps.setInt(7, voucherID);
            int n = ps.executeUpdate();
            return n > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public List<VoucherDTO> getAllVoucher() {
        String sql = SELECT_QUERY;
        List<VoucherDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                VoucherDTO newT = new VoucherDTO(rs.getInt("voucherID"),
                        rs.getString("title"),
                        rs.getString("startDate"),
                        Double.parseDouble(rs.getString("discount")),
                        rs.getInt("numbers"),
                        rs.getInt("duration"),
                        Double.parseDouble(rs.getString("minimumOrderValue")),
                        rs.getInt("status")==1);
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
    
    public List<VoucherDTO> getAllVoucherActive() {
        List<VoucherDTO> list = new ArrayList<>();
        for(VoucherDTO i : getAllVoucher() ){
            if(i.isStatus()){
                list.add(i);
            }
        }
        return list;
    }

    public boolean createNewVoucher(VoucherDTO vcdto) {
        String sql = INSERT_QUERY;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, vcdto.getStartDate());
            ps.setDouble(2, vcdto.getDiscount());
            ps.setInt(3, vcdto.getNumbers());
            ps.setInt(4, vcdto.getDuration());
            ps.setString(5, vcdto.getTitle());
            ps.setDouble(6, vcdto.getMinimumOrderValue());
            int n = ps.executeUpdate();
            return n > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteVoucher(int voucherID) {
        String sql = DELETE_QUERY;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, voucherID);
            int n = ps.executeUpdate();
            return n > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public VoucherDTO getVoucherByID(int voucherID) {
        String sql = SELECT_QUERY + " WHERE voucherID = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, voucherID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                VoucherDTO newV = new VoucherDTO(rs.getInt("voucherID"),
                        rs.getString("title"),
                        rs.getString("startDate"),
                        Double.parseDouble(rs.getString("discount")),
                        rs.getInt("numbers"),
                        rs.getInt("duration"),
                        Double.parseDouble(rs.getString("minimumOrderValue")),
                        rs.getInt("status")==1);
                return newV;
            }
            

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    
    
}
