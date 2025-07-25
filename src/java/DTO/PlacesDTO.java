/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import DAO.*;

/**
 *
 * @author MSI PC
 */
public class PlacesDTO {
    private int idPlace;
    private String placeName;
    private String description;
    private String img;
    private boolean featured;
    private boolean status;
    
    public PlacesDTO() {
    }

    public PlacesDTO(int idPlace, String placeName, String description, String img, boolean featured, boolean status) {
        this.idPlace = idPlace;
        this.placeName = placeName;
        this.description = description;
        this.img = img;
        this.featured = featured;
        this.status = status;
    }

    public PlacesDTO(String placeName, String description, String img, boolean featured, boolean status) {
        this.placeName = placeName;
        this.description = description;
        this.img = img;
        this.featured = featured;
        this.status = status;
    }
    
    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    
    public boolean getFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }

    public int getIdPlace() {
        return idPlace;
    }

    public void setIdPlace(int idPlace) {
        this.idPlace = idPlace;
    }

    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }
    
}
