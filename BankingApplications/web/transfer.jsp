<%-- 
    Document   : transfer
    Created on : 2 Jan 2026
    Author     : arjun
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,com.bankapp.servlet.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Transfer Money</title>

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

        /* ===== FORM CONTAINER ===== */
        .container{
            display:flex;
            justify-content:center;
            align-items:center;
            height:calc(100vh - 70px);
        }

        .card{
            background:#ffffff;
            width:450px;
            padding:35px;
            border-radius:12px;
            box-shadow:0 10px 25px rgba(0,0,0,0.15);
        }

        .card h2{
            text-align:center;
            color:#003366;
            margin-bottom:25px;
        }

        label{
            font-weight:bold;
            color:#333;
        }

        select,
        input[type="text"],
        input[type="number"]{
            width:100%;
            padding:12px;
            margin-top:8px;
            margin-bottom:20px;
            border-radius:6px;
            border:1px solid #ccc;
        }

        .btn{
            width:100%;
            padding:14px;
            background:#003366;
            color:#ffffff;
            border:none;
            border-radius:8px;
            font-size:16px;
            font-weight:bold;
            cursor:pointer;
            transition:0.3s;
        }

        .btn:hover{
            background:#0059b3;
        }

        .back{
            display:block;
            text-align:center;
            margin-top:20px;
            text-decoration:none;
            font-weight:bold;
            color:#003366;
        }

        .back:hover{
            text-decoration:underline;
        }
    </style>
</head>

<body>

    <!-- ===== NAVBAR ===== -->
    <div class="navbar">
        <h2>Bank Application</h2>
        <a href="dashboard.jsp">Dashboard</a>
    </div>

    <!-- ===== TRANSFER FORM ===== -->
    <div class="container">
        <div class="card">
            <h2>Transfer Money</h2>

            <%
            if (session.getAttribute("userid") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int uid = (int) session.getAttribute("userid");
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT accountid, accountnumber FROM useraccount WHERE userid=?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            %>

            <form action="TransferServlet" method="post">

                <label>From Account</label>
                <select name="fromAcc" required>
                    <%
                    while (rs.next()) {
                    %>
                        <option value="<%= rs.getInt("accountid") %>">
                            <%= rs.getString("accountnumber") %>
                        </option>
                    <%
                    }
                    %>
                </select>

                <label>To Account Number</label>
                <input type="text" name="toAcc" required>

                <label>Amount</label>
                <input type="number" name="amt" required min="1">

                <input type="submit" value="Transfer" class="btn">
            </form>

            <a href="dashboard.jsp" class="back">← Back to Dashboard</a>
        </div>
    </div>

</body>
</html>
