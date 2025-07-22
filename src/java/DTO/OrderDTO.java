/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.sql.Date;

/**
 *
 * @author MSI PC
 */
public class OrderDTO {
    private int idUser;
    private String idTour;
    private String bookingDate;
    private int numberTicket;
    private Date startDate;
    private double totalPrice;
    private int status;
    private String idBooking;
    private String note;
    private int voucherID;
    private Double amount_off;

    public OrderDTO() {
    }

    public OrderDTO(int idUser, String idTour, String bookingDate, int numberTicket, Date startDate, double totalPrice, int status, String idBooking, String note, int voucherID, Double amount_off) {
        this.idUser = idUser;
        this.idTour = idTour;
        this.bookingDate = bookingDate;
        this.numberTicket = numberTicket;
        this.startDate = startDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.idBooking = idBooking;
        this.note = note;
        this.voucherID = voucherID;
        this.amount_off = amount_off;
    }

    public OrderDTO(int idUser, String idTour, String bookingDate, int numberTicket, double total, int status, String idBooking, String note, Date startDate, int voucherID, double amount_off) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Double getAmount_off() {
        return amount_off;
    }

    public void setAmount_off(Double amount_off) {
        this.amount_off = amount_off;
    }

    

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    
    
    public OrderDTO(int idUser, String idTour, String bookingDate, int numberTicket, double totalPrice, int status, String idBooking, String note, Date startDate) {
        this.idUser = idUser;
        this.idTour = idTour;
        this.bookingDate = bookingDate;
        this.numberTicket = numberTicket;
        this.startDate = startDate;
        this.totalPrice = totalPrice;
        this.status = status;
        this.idBooking = idBooking;
        this.note = note;
    }

    public OrderDTO(int idUser, String idTour, String bookingDate, int numberTicket, double total, int status, String idBooking, String note, Date startDate, int voucherID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getIdTour() {
        return idTour;
    }

    public void setIdTour(String idTour) {
        this.idTour = idTour;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public int getNumberTicket() {
        return numberTicket;
    }

    public void setNumberTicket(int numberTicket) {
        this.numberTicket = numberTicket;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getIdBooking() {
        return idBooking;
    }

    public void setIdBooking(String idBooking) {
        this.idBooking = idBooking;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
    
    
}
