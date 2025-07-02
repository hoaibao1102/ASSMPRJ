/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.TicketDayDetailDTO;
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
 * @author Admin
 */
public class TicketDayDetailDAO implements IDAO<TicketDayDetailDTO, String> {

    private final String SELECT_QUERY = "SELECT * FROM dbo.TicketDayDetails";
    private final String UPDATE_QUERY = "UPDATE dbo.TicketDayDetails SET Description = ?, Morning = ?, Afternoon = ?, Evening = ? "
            + "WHERE idTourTicket = ? AND Day = ?";

    private final String CREATE_QUERY = "INSERT INTO TicketDayDetails (idTourTicket, Day, Description, Morning, Afternoon, Evening) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    public boolean checkAttribute(String attribute) {
        List<String> validAttributes = Arrays.asList("idTourTicket");
        return validAttributes.contains(attribute);
    }

    public List<TicketDayDetailDTO> searchWithCondition(String searchTerm, String attribute) {
        if (checkAttribute(attribute)) {
            String sql = SELECT_QUERY + " WHERE " + attribute + " = ? ";
            List<TicketDayDetailDTO> list = new ArrayList<>();
            try {
                Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, searchTerm);
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    TicketDayDetailDTO newT = new TicketDayDetailDTO(
                            rs.getString("idTourTicket"),
                            rs.getInt("Day"),
                            rs.getString("Description"),
                            rs.getString("Morning"),
                            rs.getString("Afternoon"),
                            rs.getString("Evening"));

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

    public List<TicketDayDetailDTO> readbyIdTourTicket(String id) {

        return this.searchWithCondition(id, "idTourTicket");

    }

    @Override
    public boolean create(TicketDayDetailDTO entity) {
        String sql = CREATE_QUERY;
        try {
            Connection cn = UTILS.DBUtils.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, entity.getIdTourTicket());
            ps.setInt(2, entity.getDay());
            ps.setString(3, entity.getDescription());
            ps.setString(4, entity.getMorning());
            ps.setString(5, entity.getAfternoon());
            ps.setString(6, entity.getEvening());
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
    public List<TicketDayDetailDTO> readAll() {
        return null;
    }

    @Override
    public TicketDayDetailDTO readbyID(String id) {
        return null;
    }

    @Override
    public boolean update(TicketDayDetailDTO entity) {
        String sql = UPDATE_QUERY;
        try {
            Connection cn = UTILS.DBUtils.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, entity.getDescription());
            ps.setString(2, entity.getMorning());
            ps.setString(3, entity.getAfternoon());
            ps.setString(4, entity.getEvening());
            ps.setString(5, entity.getIdTourTicket());
            ps.setInt(6, entity.getDay());
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
    public List<TicketDayDetailDTO> search(String searchTerm) {
        return null;
    }

}
