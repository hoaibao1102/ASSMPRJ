package DTO;

import java.util.Date;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author ddhuy
 */
public class ReviewDTO {

    private int idReview;
    private int idUser;
    private String idTourTicket;
    private int rating; // Thêm lại cột rating
    private String comment;
    private Date reviewDate;
    private String userName;
    private String Status;

    

    public ReviewDTO() {
    }

    public ReviewDTO(int idUser, String idTourTicket, int rating, String comment) {
        this.idUser = idUser;
        this.idTourTicket = idTourTicket;
        this.rating = rating;
        this.comment = comment;
    }
    

    public ReviewDTO(int idReview, int idUser, String idTourTicket, int rating, String comment, Date reviewDate, String userName) {
        this.idReview = idReview;
        this.idUser = idUser;
        this.idTourTicket = idTourTicket;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.userName = userName;
    }

    // Getters and Setters
    public int getIdReview() {
        return idReview;
    }

    public void setIdReview(int idReview) {
        this.idReview = idReview;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getIdTourTicket() {
        return idTourTicket;
    }

    public void setIdTourTicket(String idTourTicket) {
        this.idTourTicket = idTourTicket;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }
}
