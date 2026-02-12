<%-- 
    Document   : dashboard
    Created on : 2 Jan 2026
    Author     : arjun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Bank Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f6f9;
        }

        /* ===== NAVBAR ===== */
        .navbar {
            background-color: #003366;
            padding: 15px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar h2 {
            color: white;
            margin: 0;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }

        .nav-links a:hover {
            text-decoration: underline;
            color: #ffcc00;
        }

        /* ===== CONTENT ===== */
        .container {
            padding: 40px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 350px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .card a {
            display: block;
            padding: 12px;
            margin: 10px 0;
            background-color: #003366;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }

        .card a:hover {
            background-color: #0059b3;
        }

        .logout {
            background-color: #cc0000 !important;
        }

        .logout:hover {
            background-color: #ff1a1a !important;
        }
    </style>
</head>

<body>

    <!-- ===== NAVBAR ===== -->
    <div class="navbar">
        <h2>Bank Application</h2>
        <div class="nav-links">
            <a href="dashboard.jsp">Dashboard</a>
            <a href="index.html">Logout</a>
        </div>
    </div>

    <!-- ===== DASHBOARD CONTENT ===== -->
    <div class="container">
        <div class="card">
            <h3>Bank Dashboard</h3>

            <a href="createAccount.jsp">Create Bank Account</a>
            <a href="viewAccount.jsp">View Accounts</a>
            <a href="deposit.jsp">Deposit Amount</a>
            <a href="withdraw.jsp">Withdraw Amount</a>
            <a href="transfer.jsp">Transfer Amount</a>
            <a href="transaction.jsp">Transaction History</a>
            <a href="index.html" class="logout">Logout</a>
        </div>
    </div>

</body>
</html>
