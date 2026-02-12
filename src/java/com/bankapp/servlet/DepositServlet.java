/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DepositServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        int accid = Integer.parseInt(req.getParameter("accid"));
        double amt = Double.parseDouble(req.getParameter("amt"));

        Connection con = DBConnection.getConnection();

        try {
            con.setAutoCommit(false); // Start transaction

            // 1. Update Balance
            PreparedStatement ps = con.prepareStatement(
                "UPDATE useraccount SET accountbalance = accountbalance + ? WHERE accountid=?");
            ps.setDouble(1, amt);
            ps.setInt(2, accid);
            ps.executeUpdate();

            // 2. Insert Transaction Record
            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO account_transaction(userid,accountid,transtype,amount) VALUES(?,?,?,?)");

            ps2.setInt(1, (int) req.getSession().getAttribute("userid"));
            ps2.setInt(2, accid);
            ps2.setString(3, "DEPOSIT");
            ps2.setDouble(4, amt);
            ps2.executeUpdate();

            con.commit(); // Save everything

            res.sendRedirect("viewAccount.jsp");

        } catch (Exception e) {
            try { con.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
        }
    }
}



