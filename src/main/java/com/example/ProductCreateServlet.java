package com.example;

import entity.Product;
import entity.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/product-create")
public class ProductCreateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form parameters
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String productName = request.getParameter("product_name");
            String productDescription = request.getParameter("product_description");
            String productColor = request.getParameter("product_color");
            String productSize = request.getParameter("product_size");
            double productPrice = Double.parseDouble(request.getParameter("product_price"));

            // Validate required fields
            if (productName == null || productName.trim().isEmpty()) {
                response.sendRedirect("product_create.jsp?error=Product name is required");
                return;
            }

            if (productPrice < 0) {
                response.sendRedirect("product_create.jsp?error=Product price cannot be negative");
                return;
            }

            // Create product object
            Product product = new Product(productId, productName, productDescription,
                                         productColor, productSize, productPrice);

            // Insert into database
            ProductDAO dao = new ProductDAO();
            try {
                dao.insert(product);
            } catch (RuntimeException runtimeEx) {
                System.err.println("Runtime error during insert: " + runtimeEx.getMessage());
                runtimeEx.printStackTrace();
                response.sendRedirect("product_create.jsp?error=Database error: " + runtimeEx.getMessage());
                return;
            }

            // Redirect to product-read servlet which fetches all products and displays them
            response.sendRedirect("product-read?success=Product created successfully");

        } catch (NumberFormatException ex) {
            response.sendRedirect("product_create.jsp?error=Invalid input format");
        } catch (Exception ex) {
            System.err.println("Error creating product: " + ex.toString());
            ex.printStackTrace();
            response.sendRedirect("product_create.jsp?error=An error occurred while creating the product");
        }
    }
}

