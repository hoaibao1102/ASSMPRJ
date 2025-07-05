/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.UserDTO;
import UTILS.DBUtils;
import UTILS.PasswordUtils;
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
 * @author MSI PC
 */
public class UserDAO implements IDAO<UserDTO, String> {

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
        String sql = "SELECT * FROM users  ";
        List<UserDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getInt("status") == 1
                );
                list.add(user);
            }
            return list;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public UserDTO readbyID(String searchTerm) {
        String sql = "SELECT * FROM users WHERE id = ? or email = ? OR phone = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            // Ép kiểu id về int nếu có thể, nếu không thì đặt -1 để tránh match
            int idSearch;
            try {
                idSearch = Integer.parseInt(searchTerm);
            } catch (NumberFormatException e) {
                idSearch = -1; // Không match với id nào
            }

            pst.setInt(1, idSearch);           // id = ?
            pst.setString(2, searchTerm);      // email = ?
            pst.setString(3, searchTerm);      // phone = ?

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return new UserDTO(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getInt("status") == 1
                );
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean update(UserDTO entity) {
        String sql = "UPDATE users set "
                + "full_name = ?, "
                + "email = ?, "
                + "phone = ?, "
                + "password = ?, "
                + "role = ? "
                + "where id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getFullName());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getPhone());
            ps.setString(4, entity.getPassword());
            ps.setString(5, entity.getRole());
            ps.setInt(6, entity.getIdUser());
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
    public boolean delete(String id) {
        String sql = "UPDATE users set "
                + "status = 0 "
                + "where id = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

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
    public List<UserDTO> search(String searchTerm) {
        return null;
    }

    public List<UserDTO> searchLogin(String textLogin) {
        return null;
    }

    // Xác thực login để kiểm tra password hiện tại
    public boolean checkLogin(String strId, String rawPwd) throws SQLException {
        String sql = "SELECT password FROM Users WHERE id = ?";
        Connection conn;
        try {
            conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            int id;
            try {
                id = Integer.parseInt(strId);
            } catch (Exception e) {
                id = -1;
            }
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String hash = rs.getString("password");
                return PasswordUtils.checkPassword(rawPwd, hash);  // BCrypt verify
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean phoneExists(String phone, int excludeId) throws SQLException {
        String sql = "SELECT TOP 1 1 FROM Users WHERE phone = ? AND id <> ?";
        Connection conn;
        try {
            conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, phone);
            ps.setInt(2, excludeId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;  // Có user khác đang dùng số này
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;  // Không tồn tại hoặc có lỗi
    }

    public UserDTO readbyEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return new UserDTO(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getInt("status") == 1
                );
            }
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Trong UserDAO.java
    public boolean updatePasswordByEmail(String email, String newPassword) throws SQLException {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, PasswordUtils.hashPassword(newPassword)); // nếu bạn có hàm hash
            ps.setString(2, email);

            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
