<%
    // 'session' is an implicit JSP variable (type HttpSession)
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        p {
            color: #666;
            font-size: 16px;
            margin: 15px 0;
        }
        .welcome-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 25px;
            text-align: center;
        }
        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin: 30px 0;
        }
        .nav-links a {
            display: inline-block;
            padding: 12px 20px;
            margin: 10px 0;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            text-align: center;
            transition: background-color 0.3s;
        }
        .nav-links a:hover {
            background-color: #45a049;
        }
        .logout-link {
            display: inline-block;
            padding: 10px 15px;
            margin-top: 25px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            text-align: center;
            width: 100%;
            box-sizing: border-box;
            transition: background-color 0.3s;
        }
        .logout-link:hover {
            background-color: #da190b;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Welcome, <%= session.getAttribute("user") %>!</h2>

    <div class="welcome-message">
        <p>You are now logged in.</p>
    </div>

    <div class="nav-links">
        <a href="product-read">View Created Products</a>
        <a href="product_create.jsp">Create a new Product</a>
    </div>

    <a href="logout" class="logout-link">Logout</a>
</div>

</body>
</html>