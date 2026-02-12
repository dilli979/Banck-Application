<%-- 
    Document   : register
    Created on : 2 Jan 2026
    Author     : arjun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>

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

        /* ===== REGISTER CARD ===== */
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

        input[type="text"],
        input[type="email"],
        input[type="password"]{
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

        .login{
            text-align:center;
            margin-top:20px;
            font-size:14px;
        }

        .login a{
            color:#003366;
            font-weight:bold;
            text-decoration:none;
        }

        .login a:hover{
            text-decoration:underline;
        }
    </style>
</head>

<body>

    <!-- ===== NAVBAR ===== -->
    <div class="navbar">
        <h2>Bank Application</h2>
        <a href="index.html">Home</a>
    </div>

    <!-- ===== REGISTER FORM ===== -->
    <div class="container">
        <div class="card">
            <h2>User Registration</h2>

            <form action="RegisterServlet" method="post">

                <label>Username</label>
                <input type="text" name="username" required>

                <label>Email</label>
                <input type="email" name="email" required>

                <label>Password</label>
                <input type="password" name="password" required>

                <input type="submit" value="Register" class="btn">
            </form>

            <div class="login">
                Already Registered?
                <a href="login.jsp">Login</a>
            </div>
        </div>
    </div>

</body>
</html>
