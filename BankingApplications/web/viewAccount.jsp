<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,com.bankapp.servlet.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Bank Accounts</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 30px auto;
        }

        .header {
            background: #0a3d62;
            color: #fff;
            padding: 15px 20px;
            border-radius: 6px;
        }

        .header h2 {
            margin: 0;
        }

        .accounts-box {
            background: #fff;
            margin-top: 20px;
            padding: 20px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .account-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 15px;
            background: #fafafa;
        }

        .account-card strong {
            color: #2c3e50;
        }

        .delete-btn {
            display: inline-block;
            margin-top: 10px;
            color: #fff;
            background: #e74c3c;
            padding: 8px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
        }

        .delete-btn:hover {
            background: #c0392b;
        }

        .no-account {
            color: #888;
            text-align: center;
            font-size: 16px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #0a3d62;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<%
    // Session check
    if (session.getAttribute("userid") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int uid = (int) session.getAttribute("userid");
    Connection con = DBConnection.getConnection();

    // Fetch Username
    PreparedStatement psUser = con.prepareStatement(
        "SELECT username FROM userlogin WHERE userid=?");
    psUser.setInt(1, uid);
    ResultSet rsUser = psUser.executeQuery();

    String uname = "";
    if (rsUser.next()) {
        uname = rsUser.getString("username");
    }
%>

<div class="container">

    <div class="header">
        <h2>Welcome, <%= uname %> 👋</h2>
        <p>Your Bank Accounts</p>
    </div>

    <div class="accounts-box">

        <%
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM useraccount WHERE userid=?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
        %>
            <p class="no-account">No bank accounts found.</p>
        <%
            } else {
                while (rs.next()) {
        %>

        <div class="account-card">
            <p><strong>Account Number:</strong> <%= rs.getString("accountnumber") %></p>
            <p><strong>Account Type:</strong> <%= rs.getString("accounttype") %></p>
            <p><strong>Balance:</strong> ₹ <%= rs.getDouble("accountbalance") %></p>

            <a class="delete-btn"
               href="DeleteAccountServlet?accid=<%= rs.getInt("accountid") %>"
               onclick="return confirm('Are you sure you want to delete this account?');">
                Delete Account
            </a>
        </div>

        <%
                }
            }
        %>

        <a class="back-link" href="dashboard.jsp">← Back to Dashboard</a>

    </div>

</div>

</body>
</html>
