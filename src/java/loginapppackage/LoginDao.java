/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package loginapppackage;

import java.sql.*;

/**
 *
 * @author Пользователь
 */
public class LoginDao {
    public Boolean validate(LoginBean loginBean) throws ClassNotFoundException {
        Boolean status = false;
        
        try {
            Connection connection = MySQL.connection();
            
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM login WHERE username = ? AND password = ?");
            
            String passwordMd5 = Operations.createStringMD5(loginBean.getPassword());
            
            preparedStatement.setString(1, loginBean.getUsername());
            preparedStatement.setString(2, passwordMd5);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            status = rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        
        return status;
    }
    
    public int getUserId(LoginBean loginBean) throws ClassNotFoundException {
        int user_id = 0;
        
        try {
            Connection connection = MySQL.connection();
            
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM login WHERE username = ? AND password = ?");
            
            String passwordMd5 = Operations.createStringMD5(loginBean.getPassword());
            
            preparedStatement.setString(1, loginBean.getUsername());
            preparedStatement.setString(2, passwordMd5);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                user_id = rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        
        return user_id;
    }
}
