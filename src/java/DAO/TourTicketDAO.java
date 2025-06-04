/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.TourTicketDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
public class TourTicketDAO implements IDAO<TourTicketDTO, String> {
    private final String SELECT_QUERY = "SELECT * FROM dbo.TourTickets";
    
    
    @Override
    public boolean create(TourTicketDTO entity) {
        return false;
    }
    
    //check xem cos phai attribute hop le khong
    public boolean checkAttribute(String attribute) {
        List<String> validAttributes = Arrays.asList("idTourTicket", "destination", "nametour");
        return validAttributes.contains(attribute);
    }

    
    //HAM SEARCH THAM SO TRUYEN VAO VÀ KEY VA ATTRIBUTE
    public List<TourTicketDTO> searchWithCondition(String searchTerm, String attribute) {
        if (checkAttribute(attribute)) {
            String sql = SELECT_QUERY + " WHERE " + attribute + " = ? ";
            List<TourTicketDTO> list = new ArrayList<>();
            try {
                Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, searchTerm);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    TourTicketDTO newT = new TourTicketDTO(
                            rs.getString("idTourTicket"),
                            rs.getInt("idplace"),
                            rs.getString("destination"),
                            rs.getString("placestart"),
                            rs.getString("duration"),
                            rs.getString("startdate"),
                            rs.getDouble("price"),
                            rs.getString("transport_name"),
                            rs.getString("nametour"),
                            rs.getString("img_Tour"),
                            rs.getInt("quantity"));

                    list.add(newT);
                }
                return list;

            } catch (ClassNotFoundException ex) {
                Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return null;
    }

    @Override
    public List<TourTicketDTO> readAll() {
        
        return null;
        
    }
    
    
    
    @Override
    public List<TourTicketDTO> search(String searchTerm) {
        return null;
    }

    @Override
    public TourTicketDTO readbyID(String id) {
        List<TourTicketDTO> rs = this.searchWithCondition(id, "idTourTicket");
        for(TourTicketDTO i : rs) {
                TourTicketDTO newT = new TourTicketDTO(
                        i.getIdTourTicket(), 
                        i.getIdplace(), 
                        i.getDestination(), 
                        i.getPlacestart(), 
                        i.getDuration(),
                        i.getStartdate(), 
                        i.getPrice(), 
                        i.getTransport_name(), 
                        i.getNametour(),
                        i.getImg_Tour(), 
                        i.getQuantity());
                return newT;
            }
        return  null;

        
    }

    @Override
    public boolean update(TourTicketDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

   
    public List<TourTicketDTO> searchByDestination(String searchTerm) {
        return this.searchWithCondition(searchTerm, "destination");
        
    }
 
    public List<TourTicketDTO> searchByNameTour(String searchTerm) {
        return this.searchWithCondition(searchTerm, "nametour");
    }

    
}
