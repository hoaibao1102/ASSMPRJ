/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.PlacesDTO;
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
public class PlacesDAO implements IDAO<PlacesDTO, String> {

    private final String SELECT_QUERY = "SELECT * FROM dbo.Places";

    public boolean checkAttribute(String attribute) {
        List<String> validAttributes = Arrays.asList("placeName", "idPlace");
        return validAttributes.contains(attribute);
    }

    public List<PlacesDTO> searchWithCondition(String searchTerm, String attribute) {
        if (checkAttribute(attribute)) {
            String sql = SELECT_QUERY + " WHERE " + attribute + " = ? ";
            List<PlacesDTO> list = new ArrayList<>();
            try {
                Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, searchTerm);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    PlacesDTO newT = new PlacesDTO(rs.getInt("idplace"),
                            rs.getString("placename"),
                            rs.getString("description"),
                            rs.getString("img_places"));

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
    
    public PlacesDTO readByName(String namePlace) {
        List<PlacesDTO> rs = this.searchWithCondition(namePlace, "placeName");
        for (PlacesDTO i : rs) {
            PlacesDTO newT = new PlacesDTO(
                    i.getIdPlace(),
                    i.getPlaceName(),
                    i.getDescription(),
                    i.getImg());
            return newT;
        }
        return null;
    }
    
    @Override
    public PlacesDTO readbyID(String id) {
        List<PlacesDTO> rs = this.searchWithCondition(id, "idplace");
        for (PlacesDTO i : rs) {
            PlacesDTO newT = new PlacesDTO(i.getIdPlace(),
                    i.getPlaceName(),
                    i.getDescription(),
                    i.getImg());
            return newT;
        }
        return null;
    }

    @Override
    public boolean create(PlacesDTO entity) {
        return false;
    }

    @Override
    public List<PlacesDTO> readAll() {
        String sql = "SELECT idplace, placename,description,img_places FROM dbo.Places ";
        List<PlacesDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PlacesDTO newT = new PlacesDTO(rs.getInt("idplace"),
                        rs.getString("placename"),
                        rs.getString("description"),
                        rs.getString("img_places"));
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

    @Override
    public boolean update(PlacesDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<PlacesDTO> search(String searchTerm) {
        return null;
    }

}
