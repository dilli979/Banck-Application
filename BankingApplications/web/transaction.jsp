<%-- 
    Document   : transaction
    Created on : 2 Jan 2026
    Author     : arjun
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,com.bankapp.servlet.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Transaction History</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body{
            min-height:100vh;
            background:#f4f7fb;
        }

        /* ===== NAVBAR ===== */
        .navbar{
            background:#003366;
            padding:15px 40px;
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .navbar h2{
            color:#ffffff;
        }

        .navbar a{
            color:#ffffff;
            text-decoration:none;
            font-weight:bold;
        }

        .navbar a:hover{
            text-decoration:underline;
        }

        /* ===== CONTENT ===== */
        .container{
            padding:40px;
        }

        h2{
            text-align:center;
            color:#003366;
            margin-bottom:25px;
        }

        /* ===== TABLE ===== */
        table{
            width:100%;
            max-width:1100px;
            margin:auto;
            border-collapse:collapse;
            background:#ffffff;
            box-shadow:0 10px 25px rgba(0,0,0,0.15);
            border-radius:10px;
            overflow:hidden;
        }

        th, td{
            padding:14px;
            text-align:center;
            border-bottom:1px solid #e0e0e0;
        }

        th{
            background:#003366;
            color:#ffffff;
            text-transform:uppercase;
            font-size:14px;
        }

        tr:nth-child(even){
            background:#f9f9f9;
        }

        tr:hover{
            background:#eef4ff;
        }

        .back{
            display:inline-block;
            margin-top:25px;
            padding:10px 20px;
            background:#003366;
            color:#ffffff;
            text-decoration:none;
            border-radius:6px;
            font-weight:bold;
            transition:0.3s;
        }

        .back:hover{
            background:#0059b3;
        }
    </style>
</head>

<body>

    <!-- ===== NAVBAR ===== -->
    <div class="navbar">
        <h2>Bank Application</h2>
        <a href="dashboard.jsp">Dashboard</a>
    </div>

    <%
    if(session.getAttribute("userid")==null){
        response.sendRedirect("login.jsp");
        return;
    }

    int uid = (int)session.getAttribute("userid");
    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(
        "SELECT ua.accountnumber, at.transtype, at.amount, at.trandate " +
        "FROM account_transaction at " +
        "JOIN useraccount ua ON at.accountid = ua.accountid " +
        "WHERE at.userid=? ORDER BY at.trandate DESC");

    ps.setInt(1, uid);
    ResultSet rs = ps.executeQuery();
    %>

    <!-- ===== TABLE CONTENT ===== -->
    <div class="container">
        <h2>Your Transaction History</h2>

        <table>
            <tr>
                <th>Account Number</th>
                <th>Transaction Type</th>
                <th>Amount (₹)</th>
                <th>Date & Time</th>
            </tr>

            <%
            while(rs.next()){
            %>
            <tr>
                <td><%= rs.getString("accountnumber") %></td>
                <td><%= rs.getString("transtype") %></td>
                <td><%= rs.getDouble("amount") %></td>
                <td><%= rs.getTimestamp("trandate") %></td>
            </tr>
            <% } %>
        </table>

        <center>
            <a href="dashboard.jsp" class="back">← Back to Dashboard</a>
        </center>
    </div>

</body>
</html>
