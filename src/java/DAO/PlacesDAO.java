/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.PlacesDTO;
import DTO.TourDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
public class PlacesDAO implements IDAO<PlacesDTO, String>{

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
                PlacesDTO newT = new PlacesDTO( rs.getInt("idplace"),
                                                rs.getString("placename"), 
                                                rs.getString("description"), 
                                                rs.getString("img_places"));
                list.add(newT);
            }
            return list;

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }

    @Override
    public PlacesDTO readbyID(String id) {
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
