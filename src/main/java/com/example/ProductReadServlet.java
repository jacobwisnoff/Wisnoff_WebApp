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
import java.util.List;

@WebServlet("/product-read")
public class ProductReadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Retrieve all products from database
            ProductDAO dao = new ProductDAO();
            List<Product> products = dao.getAll();

            // Set products as request attribute
            request.setAttribute("products", products);

            // Forward to product_read.jsp
            request.getRequestDispatcher("product_read.jsp").forward(request, response);

        } catch (Exception ex) {
            System.err.println("Error: " + ex.toString());
            response.sendRedirect("product_read.jsp?error=An error occurred while retrieving products");
        }
    }
}

