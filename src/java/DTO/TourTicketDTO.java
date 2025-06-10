/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class TourTicketDTO {
        private String idTourTicket;
        private int idplace;
        private String destination;
        private String placestart;
        private String duration;
        private double price;
        private String transport_name;
        private String nametour;
        private String img_Tour;

    public TourTicketDTO() {
    }

    public TourTicketDTO(String idTourTicket, int idplace, String destination, String placestart, String duration, double price, String transport_name, String nametour, String img_Tour) {
        this.idTourTicket = idTourTicket;
        this.idplace = idplace;
        this.destination = destination;
        this.placestart = placestart;
        this.duration = duration;
        this.price = price;
        this.transport_name = transport_name;
        this.nametour = nametour;
        this.img_Tour = img_Tour;
    }

    public String getIdTourTicket() {
        return idTourTicket;
    }

    public void setIdTourTicket(String idTourTicket) {
        this.idTourTicket = idTourTicket;
    }

    public int getIdplace() {
        return idplace;
    }

    public void setIdplace(int idplace) {
        this.idplace = idplace;
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

    
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTransport_name() {
        return transport_name;
    }

    public void setTransport_name(String transport_name) {
        this.transport_name = transport_name;
    }

    public String getNametour() {
        return nametour;
    }

    public void setNametour(String nametour) {
        this.nametour = nametour;
    }

    public String getImg_Tour() {
        return img_Tour;
    }

    public void setImg_Tour(String img_Tour) {
        this.img_Tour = img_Tour;
    }

    
        
        
        
    }

   