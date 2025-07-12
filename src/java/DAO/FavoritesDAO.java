/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.FavoritesDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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
    
}
