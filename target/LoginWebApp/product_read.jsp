<%@ page import="java.util.*" %>
<%@ page import="entity.Product" %>
<%@ page import="entity.ProductDAO" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get products from request attribute (populated by ProductReadServlet)
    List<Product> products = (List<Product>) request.getAttribute("products");

    // Fallback: if products is null (direct access to JSP), fetch from database
    if (products == null) {
        ProductDAO dao = new ProductDAO();
        products = dao.getAll();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        h2 {
            color: #333;
        }
        .button-group {
            margin-bottom: 20px;
        }
        .btn {
            padding: 10px 15px;
            margin-right: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-create {
            background-color: #4CAF50;
            color: white;
        }
        .btn-create:hover {
            background-color: #45a049;
        }
        .btn-logout {
            background-color: #f44336;
            color: white;
        }
        .btn-logout:hover {
            background-color: #da190b;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 12px;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .action-buttons {
            white-space: nowrap;
        }
        .btn-edit {
            background-color: #2196F3;
            color: white;
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 3px;
            margin-right: 5px;
        }
        .btn-edit:hover {
            background-color: #0b7dda;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
            padding: 6px 10px;
            text-decoration: none;
            border-radius: 3px;
        }
        .btn-delete:hover {
            background-color: #da190b;
        }
        .no-products {
            padding: 20px;
            text-align: center;
            color: #666;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Products</h2>

    <div class="button-group">
        <a href="product_create.jsp" class="btn btn-create">+ Create New Product</a>
        <a href="logout" class="btn btn-logout">Logout</a>
    </div>

    <%
        String success = request.getParameter("success");
        if (success != null && !success.isEmpty()) {
    %>
        <div class="success">
            <%= success %>
        </div>
    <%
        }
    %>

    <!-- Note: This table will display products from the database -->
    <!-- You need to implement the backend servlet/database logic to populate this table -->
    <table>
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Description</th>
            <th>Color</th>
            <th>Size</th>
            <th>Price</th>
            <th>Actions</th>
        </tr>
        <%
            if (products != null && !products.isEmpty()) {
                for (Product product : products) {
        %>
        <tr>
            <td><%= product.getProductId() %></td>
            <td><%= product.getProductName() %></td>
            <td><%= product.getProductDescription() != null ? product.getProductDescription() : "" %></td>
            <td><%= product.getProductColor() != null ? product.getProductColor() : "" %></td>
            <td><%= product.getProductSize() != null ? product.getProductSize() : "" %></td>
            <td>$<%= String.format("%.2f", product.getProductPrice()) %></td>
            <td class="action-buttons">
                <a href="product_update.jsp?product_id=<%= product.getProductId() %>" class="btn-edit">Edit</a>
                <a href="product_delete.jsp?product_id=<%= product.getProductId() %>" class="btn-delete">Delete</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7" class="no-products">No products found. <a href="product_create.jsp">Create one now</a></td>
        </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>

