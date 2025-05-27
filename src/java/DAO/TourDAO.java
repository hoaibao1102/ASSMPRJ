/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
public class TourDAO implements IDAO<TourDTO, String> {

    @Override
    public boolean create(TourDTO entity) {
        return false;
    }

    @Override
    public List<TourDTO> readAll() {

        return null;

    }

    @Override
    public TourDTO readbyID(String id) {
        String sql = "SELECT [idTour],[destination],[placestart],[duration],[startdate],[price],[nametour],[img],P.description AS place_description, T.transport_name AS transport "
                + "  FROM [travel_assistant].[dbo].[TourList] TL "
                + "  JOIN DBO.transport T ON TL.transport_id = T.transport_id"
                + "  JOIN DBO.places P ON TL.idplace = P.idplace"
                + "  WHERE idTour = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                TourDTO newT = new  TourDTO(rs.getString("idTour"),
                                            rs.getString("destination"), 
                                            rs.getString("placestart"),
                                            rs.getString("duration"),
                                            rs.getString("startdate"),
                                            rs.getDouble("price"),
                                            rs.getString("transport"),
                                            rs.getString("nametour"),
                                            rs.getString("img"),
                                            rs.getString("place_description"));
                return newT;
            }
            

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }

    @Override
    public boolean update(TourDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<TourDTO> search(String searchTerm) {
        String sql = "SELECT [idTour],[destination],[placestart],[duration],[startdate],[price],[nametour],[img],P.description AS place_description, T.transport_name AS transport "
                + "  FROM [travel_assistant].[dbo].[TourList] TL "
                + "  JOIN DBO.transport T ON TL.transport_id = T.transport_id"
                + "  JOIN DBO.places P ON TL.idplace = P.idplace"
                + "  WHERE P.placename = ? ";
        List<TourDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, searchTerm);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TourDTO newT = new  TourDTO(rs.getString("idTour"),
                                            rs.getString("destination"), 
                                            rs.getString("placestart"),
                                            rs.getString("duration"),
                                            rs.getString("startdate"),
                                            rs.getDouble("price"),
                                            rs.getString("transport"),
                                            rs.getString("nametour"),
                                            rs.getString("img"),
                                            rs.getString("place_description"));

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
 
    public List<TourDTO> searchAnyInfor(String searchTerm) {
        String sql = "SELECT [idTour],[destination],[placestart],[duration],[startdate],[price],[nametour],[img],P.description AS place_description, T.transport_name AS transport "
                + "  FROM [travel_assistant].[dbo].[TourList] TL "
                + "  JOIN DBO.transport T ON TL.transport_id = T.transport_id"
                + "  JOIN DBO.places P ON TL.idplace = P.idplace"
                + "  WHERE P.placename like ? "
                + " or TL.nametour like ? ";
        List<TourDTO> list = new ArrayList<>();
        try {
            String searchTerm2 = "%"+searchTerm+"%";
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, searchTerm2);
            ps.setString(2, searchTerm2);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TourDTO newT = new  TourDTO(rs.getString("idTour"),
                                            rs.getString("destination"), 
                                            rs.getString("placestart"),
                                            rs.getString("duration"),
                                            rs.getString("startdate"),
                                            rs.getDouble("price"),
                                            rs.getString("transport"),
                                            rs.getString("nametour"),
                                            rs.getString("img"),
                                            rs.getString("place_description"));

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
}
