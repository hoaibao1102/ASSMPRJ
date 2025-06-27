/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class OrderDTO {
    private int idUser;
    private String idTour;
    private String bookingDate;
    private int numberTicket;
    private int startNum;
    private double totalPrice;
    private int status;
    private String idBooking;
    private String note;

    public OrderDTO() {
    }

    public OrderDTO(int idUser, String idTour, String bookingDate, int numberTicket, double totalPrice, int status, String idBooking, String note,int startNum) {
        this.idUser = idUser;
        this.idTour = idTour;
        this.bookingDate = bookingDate;
        this.numberTicket = numberTicket;
        this.totalPrice = totalPrice;
        this.status = status;
        this.idBooking = idBooking;
        this.note = note;
        this.startNum = startNum;
    }

    public int getStartNum() {
        return startNum;
    }

    public void setStartNum(int startNum) {
        this.startNum = startNum;
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
