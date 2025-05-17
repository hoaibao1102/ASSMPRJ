/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.UserDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
public class UserDAO implements IDAO<UserDTO, String>{

    @Override
    public boolean create(UserDTO entity) {
        String sql = "INSERT INTO users (full_name, email, phone, password, role) VALUES (?,?,?,?,?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getFullName());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getPhone());
            ps.setString(4, entity.getPassword());
            ps.setString(5, entity.getRole());
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
    public List<UserDTO> readAll() {
        return null;
    }

    @Override
    public UserDTO readbyID(String searchTerm) {
        String sql = "SELECT * FROM users WHERE  email = ? OR phone = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, searchTerm);
            pst.setString(2, searchTerm);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return new UserDTO( 
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role")
                );
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean update(UserDTO entity) {
//        String sql = "UPDATE users set "
//                    + "full_name = ?,"
//                    + "email = ?, "
//                    + "phone = ?, "
//                    + "password = ?, "
//                    + "role = ? "
//                    + "where id = ?";
//        try {
//            Connection conn = DBUtils.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, entity.getFullName());
//            ps.setString(2, entity.getEmail());
//            ps.setString(3, entity.getPhone());
//            ps.setString(4, entity.getPassword());
//            ps.setString(5, entity.getRole());
//            ps.setString(5, entity.getRole());
//            int n = ps.executeUpdate();
//            return n > 0;
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        return false;
    }

    @Override
    public boolean delete(String id) {
//        String sql = "INSERT INTO users (full_name, email, phone, password, role) VALUES (?,?,?,?,?)";
//        try {
//            Connection conn = DBUtils.getConnection();
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, entity.getFullName());
//            ps.setString(2, entity.getEmail());
//            ps.setString(3, entity.getPhone());
//            ps.setString(4, entity.getPassword());
//            ps.setString(5, entity.getRole());
//            int n = ps.executeUpdate();
//            return n > 0;
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
        return false;
    }

    @Override
    public List<UserDTO> search(String searchTerm) {
        return null;
    }
    
    
    public List<UserDTO> searchLogin(String textLogin) {
        return null;
    }

    
}
