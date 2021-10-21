/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loginapppackage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Пользователь
 */
public class Operations {
    public static int saveUserInfo(String fullName, String lastName, String email, int user_id) {
        try {
            Connection con = MySQL.connection();
            
            PreparedStatement ps = con.prepareStatement("UPDATE details SET first_name = ?, last_name = ?, email = ? WHERE user_id = ?");
            
            ps.setString(1, fullName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setInt(4, user_id);
            
            ps.executeUpdate();
            ps.close();
            
            return 1;
        } catch (SQLException e) {
            return 2;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AjaxControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
            return 3;
        }
    }
    
    public static String createStringMD5(String originalString) {
       try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(originalString.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
              sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1,3));
           }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static int createUser(String userName, String password) {
            try {
                String passwordMd5 = Operations.createStringMD5(password);
                
                Connection con = MySQL.connection();

                PreparedStatement stmt = con.prepareStatement("INSERT INTO login VALUES (null, ?, ?)", Statement.RETURN_GENERATED_KEYS);

                stmt.setString(1, userName);
                stmt.setString(2, passwordMd5);

                int result = stmt.executeUpdate();

                ResultSet rs = stmt.getGeneratedKeys();

                int last_inserted_id = 0;

                if (rs.next()) {
                    last_inserted_id = rs.getInt(1);
                }

                PreparedStatement stmt2 = con.prepareStatement("INSERT INTO details VALUES (?, null, null, null)");

                stmt2.setInt(1, last_inserted_id);

                int result2 = stmt2.executeUpdate();
                
                con.close();
                
                if (result > 0 && result2 > 0) {
                    return 5;
                } else {
                    return 7;
                }
            } catch (Exception e) {
                return 6;
            }
    }
    
    public static int checkUserByDetail(String userName, String firstName, String lastName, String email) {
        int user_id = 0;
        
        try {
            Connection connection = MySQL.connection();
            
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM login JOIN details ON login.id = details.user_id WHERE login.username = ? AND details.first_name = ? AND details.last_name = ? AND details.email = ?");
            
            preparedStatement.setString(1, userName);
            preparedStatement.setString(2, firstName);
            preparedStatement.setString(3, lastName);
            preparedStatement.setString(4, email);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                user_id = rs.getInt("id");
            }
            
            if (user_id > 0) {
                return user_id;
            } else {
                return 0;
            }
        } catch (SQLException e) {
            return -1;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ForgetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }
    
    public static int changeUserPassword(int user_id, String newPassword) {
        try {
            String passwordMd5 = Operations.createStringMD5(newPassword);
            
            Connection con = MySQL.connection();

            PreparedStatement ps = con.prepareStatement("UPDATE login SET password = ? WHERE id = ?");

            ps.setString(1, passwordMd5);
            ps.setInt(2, user_id);

            int result = ps.executeUpdate();
            ps.close();

            return 1;
        } catch (SQLException e) {
            return -1;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AjaxControllerServlet.class.getName()).log(Level.SEVERE, null, ex);
            return -1;
        }
    }
    
    public static Boolean checkFailEntry(String parameter) {
        String fail_entry = parameter;
        
        if (fail_entry != null && !fail_entry.trim().isEmpty()) {
            return true;
        } else {
            return false;
        }
    }
}
