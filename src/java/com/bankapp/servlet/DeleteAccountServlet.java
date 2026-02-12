/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bankapp.servlet;

import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DeleteAccountServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {

        int accid = Integer.parseInt(req.getParameter("accid"));

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM useraccount WHERE accountid=?");

            ps.setInt(1, accid);
            ps.executeUpdate();
            res.sendRedirect("viewAccount.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

