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

@WebServlet("/product-delete")
public class ProductDeleteServlet extends HttpServlet {

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
            // Get product ID from form
            int productId = Integer.parseInt(request.getParameter("product_id"));

            // Get product DAO
            ProductDAO dao = new ProductDAO();

            // Check if product exists
            Optional<Product> product = dao.get(productId);

            if (product.isEmpty()) {
                response.sendRedirect("product-read?error=Product not found");
                return;
            }

            // Delete product from database
            dao.delete(product.get());

            // Redirect to product-read servlet which fetches all products and displays them
            response.sendRedirect("product-read?success=Product deleted successfully");

        } catch (NumberFormatException ex) {
            response.sendRedirect("product-read?error=Invalid product ID");
        } catch (RuntimeException ex) {
            System.err.println("Runtime error during delete: " + ex.getMessage());
            ex.printStackTrace();
            response.sendRedirect("product-read?error=Database error: " + ex.getMessage());
        } catch (Exception ex) {
            System.err.println("Error deleting product: " + ex.toString());
            ex.printStackTrace();
            response.sendRedirect("product-read?error=An error occurred while deleting the product");
        }
    }
}

