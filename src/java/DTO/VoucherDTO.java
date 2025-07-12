/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author Admin
 */
public class VoucherDTO {
    private int voucherID;
    private String title;
    private String startDate;
    private double discount;
    private int numbers;
    private int duration;
    private double minimumOrderValue;
    private boolean status;

    public VoucherDTO() {
    }

    public VoucherDTO(String title, String startDate, double discount, int numbers, int duration, double minimumOrderValue) {
        this.title = title;
        this.startDate = startDate;
        this.discount = discount;
        this.numbers = numbers;
        this.duration = duration;
        this.minimumOrderValue = minimumOrderValue;
    }

    public VoucherDTO(int voucherID, String title, String startDate, double discount, int numbers, int duration, double minimumOrderValue, boolean status) {
        this.voucherID = voucherID;
        this.title = title;
        this.startDate = startDate;
        this.discount = discount;
        this.numbers = numbers;
        this.duration = duration;
        this.minimumOrderValue = minimumOrderValue;
        this.status = status;
    }


    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    

    public double getMinimumOrderValue() {
        return minimumOrderValue;
    }

    public void setMinimumOrderValue(double minimumOrderValue) {
        this.minimumOrderValue = minimumOrderValue;
    }

    

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public int getNumbers() {
        return numbers;
    }

    public void setNumbers(int numbers) {
        this.numbers = numbers;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }
    
    
}
