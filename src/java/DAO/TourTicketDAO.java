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
    private final String UPDATE_QUERY = "UPDATE TourTickets SET " 
                           + "placestart = ?, "          
                           + "price = ?, " 
                           + "transport_name = ?, " 
                           + "nametour = ?, " 
                           + "img_Tour = ?, "
                           + "status = ?  "  
                           + "WHERE idTourTicket = ?;";

    
    @Override
    public boolean update(TourTicketDTO entity) {
        String sql = UPDATE_QUERY;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getPlacestart());
            ps.setDouble(2, entity.getPrice());
            ps.setString(3, entity.getTransport_name());
            ps.setString(4, entity.getNametour());
            ps.setString(5, entity.getImg_Tour());
            ps.setInt(6, entity.isStatus()?1:0);
            ps.setString(7, entity.getIdTourTicket());
            int n = ps.executeUpdate();
            return n > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
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
                            rs.getDouble("price"),
                            rs.getString("transport_name"),
                            rs.getString("nametour"),
                            rs.getString("img_Tour"),
                            rs.getInt("status")==1);

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
        List<TourTicketDTO> list = this.searchWithCondition(id, "idTourTicket");
        for (TourTicketDTO rs : list) {
            TourTicketDTO newT = new TourTicketDTO(
                            rs.getIdTourTicket(),
                            rs.getIdplace(),
                            rs.getDestination(),
                            rs.getPlacestart(),
                            rs.getDuration(),
                            rs.getPrice(),
                            rs.getTransport_name(),
                            rs.getNametour(),
                            rs.getImg_Tour(),
                            rs.isStatus());
            return newT;
        }
        return null;

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

    public List<TourTicketDTO> searchAnyInfor(String searchItem) {
        String sql = SELECT_QUERY
                + "  WHERE destination COLLATE Latin1_General_CI_AI like ? or "
                + " nametour COLLATE Latin1_General_CI_AI like ? ";
        List<TourTicketDTO> list = new ArrayList<>();
        try {
            String searchTerm2 = "%"+searchItem+"%";
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, searchTerm2);
            ps.setString(2, searchTerm2);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TourTicketDTO newT = new TourTicketDTO(
                            rs.getString("idTourTicket"),
                            rs.getInt("idplace"),
                            rs.getString("destination"),
                            rs.getString("placestart"),
                            rs.getString("duration"),
                            rs.getDouble("price"),
                            rs.getString("transport_name"),
                            rs.getString("nametour"),
                            rs.getString("img_Tour"),
                            rs.getInt("status")==1);

                    list.add(newT);
            }
            return list;

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourTicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }

    

}
