/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class TourDetailDTO {
    private String idTour;
    private String nameTour;
    private String descriptD1;
    private String descriptD2;
    private String descriptD3;
    private String imgD1;
    private String imgD2;
    private String imgD3;
    private String imgHotel;
    private String imgOther;
    
    public TourDetailDTO() {
    }

    public TourDetailDTO(String idTour,String nameTour, String descriptD1, String descriptD2, String descriptD3, String imgD1, String imgD2, String imgD3, String imgHotel, String imgOther) {
        this.nameTour = nameTour;
        this.idTour = idTour;
        this.descriptD1 = descriptD1;
        this.descriptD2 = descriptD2;
        this.descriptD3 = descriptD3;
        this.imgD1 = imgD1;
        this.imgD2 = imgD2;
        this.imgD3 = imgD3;
        this.imgHotel = imgHotel;
        this.imgOther = imgOther;
    }

    public String getIdTour() {
        return idTour;
    }

    public void setIdTour(String idTour) {
        this.idTour = idTour;
    }

    public String getNameTour() {
        return nameTour;
    }

    public void setNameTour(String nameTour) {
        this.nameTour = nameTour;
    }

    
    public String getDescriptD1() {
        return descriptD1;
    }

    public void setDescriptD1(String descriptD1) {
        this.descriptD1 = descriptD1;
    }

    public String getDescriptD2() {
        return descriptD2;
    }

    public void setDescriptD2(String descriptD2) {
        this.descriptD2 = descriptD2;
    }

    public String getDescriptD3() {
        return descriptD3;
    }

    public void setDescriptD3(String descriptD3) {
        this.descriptD3 = descriptD3;
    }

    public String getImgD1() {
        return imgD1;
    }

    public void setImgD1(String imgD1) {
        this.imgD1 = imgD1;
    }

    public String getImgD2() {
        return imgD2;
    }

    public void setImgD2(String imgD2) {
        this.imgD2 = imgD2;
    }

    public String getImgD3() {
        return imgD3;
    }

    public void setImgD3(String imgD3) {
        this.imgD3 = imgD3;
    }

    public String getImgHotel() {
        return imgHotel;
    }

    public void setImgHotel(String imgHotel) {
        this.imgHotel = imgHotel;
    }

    public String getImgOther() {
        return imgOther;
    }

    public void setImgOther(String imgOther) {
        this.imgOther = imgOther;
    }
    
    
}
