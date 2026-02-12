/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        String u = req.getParameter("username");
        String e = req.getParameter("email");
        String p = req.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO userlogin(username,useremail,userpassword) VALUES(?,?,?)");

            ps.setString(1, u);
            ps.setString(2, e);
            ps.setString(3, p);

            ps.executeUpdate();
            res.sendRedirect("login.jsp");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

