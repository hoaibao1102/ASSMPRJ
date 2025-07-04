package DAO;



import DTO.UserVerificationDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author MSI PC
 */
public class UserVerificationDAO {

    private final Connection conn;

    public UserVerificationDAO() throws SQLException, ClassNotFoundException {
        this.conn = DBUtils.getConnection(); // dùng kết nối của bạn
    }

    public boolean saveVerificationCode(String email, String code, Timestamp expiredTime) throws SQLException {
        // Kiểm tra xem email đã có chưa
        String checkSql = "SELECT COUNT(*) FROM UserVerification WHERE email = ?";
        try ( PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            try ( ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    // Nếu đã tồn tại → cập nhật
                    String updateSql = "UPDATE UserVerification SET code=?, generatedTime=?, expiredTime=?, attemptCount=0 WHERE email=?";
                    try ( PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setString(1, code);
                        updateStmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                        updateStmt.setTimestamp(3, expiredTime);
                        updateStmt.setString(4, email);
                        return updateStmt.executeUpdate() > 0;
                    }
                } else {
                    // Nếu chưa có → thêm mới
                    String insertSql = "INSERT INTO UserVerification (email, code, generatedTime, expiredTime, attemptCount) VALUES (?, ?, ?, ?, 0)";
                    try ( PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                        insertStmt.setString(1, email);
                        insertStmt.setString(2, code);
                        insertStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                        insertStmt.setTimestamp(4, expiredTime);
                        return insertStmt.executeUpdate() > 0;
                    }
                }
            }
        }
    }

    public UserVerificationDTO findByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM UserVerification WHERE email=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserVerificationDTO(
                            rs.getString("email"),
                            rs.getString("code"),
                            rs.getTimestamp("generatedTime"),
                            rs.getTimestamp("expiredTime"),
                            rs.getInt("attemptCount")
                    );
                }
                return null;
            }
        }
    }

    public boolean incrementAttempt(String email) throws SQLException {
        String sql = "UPDATE UserVerification SET attemptCount = attemptCount + 1 WHERE email=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteByEmail(String email) throws SQLException {
        String sql = "DELETE FROM UserVerification WHERE email=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeUpdate() > 0;
        }
    }
}
