/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.Random;

public class CreateAccountServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        HttpSession s = req.getSession();
        int uid = (int) s.getAttribute("userid");

        double balance = Double.parseDouble(req.getParameter("balance"));
        String type = req.getParameter("type");

        // Generate random 10-digit account number
        Random r = new Random();
        String accNo = "ACC" + (100000000 + r.nextInt(900000000));

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO useraccount(userid,accountnumber,accountbalance,accounttype) VALUES(?,?,?,?)");

            ps.setInt(1, uid);
            ps.setString(2, accNo);
            ps.setDouble(3, balance);
            ps.setString(4, type);

            ps.executeUpdate();
            res.sendRedirect("viewAccount.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


