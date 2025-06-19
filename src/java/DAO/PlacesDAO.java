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

    private final String SELECT_QUERY = "SELECT * FROM dbo.Places  ";
    

    public boolean checkAttribute(String attribute) {
        List<String> validAttributes = Arrays.asList("placeName", "idPlace");
        return validAttributes.contains(attribute);
    }

    public List<PlacesDTO> searchWithCondition(String searchTerm, String attribute) {
        if (checkAttribute(attribute)) {
            String sql = SELECT_QUERY + " where " + attribute + " = ? ";
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
                            rs.getString("img_places"),
                            rs.getInt("Featured") == 1,
                            rs.getBoolean("status"));

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
            PlacesDTO newT = new PlacesDTO(i.getIdPlace(),
                    i.getPlaceName(),
                    i.getDescription(),
                    i.getImg(),
                    i.getFeatured(),
                    i.isStatus());
            return newT;
        }
        return null;
    }

    @Override
    public PlacesDTO readbyID(String id) {
        List<PlacesDTO> rs = this.searchWithCondition(id, "idPlace");
        for (PlacesDTO i : rs) {
            PlacesDTO newT = new PlacesDTO(i.getIdPlace(),
                    i.getPlaceName(),
                    i.getDescription(),
                    i.getImg(),
                    i.getFeatured(),
                    i.isStatus());
            return newT;
        }
        return null;
    }

    @Override
    public boolean create(PlacesDTO entity) {
        String sql = "INSERT INTO Places (placename, description, img_places, Featured, status) "
                + "VALUES (?, ?, ?, ?, ?)";

        Connection conn;
        try {
            conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getPlaceName());
            ps.setString(2, entity.getDescription());
            ps.setString(3, entity.getImg());
            ps.setInt(4, entity.getFeatured()?1:0);
            ps.setInt(5, entity.isStatus()?1:0);
            
            int n = ps.executeUpdate();
            return n >0;
            
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<PlacesDTO> readAll() {
        String sql = SELECT_QUERY;
        List<PlacesDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                PlacesDTO newT = new PlacesDTO(rs.getInt("idplace"),
                        rs.getString("placename"),
                        rs.getString("description"),
                        rs.getString("img_places"),
                        rs.getInt("Featured") == 1,
                        rs.getInt("status") == 1);
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
        String sql = "UPDATE Places SET description = ?, img_places = ?, Featured = ?, status = ? WHERE placename = ?";
        try ( Connection conn = DBUtils.getConnection();  
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, entity.getDescription());
            ps.setString(2, entity.getImg());
            ps.setInt(3, entity.getFeatured()?1:0);  // hoặc getFeatured() nếu dùng kiểu int
            ps.setInt(4, entity.isStatus()?1:0);
            ps.setString(5, entity.getPlaceName());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
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
