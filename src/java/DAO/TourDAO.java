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
        String sql = "SELECT [idTour],[destination],[placestart],[duration],[startdate],[price],[nametour],[img],P.description, T.transport_name\n"
                + "  FROM [travel_assistant].[dbo].[TourList] TL \n"
                + "  JOIN DBO.transport T ON TL.transport_id = T.transport_id\n"
                + "  JOIN DBO.places P ON TL.idplace = P.idplace\n"
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
                                            rs.getString("nametour"),
                                            rs.getString("img"),
                                            rs.getString("P.description"),
                                            rs.getString("T.transport_name"));

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
