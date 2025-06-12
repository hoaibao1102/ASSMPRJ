/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.StartDateDTO;
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
public class StartDateDAO implements IDAO<StartDateDTO, String>{

    @Override
    public boolean create(StartDateDTO entity) {
        return false;
    }

    @Override
    public List<StartDateDTO> readAll() {
        return null;
    }

    @Override
    public StartDateDTO readbyID(String id) {
        return null;
    }

    @Override
    public boolean update(StartDateDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<StartDateDTO> search(String searchTerm) {
        List<StartDateDTO> dateList = new ArrayList<>();
        String sql = "SELECT * FROM TourStartDates WHERE idTourTicket = ? ";
       
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,searchTerm);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                StartDateDTO std = new StartDateDTO(rs.getString("idTourTicket"),
                                                    rs.getString("startdate"),
                                                    rs.getInt("startNum"), 
                                                    rs.getInt("quantity"));
                dateList.add(std);
            }
            return dateList;
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
