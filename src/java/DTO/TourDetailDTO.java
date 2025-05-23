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
    private String img;
    
    public TourDetailDTO() {
    }

    public TourDetailDTO(String idTour, String nameTour, String descriptD1, String descriptD2, String descriptD3, String img) {
        this.idTour = idTour;
        this.nameTour = nameTour;
        this.descriptD1 = descriptD1;
        this.descriptD2 = descriptD2;
        this.descriptD3 = descriptD3;
        this.img = img;
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

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    
}
