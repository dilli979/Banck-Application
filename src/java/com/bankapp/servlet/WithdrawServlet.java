/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class WithdrawServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        int accid = Integer.parseInt(req.getParameter("accid"));
        double amt = Double.parseDouble(req.getParameter("amt"));

        Connection con = DBConnection.getConnection();

        try {
            con.setAutoCommit(false);   // Start DB transaction

            // 1. Check available balance
            PreparedStatement check = con.prepareStatement(
                "SELECT accountbalance FROM useraccount WHERE accountid=?");
            check.setInt(1, accid);
            ResultSet rs = check.executeQuery();

            if (!rs.next() || rs.getDouble("accountbalance") < amt) {
                res.getWriter().print("Insufficient Balance!");
                return;
            }

            // 2. Withdraw amount
            PreparedStatement ps = con.prepareStatement(
                "UPDATE useraccount SET accountbalance = accountbalance - ? WHERE accountid=?");
            ps.setDouble(1, amt);
            ps.setInt(2, accid);
            ps.executeUpdate();

            // 3. Insert transaction history
            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO account_transaction(userid,accountid,transtype,amount) VALUES(?,?,?,?)");

            ps2.setInt(1, (int) req.getSession().getAttribute("userid"));
            ps2.setInt(2, accid);
            ps2.setString(3, "WITHDRAW");
            ps2.setDouble(4, amt);
            ps2.executeUpdate();

            con.commit();   // Save both operations

            res.sendRedirect("viewAccount.jsp");

        } catch (Exception e) {
            try { con.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
        }
    }
}


