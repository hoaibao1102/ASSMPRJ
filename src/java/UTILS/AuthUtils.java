/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UTILS;

import DAO.UserDAO;
import DTO.UserDTO;
import jakarta.servlet.http.HttpSession;


/**
 *
 * @author tungi
 */
public class AuthUtils {
    public static final String ADMIN_ROLE = "AD";
    public static final String USER_ROLE = "CUS";
    
    //hàm lấy ra người dùng để check đăng nhập phía dưới
    public static UserDTO getUser(String txtEmailOrPhone) {
        UserDAO udao = new UserDAO();
        UserDTO user = udao.readbyID(txtEmailOrPhone);
        return user;
    }

    //hàm kiểm tra đăng nhập bằng 2 cái quỷ ở dưới
    public static boolean isValidLogin(String txtEmailOrPhone, String txtPassword) {
        UserDTO user = getUser(txtEmailOrPhone);
        String encodePassWord = PasswordUtils.hashPassword(txtPassword);
        return user != null && user.getPassword().equals(encodePassWord);
            
    }
    
    public static boolean isLoggedIn(HttpSession session){
        return session.getAttribute("nameUser") != null;
    }
    
    public static boolean isAdmin(HttpSession session){
        if(!isLoggedIn(session)){
            return false;
        }
        UserDTO user = (UserDTO)session.getAttribute("nameUser");
        return user.getRole().equals(ADMIN_ROLE);
    }
}
