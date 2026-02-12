/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.bankapp.servlet;

import java.sql.*;

public class DBConnection {

    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/BankingApp",
                    "root",
                    "mysql2003"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}


