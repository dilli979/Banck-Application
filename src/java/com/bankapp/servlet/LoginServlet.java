/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        String e = req.getParameter("email");
        String p = req.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM userlogin WHERE useremail=? AND userpassword=?");

            ps.setString(1, e);
            ps.setString(2, p);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession s = req.getSession();
                s.setAttribute("userid", rs.getInt("userid"));
                res.sendRedirect("dashboard.jsp");
            } else {
                res.getWriter().print("Invalid Login Credentials");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

