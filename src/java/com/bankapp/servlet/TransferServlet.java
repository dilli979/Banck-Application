/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class TransferServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        int fromAcc = Integer.parseInt(req.getParameter("fromAcc"));
        String toAccNo = req.getParameter("toAcc");
        double amt = Double.parseDouble(req.getParameter("amt"));

        Connection con = DBConnection.getConnection();

        try {
            con.setAutoCommit(false);

            // Check sender balance
            PreparedStatement check = con.prepareStatement(
                "SELECT accountbalance FROM useraccount WHERE accountid=?");
            check.setInt(1, fromAcc);
            ResultSet rs = check.executeQuery();

            if (!rs.next() || rs.getDouble("accountbalance") < amt) {
                res.getWriter().print("Insufficient Balance!");
                return;
            }

            // Deduct sender
            PreparedStatement ps1 = con.prepareStatement(
                "UPDATE useraccount SET accountbalance = accountbalance - ? WHERE accountid=?");
            ps1.setDouble(1, amt);
            ps1.setInt(2, fromAcc);
            ps1.executeUpdate();

            // Add receiver
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE useraccount SET accountbalance = accountbalance + ? WHERE accountnumber=?");
            ps2.setDouble(1, amt);
            ps2.setString(2, toAccNo);
            int updated = ps2.executeUpdate();

            if (updated == 0) {
                con.rollback();
                res.getWriter().print("Receiver Account Not Found!");
                return;
            }

            // Transaction history
            HttpSession s = req.getSession();
            int uid = (int) s.getAttribute("userid");

            PreparedStatement t1 = con.prepareStatement(
                "INSERT INTO account_transaction(userid,accountid,transtype,amount) VALUES(?,?,?,?)");
            t1.setInt(1, uid);
            t1.setInt(2, fromAcc);
            t1.setString(3, "TRANSFER_OUT");
            t1.setDouble(4, amt);
            t1.executeUpdate();

            PreparedStatement getReceiver = con.prepareStatement(
                "SELECT userid,accountid FROM useraccount WHERE accountnumber=?");
            getReceiver.setString(1, toAccNo);
            ResultSet rr = getReceiver.executeQuery();
            rr.next();

            PreparedStatement t2 = con.prepareStatement(
                "INSERT INTO account_transaction(userid,accountid,transtype,amount) VALUES(?,?,?,?)");
            t2.setInt(1, rr.getInt("userid"));
            t2.setInt(2, rr.getInt("accountid"));
            t2.setString(3, "TRANSFER_IN");
            t2.setDouble(4, amt);
            t2.executeUpdate();

            con.commit();
            res.sendRedirect("viewAccount.jsp");

        } catch (Exception e) {
            try { con.rollback(); } catch(Exception ex) {}
            e.printStackTrace();
        }
    }
}

