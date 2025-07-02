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
        String sql = "INSERT INTO TourStartDates (idTourTicket,startdate,startNum) VALUES (?,?,?) ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,entity.getIdTourTicket());
            ps.setString(2,entity.getStartDate());
            ps.setInt(3,entity.getStartNum());
            
            int re = ps.executeUpdate();
            return re >0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartDateDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartDateDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        String sql = "UPDATE TourStartDates " +  
                    "SET startdate = ? , " +
                        "quantity = ?  " +
                        "WHERE idTourTicket = ? AND startNum = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,entity.getStartDate());
            ps.setInt(2,entity.getQuantity());
            ps.setString(3,entity.getIdTourTicket());
            ps.setInt(4,entity.getStartNum());
            
            int n = ps.executeUpdate();
            return n > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartDateDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartDateDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<StartDateDTO> search(String idTourTicket) {
        List<StartDateDTO> dateList = new ArrayList<>();
        String sql = "SELECT * FROM TourStartDates WHERE idTourTicket = ? AND startNum > 0";
       
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,idTourTicket);
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
    
    public StartDateDTO searchDetailDate(String idTourTicket,int startNum) {
        StartDateDTO std = null;
        String sql = "SELECT * FROM TourStartDates WHERE idTourTicket = ? and startNum = ? ";
       
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,idTourTicket);
            ps.setInt(2,startNum);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                    std = new StartDateDTO(rs.getString("idTourTicket"),
                                                    rs.getString("startdate"),
                                                    rs.getInt("startNum"), 
                                                    rs.getInt("quantity"));
                
            }
            return std;
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PlacesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean deleteByTourId(String tourId) {
        
        return false;
    }

    public boolean deleteByTourId(String tourId, String startDate) {
        String sql = "UPDATE TourStartDates SET startNum = 0 WHERE idTourTicket = ? AND startdate = ? ";
        
        try {
            Connection conn= DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, tourId);
            ps.setString(2, startDate);
            
            int re =ps.executeUpdate();
            return re > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(StartDateDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StartDateDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
}
