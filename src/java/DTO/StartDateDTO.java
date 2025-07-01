/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class StartDateDTO {
    private String idTourTicket;
    private String startDate;
    private int startNum;
    private int quantity;

    public StartDateDTO(String idTourTicket, String startDate, int startNum,int quantity) {
        this.idTourTicket = idTourTicket;
        this.startDate = startDate;
        this.startNum = startNum;
        this.quantity = quantity;
    }
    
    public StartDateDTO(String idTourTicket, String startDate, int startNum) {
        this.idTourTicket = idTourTicket;
        this.startDate = startDate;
        this.startNum = startNum;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    

    public StartDateDTO() {
    }

    public String getIdTourTicket() {
        return idTourTicket;
    }

    public void setIdTourTicket(String idTourTicket) {
        this.idTourTicket = idTourTicket;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public int getStartNum() {
        return startNum;
    }

    public void setStartNum(int startNum) {
        this.startNum = startNum;
    }
}
