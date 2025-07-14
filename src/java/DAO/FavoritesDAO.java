/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.FavoritesDTO;
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
public class FavoritesDAO implements IDAO<FavoritesDTO, String>{

    @Override
    public boolean create(FavoritesDTO entity) {
        String sql = "INSERT INTO Favorites (idUser, idTourTicket) VALUES (?, ?)";
        try {
            Connection conn  = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, entity.getIdUser());
            ps.setString(2, entity.getIdTourTicket());
            
            int rowEffect = ps.executeUpdate();
            return rowEffect > 0 ;
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FavoritesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(FavoritesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }

    @Override
    public List<FavoritesDTO> readAll() {
        return null;
    }

    @Override
    public FavoritesDTO readbyID(String id) {
        return null;
    }

    @Override
    public boolean update(FavoritesDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<FavoritesDTO> search(String searchTerm) {
        return null;
    }

    public List<FavoritesDTO> getByUserId(int idUser) {
        String sql = "SELECT * FROM Favorites WHERE idUser = ? ";
        List<FavoritesDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, idUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                FavoritesDTO favo = new FavoritesDTO(rs.getInt("idUser"),
                                                     rs.getString("idTourTicket"));
                
                list.add(favo);
            }
            return list;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FavoritesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(FavoritesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }

    public boolean deleteFavorite(FavoritesDTO favo) {
        String sql = "DELETE FROM Favorites WHERE idUser = ? AND idTourTicket = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, favo.getIdUser());
            ps.setString(2,favo.getIdTourTicket());
            
            int rowEffect = ps.executeUpdate();
            return rowEffect >0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(FavoritesDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(FavoritesDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
}
