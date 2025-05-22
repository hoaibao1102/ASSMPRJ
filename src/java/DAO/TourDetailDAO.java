/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.TourDetailDTO;
import UTILS.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MSI PC
 */
public class TourDetailDAO implements IDAO<TourDetailDTO, String>{

    @Override
    public boolean create(TourDetailDTO entity) {
        return false;
    }

    @Override
    public List<TourDetailDTO> readAll() {
        return null;
    }

    @Override
    public TourDetailDTO readbyID(String id) {
       String sql = "SELECT tl.nametour as nametour, td.idTour as idTour,day1descrip ,day2descrip,day3descrip ,day1img,day2img,day3img,hotelimg "
               + "FROM dbo.TourDetail td "
               + "join dbo.TourList tl on td.idTour = tl.idTour "
               + "where td.idTour = ? ";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps= conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                TourDetailDTO tour = new TourDetailDTO( rs.getString("idTour"),
                                                        rs.getString("nametour"),
                                                        rs.getString("day1descrip"), 
                                                        rs.getString("day2descrip"), 
                                                        rs.getString("day3descrip"),
                                                        rs.getString("day1img"), 
                                                        rs.getString("day2img"),
                                                        rs.getString("day3img"), 
                                                        rs.getString("hotelimg"), 
                                                        "day la list anh ban can tim");
                return tour;
            }
            
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(TourDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(TourDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
    }

    @Override
    public boolean update(TourDetailDTO entity) {
        return false;
    }

    @Override
    public boolean delete(String id) {
        return false;
    }

    @Override
    public List<TourDetailDTO> search(String searchTerm) {
        return null;
    }

   
}
