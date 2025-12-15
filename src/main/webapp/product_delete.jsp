<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            background-color: #fff3cd;
            border-color: #ffc107;
        }
        h2 {
            color: #333;
        }
        .warning-text {
            color: #856404;
            background-color: #fff3cd;
            padding: 12px;
            border-radius: 4px;
            margin: 20px 0;
            border-left: 4px solid #ffc107;
        }
        .form-group {
            margin: 20px 0;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
        }
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        input:disabled {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        button {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        .btn-delete {
            background-color: #f44336;
            color: white;
        }
        .btn-delete:hover {
            background-color: #da190b;
        }
        .btn-cancel {
            background-color: #666;
            color: white;
            padding: 5px;
            text-decoration: none;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-cancel:hover {
            background-color: #555;
        }
        .error {
            color: #d32f2f;
            margin-top: 10px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Delete Product</h2>

    <%
        String productId = request.getParameter("product_id");
        if (productId == null || productId.isEmpty()) {
    %>
        <div class="error">
            Error: Product ID is required
        </div>
        <div style="margin-top: 20px;">
            <a href="product_read.jsp" style="color: #666; text-decoration: none;">Back to Products</a>
        </div>
    <%
        return;
        }
    %>

    <div class="warning-text">
        <strong>Warning:</strong> This action cannot be undone. Are you sure you want to delete this product?
    </div>

    <form action="product-delete" method="post">
        <div class="form-group">
            <label for="product_id">Product ID:</label>
            <input type="number" id="product_id" name="product_id" value="<%= productId %>" disabled>
            <input type="hidden" name="product_id" value="<%= productId %>">
        </div>

        <div class="button-group">
            <button type="submit" class="btn-delete">Delete Product</button>
            <a href="product_read.jsp" class="btn-cancel">Cancel</a>
        </div>
    </form>
</div>

<%
    String error = request.getParameter("error");
    if (error != null && !error.isEmpty()) {
%>
    <div class="error" style="max-width: 500px; margin: 20px auto;">
        Error: <%= error %>
    </div>
<%
    }
%>

</body>
</html>

