/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class TicketImgDTO {
    private String idTourTicket;
    private int imgNum;
    private String imgUrl;
    
    public TicketImgDTO() {
    }

    public TicketImgDTO(String idTourTicket, int imgNum, String imgUrl) {
        this.idTourTicket = idTourTicket;
        this.imgNum = imgNum;
        this.imgUrl = imgUrl;
    }

    public String getIdTourTicket() {
        return idTourTicket;
    }

    public void setIdTourTicket(String idTourTicket) {
        this.idTourTicket = idTourTicket;
    }

    public int getImgNum() {
        return imgNum;
    }

    public void setImgNum(int imgNum) {
        this.imgNum = imgNum;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    

    
}
