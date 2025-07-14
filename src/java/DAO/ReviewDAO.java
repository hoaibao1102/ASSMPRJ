/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.ReviewDTO;
import DTO.UserDTO;
import UTILS.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ddhuy
 */
public class ReviewDAO implements IDAO<ReviewDTO, Integer> {

    @Override
    public boolean create(ReviewDTO review) {
        String sql = "INSERT INTO TourReviews (idUser, idTourTicket, rating, comment, isVerified) VALUES (?, ?, ?, ?, ?)";

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, review.getIdUser());
            ps.setString(2, review.getIdTourTicket());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());
            ps.setBoolean(5, review.isVerified());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<ReviewDTO> readAll() {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name FROM TourReviews r JOIN Users u ON r.idUser = u.id ORDER BY r.reviewDate DESC";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO(
                        rs.getInt("idReview"),
                        rs.getInt("idUser"),
                        rs.getString("idTourTicket"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getDate("reviewDate"),
                        rs.getBoolean("isVerified"),
                        rs.getString("full_name")
                );
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reviews;
    }

    @Override
    public ReviewDTO readbyID(Integer idReview) { // Sử dụng kiểu K là Integer
        String sql = "SELECT r.*, u.full_name FROM TourReviews r JOIN Users u ON r.idUser = u.id WHERE r.idReview = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idReview);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new ReviewDTO(
                        rs.getInt("idReview"),
                        rs.getInt("idUser"),
                        rs.getString("idTourTicket"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getDate("reviewDate"),
                        rs.getBoolean("isVerified"),
                        rs.getString("full_name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean update(ReviewDTO review) {
        // Logic cập nhật một bình luận (nếu cần)
        String sql = "UPDATE TourReviews SET rating = ?, comment = ? WHERE idReview = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setInt(3, review.getIdReview());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean delete(Integer idReview) { // Sử dụng kiểu K là Integer
        // Logic xóa một bình luận (nếu cần)
        String sql = "DELETE FROM TourReviews WHERE idReview = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idReview);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<ReviewDTO> search(String searchTerm) {
        // Logic tìm kiếm bình luận (ví dụ: tìm theo tên người dùng)
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name FROM TourReviews r JOIN Users u ON r.idUser = u.id WHERE u.full_name LIKE ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Tương tự như readAll
                ReviewDTO review = new ReviewDTO(/* ... */);
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reviews;
    }

    // Lấy tất cả đánh giá của một tour
    public List<ReviewDTO> getReviewsByTourId(String idTourTicket) {
        List<ReviewDTO> reviews = new ArrayList<>();
        // Sử dụng JOIN để lấy cả tên người dùng (full_name) cùng lúc
        String sql = "SELECT r.*, u.full_name FROM TourReviews r "
                + "JOIN Users u ON r.idUser = u.id "
                + "WHERE r.idTourTicket = ? ORDER BY r.reviewDate DESC";

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, idTourTicket);
            ResultSet rs = ps.executeQuery();

            // Dùng constructor để tạo đối tượng gọn gàng hơn
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO(
                        rs.getInt("idReview"),
                        rs.getInt("idUser"),
                        rs.getString("idTourTicket"),
                        rs.getInt("rating"),
                        rs.getString("comment"),
                        rs.getDate("reviewDate"),
                        rs.getBoolean("isVerified"),
                        rs.getString("full_name") // Truyền tên vào constructor
                );

                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reviews;
    }

    public ReviewDTO getUserReview(int userId, String tourId) {
        String sql = "SELECT * FROM TourReviews WHERE idUser = ? AND idTourTicket = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, tourId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdReview(rs.getInt("idReview"));
                review.setIdUser(rs.getInt("idUser"));
                review.setIdTourTicket(rs.getString("idTourTicket"));
                review.setRating(rs.getInt("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewDate(rs.getTimestamp("reviewDate"));
                review.setVerified(rs.getBoolean("isVerified"));

                // Lấy thêm thông tin user
                UserDAO userDAO = new UserDAO();
                UserDTO user = userDAO.readbyID(String.valueOf(userId));
                if (user != null) {
                    review.setUserName(user.getFullName());
                }

                return review;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Method kiểm tra user đã review chưa
    public boolean hasUserReviewed(int userId, String tourId) {
        return getUserReview(userId, tourId) != null;
    }

    // Method wrapper cho update/delete theo userId + tourId
    public boolean updateUserReview(int userId, String tourId, int rating, String comment) {
        ReviewDTO existingReview = getUserReview(userId, tourId);
        if (existingReview == null) {
            return false; // User chưa có review
        }

        existingReview.setRating(rating);
        existingReview.setComment(comment);
        
        return update(existingReview);
    }

    public boolean deleteUserReview(int userId, String tourId) {
        ReviewDTO existingReview = getUserReview(userId, tourId);
        if (existingReview == null) {
            return false; // User chưa có review
        }

        return delete(existingReview.getIdReview());
    }
}
