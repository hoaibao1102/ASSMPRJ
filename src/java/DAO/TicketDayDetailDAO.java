/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.TicketDayDetailDTO;
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
 * @author Admin
 */
public class TicketDayDetailDAO implements IDAO<TicketDayDetailDAO, String>{

    
    
    private final String SELECT_QUERY = "SELECT * FROM dbo.TicketDayDetails";
    
    public boolean checkAttribute(String attribute) {
        List<String> validAttributes = Arrays.asList("idTourTicket");
        return validAttributes.contains(attribute);
    }
    
    public List<TicketDayDetailDTO> searchWithCondition(String searchTerm, String attribute) {
        if (checkAttribute(attribute)) {
            String sql = SELECT_QUERY + " WHERE " + attribute + " = ? ";
            List<TicketDayDetailDTO> list = new ArrayList<>();
            try {
                Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, searchTerm);
                ResultSet rs = ps.executeQuery();
                
                while (rs.next()) {
                    TicketDayDetailDTO newT = new TicketDayDetailDTO(
                            rs.getString("idTourTicket"),
                            rs.getInt("Day"),
                            rs.getString("Description"));
                    
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
    
    public List<TicketDayDetailDTO> readbyIdTourTicket(String id) {
        
        return this.searchWithCondition(id, "idTourTicket");
    
    }
    
    
    @Override
    public boolean create(TicketDayDetailDAO entity) {
       
        return false;
       
    }

    @Override
    public List<TicketDayDetailDAO> readAll() {
    
        return null;
    
    }

    @Override
    public TicketDayDetailDAO readbyID(String id) {
        
        return null;
        
    }

    @Override
    public boolean update(TicketDayDetailDAO entity) {
    
        return false;
    
    }

    @Override
    public boolean delete(String id) {
        
        return false;
        
    }

    @Override
    public List<TicketDayDetailDAO> search(String searchTerm) {
        
        return null;
        
    }
    
}
