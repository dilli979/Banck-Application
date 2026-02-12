<%-- 
    Document   : createAccount
    Created on : 2 Jan 2026, 9:59:09 pm
    Author     : arjun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Bank Account</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 40%;
            margin: 60px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #0a3d62;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #2c3e50;
        }

        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            width: 100%;
            background: #0a3d62;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background: #075083;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            text-decoration: none;
            font-weight: bold;
            color: #0a3d62;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>Create New Bank Account</h2>

    <form action="CreateAccountServlet" method="post">

        <label>Initial Deposit Amount</label>
        <input type="number" name="balance" required min="0">

        <label>Account Type</label>
        <select name="type">
            <option value="Savings">Savings</option>
            <option value="Current">Current</option>
        </select>

        <input type="submit" value="Create Account">

    </form>

    <a class="back-link" href="dashboard.jsp">← Back to Dashboard</a>

</div>

</body>
</html>
