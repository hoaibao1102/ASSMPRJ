/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author Admin
 */
public class TicketDayDetailDTO {
    private String idTourTicket;
    private int day;
    private String description;
    private String morning;
    private String afternoon;
    private String evening ;
    
    
    public TicketDayDetailDTO() {
    }

    public TicketDayDetailDTO(String idTourTicket, int day, String description, String morning, String afternoon, String evening) {
        this.idTourTicket = idTourTicket;
        this.day = day;
        this.description = description;
        this.morning = morning;
        this.afternoon = afternoon;
        this.evening = evening;
    }

    public String getMorning() {
        return morning;
    }

    public void setMorning(String morning) {
        this.morning = morning;
    }

    public String getAfternoon() {
        return afternoon;
    }

    public void setAfternoon(String afternoon) {
        this.afternoon = afternoon;
    }

    public String getEvening() {
        return evening;
    }

    public void setEvening(String evening) {
        this.evening = evening;
    }

    

    public String getIdTourTicket() {
        return idTourTicket;
    }

    public void setIdTourTicket(String idTourTicket) {
        this.idTourTicket = idTourTicket;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
    
}
