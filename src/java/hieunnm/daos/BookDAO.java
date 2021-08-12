/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import org.apache.log4j.Logger;
import hieunnm.dtos.BookDTO;
import hieunnm.dtos.CategoryDTO;
import hieunnm.util.MyConnection;

/**
 *
 * @author PC
 */
public class BookDAO implements Serializable {

    private Connection conn = null;
    private PreparedStatement prStm = null;
    private ResultSet rs = null;

    private void closeConn() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (prStm != null) {
            prStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public List<BookDTO> search(String title, Integer min, Integer max, String category) throws SQLException, NamingException {
        List<BookDTO> listBook = new ArrayList<>();
        try {
            conn = MyConnection.getMyConnection();
            //search title (category = all)
            String sql = "SELECT b.id , b.title ,b.image ,b.describe ,b.price ,b.author ,b.importDate ,b.quantity ,c.name AS categoryName FROM dbo.books AS b JOIN dbo.categorys AS c ON c.id = b.cateID "
                    + "WHERE (b.title LIKE ? COLLATE Latin1_General_CI_AI) AND b.status = 'active' AND (? IS NULL OR c.name = ?) AND (? IS NULL OR b.price >= ?) AND (? IS NULL OR b.price <= ?) AND b.quantity > 0 ORDER BY b.title";
            prStm = conn.prepareStatement(sql);
            prStm.setNString(1, "%" + title + "%");
            prStm.setObject(2, category, Types.NVARCHAR);
            prStm.setObject(3, category, Types.NVARCHAR);
            prStm.setObject(4, min, Types.INTEGER);
            prStm.setObject(5, min, Types.INTEGER);
            prStm.setObject(6, max, Types.INTEGER);
            prStm.setObject(7, max, Types.INTEGER);
            rs = prStm.executeQuery();
            while (rs.next()) {
                BookDTO book = new BookDTO();
                book.setId(rs.getString("id"));
                book.setTitle(rs.getNString("title"));
                book.setImage(rs.getString("image"));
                book.setDescribe(rs.getNString("describe"));
                book.setPrice(rs.getFloat("price"));
                book.setAuthor(rs.getNString("author"));
                book.setCategory(new CategoryDTO(rs.getNString("categoryName")));
                book.setImportDate(rs.getDate("importDate"));
                book.setQuantity(rs.getInt("quantity"));
                listBook.add(book);
            }
        } finally {
            closeConn();
        }
        return listBook;
    }
    
    
    public List<BookDTO> searchAdmin(String title, Integer min, Integer max, String category) throws SQLException, NamingException {
        List<BookDTO> listBook = new ArrayList<>();
        try {
            conn = MyConnection.getMyConnection();
            //search title (category = all)
            String sql = "SELECT b.id , b.title ,b.image ,b.describe ,b.price ,b.author ,b.importDate ,b.quantity ,c.name AS categoryName FROM dbo.books AS b JOIN dbo.categorys AS c ON c.id = b.cateID "
                    + "WHERE (b.title LIKE ? COLLATE Latin1_General_CI_AI) AND b.status = 'active' AND (? IS NULL OR c.name = ?) AND (? IS NULL OR b.price >= ?) AND (? IS NULL OR b.price <= ?) AND b.quantity >= 0 ORDER BY b.title";
            prStm = conn.prepareStatement(sql);
            prStm.setNString(1, "%" + title + "%");
            prStm.setObject(2, category, Types.NVARCHAR);
            prStm.setObject(3, category, Types.NVARCHAR);
            prStm.setObject(4, min, Types.INTEGER);
            prStm.setObject(5, min, Types.INTEGER);
            prStm.setObject(6, max, Types.INTEGER);
            prStm.setObject(7, max, Types.INTEGER);
            rs = prStm.executeQuery();
            while (rs.next()) {
                BookDTO book = new BookDTO();
                book.setId(rs.getString("id"));
                book.setTitle(rs.getNString("title"));
                book.setImage(rs.getString("image"));
                book.setDescribe(rs.getNString("describe"));
                book.setPrice(rs.getFloat("price"));
                book.setAuthor(rs.getNString("author"));
                book.setCategory(new CategoryDTO(rs.getNString("categoryName")));
                book.setImportDate(rs.getDate("importDate"));
                book.setQuantity(rs.getInt("quantity"));
                listBook.add(book);
            }
        } finally {
            closeConn();
        }
        return listBook;
    }
    

    public boolean delete(String id) throws NamingException, SQLException {
        try {
            conn = MyConnection.getMyConnection();
            String sql = "UPDATE dbo.books SET status = 'inactive' WHERE id = ? and status = 'active'";
            prStm = conn.prepareStatement(sql);
            prStm.setString(1, id);
            int rowEffect = prStm.executeUpdate();
            if (rowEffect > 0) {
                return true;
            }
        } finally {
            closeConn();
        }
        return false;
    }

    public boolean update(BookDTO book) throws SQLException, NamingException {
        try {
            conn = MyConnection.getMyConnection();
            String sql = "UPDATE dbo.books SET title = ?, image = ?, describe = ?, price = ?, author = ?, importDate = ?, quantity = ?, cateID = ? WHERE id = ? AND status ='active'";
            prStm = conn.prepareStatement(sql);
            prStm.setNString(1, book.getTitle());
            prStm.setString(2, book.getImage());
            prStm.setNString(3, book.getDescribe());
            prStm.setFloat(4, book.getPrice());
            prStm.setNString(5, book.getAuthor());
            prStm.setDate(6, book.getImportDate());
            prStm.setInt(7, book.getQuantity());
            prStm.setInt(8, book.getCategory().getId());
            prStm.setString(9, book.getId());
            int rowEffect = prStm.executeUpdate();
            if (rowEffect > 0) {
                return true;
            }
        } finally {
            closeConn();
        }
        return false;
    }

    public boolean insert(BookDTO book) throws NamingException, SQLException {
        boolean check = false;
        try {
            conn = MyConnection.getMyConnection();
            String sql = "INSERT INTO books(id, title, image, describe, price, author, cateID, importDate, quantity, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            prStm = conn.prepareStatement(sql);
            prStm.setString(1, book.getId());
            prStm.setNString(2, book.getTitle());
            prStm.setString(3, book.getImage());
            prStm.setNString(4, book.getDescribe());
            prStm.setFloat(5, book.getPrice());
            prStm.setNString(6, book.getAuthor());
            prStm.setNString(7, book.getCategory().getName());
            prStm.setDate(8, book.getImportDate());
            prStm.setInt(9, book.getQuantity());
            prStm.setString(10, book.getStatus());
            check = prStm.executeUpdate() > 0;
        } finally {
            closeConn();
        }
        return check;
    }
}
