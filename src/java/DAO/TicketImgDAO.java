/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.TicketImgDTO;
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
public class TicketImgDAO implements IDAO<TicketImgDTO, String>{
    
    private final String SELECT_QUERY = "SELECT * FROM dbo.TicketImgs";
    private final String INSERT_QUERY = "INSERT INTO dbo.TicketImgs (idTourTicket , imgNum ,imgUrl)   VALUES (?, ?, ?)";
    private final String UPDATE_QUERY = "UPDATE dbo.TicketImgs  SET imgUrl = ? WHERE idTourTicket = ? AND imgNum ?";
    private final String DELETE_QUERY = "DELETE FROM dbo.TicketImgs  WHERE idTourTicket = ?";
    
    public boolean checkAttribute(String attribute) {
        List<String> validAttributes = Arrays.asList("idTourTicket");
        return validAttributes.contains(attribute);
    }
    
    public List<TicketImgDTO> searchWithCondition(String searchTerm, String attribute) {
        if (checkAttribute(attribute)) {
            String sql = SELECT_QUERY + " WHERE " + attribute + " = ? ";
            List<TicketImgDTO> list = new ArrayList<>();
            try {
                Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, searchTerm);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    TicketImgDTO newT = new TicketImgDTO(
                            rs.getString("idTourTicket"),
                            rs.getInt("imgNum"),
                            rs.getString("imgUrl"));

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
    
    public boolean deleteByTourId(String tourId){
        String sql = DELETE_QUERY;
        try {
            Connection cn = UTILS.DBUtils.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, tourId);
            int rs = ps.executeUpdate();
            return rs > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TicketImgDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TicketImgDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean create(TicketImgDTO entity) {
        String sql = INSERT_QUERY;
        try {
            Connection cn = UTILS.DBUtils.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, entity.getIdTourTicket());
            ps.setInt(2, entity.getImgNum());
            ps.setString(3, entity.getImgUrl());
            
            int rs = ps.executeUpdate();
            return rs > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TicketImgDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TicketImgDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<TicketImgDTO> readAll() {
        return null;
    }
    
    public List<TicketImgDTO> readbyIdTourTicket(String id) {
       return this.searchWithCondition(id, "idTourTicket");
    }

    @Override
    public TicketImgDTO readbyID(String id) {
       return null;
    }

    @Override
    public boolean update(TicketImgDTO entity) {
        String sql = UPDATE_QUERY;
        try {
            Connection cn = UTILS.DBUtils.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, entity.getIdTourTicket());
            ps.setInt(2, entity.getImgNum());
            ps.setString(3, entity.getImgUrl());
            int rs = ps.executeUpdate();
            return rs > 0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TicketImgDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TicketImgDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<TicketImgDTO> search(String searchTerm) {
        return null;
    }

   
}
