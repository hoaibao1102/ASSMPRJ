/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class TourDTO {
    private String idTour;
    private String destination;
    private String placestart;
    private String duration;
    private String startDate;
    private String transport;
    private String nameTour;
    private String img;
    private double price;
    private String placeDescription;

    public TourDTO() {
    }

    public TourDTO(String idTour, String destination, String placestart, String duration, String startDate,double price, String transport, String nameTour, String img,  String placeDescription) {
        this.idTour = idTour;
        this.destination = destination;
        this.placestart = placestart;
        this.duration = duration;
        this.startDate = startDate;
        this.transport = transport;
        this.nameTour = nameTour;
        this.img = img;
        this.price = price;
        this.placeDescription = placeDescription;
    }

    public String getIdTour() {
        return idTour;
    }

    public void setIdTour(String idTour) {
        this.idTour = idTour;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getPlacestart() {
        return placestart;
    }

    public void setPlacestart(String placestart) {
        this.placestart = placestart;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public String getNameTour() {
        return nameTour;
    }

    public void setNameTour(String nameTour) {
        this.nameTour = nameTour;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getPlaceDescription() {
        return placeDescription;
    }

    public void setPlaceDescription(String placeDescription) {
        this.placeDescription = placeDescription;
    }
 
    
    
    
    }

   