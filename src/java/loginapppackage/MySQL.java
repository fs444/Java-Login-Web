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
public class MySQL {
    public static Connection connection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login_db?useSSL=false", "root", "password");

        return con;
    }
}
