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
import java.util.Optional;

@WebServlet("/product-update")
public class ProductUpdateServlet extends HttpServlet {

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
                response.sendRedirect("product_update.jsp?product_id=" + productId + "&error=Product name is required");
                return;
            }

            if (productPrice < 0) {
                response.sendRedirect("product_update.jsp?product_id=" + productId + "&error=Product price cannot be negative");
                return;
            }

            // Check if product exists
            ProductDAO dao = new ProductDAO();
            Optional<Product> existingProduct = dao.get(productId);

            if (existingProduct.isEmpty()) {
                response.sendRedirect("product-read?error=Product not found");
                return;
            }

            // Create updated product object
            Product product = new Product(productId, productName, productDescription,
                                         productColor, productSize, productPrice);

            // Update in database
            dao.update(product);

            // Redirect to product-read servlet which fetches all products and displays them
            response.sendRedirect("product-read?success=Product updated successfully");

        } catch (NumberFormatException ex) {
            response.sendRedirect("product-read?error=Invalid input format");
        } catch (RuntimeException ex) {
            System.err.println("Runtime error during update: " + ex.getMessage());
            ex.printStackTrace();
            response.sendRedirect("product-read?error=Database error: " + ex.getMessage());
        } catch (Exception ex) {
            System.err.println("Error updating product: " + ex.toString());
            ex.printStackTrace();
            response.sendRedirect("product-read?error=An error occurred while updating the product");
        }
    }
}

