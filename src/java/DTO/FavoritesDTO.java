/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

/**
 *
 * @author MSI PC
 */
public class FavoritesDTO {
    private int idUser;
    private String idTourTicket;

    public FavoritesDTO() {
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public String getIdTourTicket() {
        return idTourTicket;
    }

    public void setIdTourTicket(String idTourTicket) {
        this.idTourTicket = idTourTicket;
    }

    public FavoritesDTO(int idUser, String idTourTicket) {
        this.idUser = idUser;
        this.idTourTicket = idTourTicket;
    }
}
