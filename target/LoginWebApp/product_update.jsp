<%@ page import="entity.Product" %>
<%@ page import="entity.ProductDAO" %>
<%@ page import="java.util.Optional" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String productId = request.getParameter("product_id");
    Product product = null;

    if (productId != null && !productId.isEmpty()) {
        try {
            int id = Integer.parseInt(productId);
            ProductDAO dao = new ProductDAO();
            Optional<Product> optionalProduct = dao.get(id);
            if (optionalProduct.isPresent()) {
                product = optionalProduct.get();
            }
        } catch (NumberFormatException e) {
            // Invalid product ID
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 500px;
            margin: 0 auto;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input, textarea {
            margin-top: 5px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        button {
            margin-top: 20px;
            padding: 10px;
            background-color: #2196F3;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0b7dda;
        }
        .cancel-link {
            margin-top: 10px;
            text-align: center;
        }
        .cancel-link a {
            color: #666;
            text-decoration: none;
        }
        .cancel-link a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
        .read-only {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Update Product</h2>

    <%
        if (product == null) {
    %>
        <div class="error">
            Error: Product not found or Product ID is required
        </div>
        <div class="cancel-link">
            <a href="product_read.jsp">Back to Products</a>
        </div>
    <%
        } else {
    %>

    <form action="product-update" method="post">
        <label for="product_id">Product ID:</label>
        <input type="number" id="product_id" name="product_id" value="<%= product.getProductId() %>" readonly class="read-only">

        <label for="product_name">Product Name:</label>
        <input type="text" id="product_name" name="product_name" maxlength="100" value="<%= product.getProductName() %>" required>

        <label for="product_description">Product Description:</label>
        <textarea id="product_description" name="product_description" maxlength="500"><%= product.getProductDescription() != null ? product.getProductDescription() : "" %></textarea>

        <label for="product_color">Product Color:</label>
        <input type="text" id="product_color" name="product_color" maxlength="50" value="<%= product.getProductColor() != null ? product.getProductColor() : "" %>">

        <label for="product_size">Product Size:</label>
        <input type="text" id="product_size" name="product_size" maxlength="20" value="<%= product.getProductSize() != null ? product.getProductSize() : "" %>">

        <label for="product_price">Product Price:</label>
        <input type="number" id="product_price" name="product_price" step="0.01" min="0" value="<%= product.getProductPrice() %>" required>

        <button type="submit">Update Product</button>
    </form>

    <div class="cancel-link">
        <a href="product_read.jsp">Cancel</a>
    </div>

    <%
        }
    %>
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

