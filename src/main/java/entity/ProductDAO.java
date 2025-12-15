package entity;

import core.DB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductDAO implements DAO<Product> {
    private static final String TABLE_NAME = "HD_Product";

    @Override
    public Optional<Product> get(int id) {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE product_id = ?";
        try {
            PreparedStatement pstmt = DB.getInstance().getPreparedStatement(query);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("product_description"),
                        rs.getString("product_color"),
                        rs.getString("product_size"),
                        rs.getDouble("product_price")
                );
                rs.close();
                pstmt.close();
                return Optional.of(product);
            }
            rs.close();
            pstmt.close();
        } catch (SQLException ex) {
            System.err.println("Database Error: " + ex.toString());
        }
        return Optional.empty();
    }

    @Override
    public List<Product> getAll() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM " + TABLE_NAME;
        try {
            ResultSet rs = DB.getInstance().executeQuery(query);

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("product_description"),
                        rs.getString("product_color"),
                        rs.getString("product_size"),
                        rs.getDouble("product_price")
                );
                products.add(product);
            }
            rs.close();
        } catch (SQLException ex) {
            System.err.println("Database Error: " + ex.toString());
        }
        return products;
    }

    @Override
    public void insert(Product product) {
        String query = "INSERT INTO " + TABLE_NAME +
                " (product_id, product_name, product_description, product_color, product_size, product_price) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = DB.getInstance().getPreparedStatement(query);
            pstmt.setInt(1, product.getProductId());
            pstmt.setString(2, product.getProductName());
            pstmt.setString(3, product.getProductDescription());
            pstmt.setString(4, product.getProductColor());
            pstmt.setString(5, product.getProductSize());
            pstmt.setDouble(6, product.getProductPrice());
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Product inserted successfully. Rows affected: " + rowsAffected);
            pstmt.close();
        } catch (SQLException ex) {
            System.err.println("Database Error in insert: " + ex.toString());
            ex.printStackTrace();
            throw new RuntimeException("Failed to insert product: " + ex.getMessage(), ex);
        }
    }

    @Override
    public void update(Product product) {
        String query = "UPDATE " + TABLE_NAME +
                " SET product_name = ?, product_description = ?, product_color = ?, product_size = ?, product_price = ? " +
                "WHERE product_id = ?";
        try {
            PreparedStatement pstmt = DB.getInstance().getPreparedStatement(query);
            pstmt.setString(1, product.getProductName());
            pstmt.setString(2, product.getProductDescription());
            pstmt.setString(3, product.getProductColor());
            pstmt.setString(4, product.getProductSize());
            pstmt.setDouble(5, product.getProductPrice());
            pstmt.setInt(6, product.getProductId());
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Product updated successfully. Rows affected: " + rowsAffected);
            pstmt.close();
        } catch (SQLException ex) {
            System.err.println("Database Error in update: " + ex.toString());
            ex.printStackTrace();
            throw new RuntimeException("Failed to update product: " + ex.getMessage(), ex);
        }
    }

    @Override
    public void delete(Product product) {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE product_id = ?";
        try {
            PreparedStatement pstmt = DB.getInstance().getPreparedStatement(query);
            pstmt.setInt(1, product.getProductId());
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Product deleted successfully. Rows affected: " + rowsAffected);
            pstmt.close();
        } catch (SQLException ex) {
            System.err.println("Database Error in delete: " + ex.toString());
            ex.printStackTrace();
            throw new RuntimeException("Failed to delete product: " + ex.getMessage(), ex);
        }
    }

    @Override
    public List<String> getColumnNames() {
        List<String> columns = new ArrayList<>();
        columns.add("product_id");
        columns.add("product_name");
        columns.add("product_description");
        columns.add("product_color");
        columns.add("product_size");
        columns.add("product_price");
        return columns;
    }
}

