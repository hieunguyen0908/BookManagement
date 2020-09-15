/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tuyetnta.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.naming.NamingException;
import tuyetnta.dtos.BookDTO;
import tuyetnta.object.Cart;
import tuyetnta.util.MyConnection;

/**
 *
 * @author tuyet
 */
public class OrderDAO implements Serializable {

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

    public boolean confirmOrder(Cart cart) throws SQLException, NamingException {
        try {
            conn = MyConnection.getMyConnection();
            conn.setAutoCommit(false);
            String sqlOrder = "INSERT INTO dbo.orders ( userID ,buyAt ,discountCode ,discountPrice ,totalPrice ,status)VALUES  ( ? , GETDATE() , null , null , ? , 'not pay' )";
            prStm = conn.prepareStatement(sqlOrder, new String[]{"id"});
            prStm.setString(1, cart.getOwner().getId());
            prStm.setFloat(2, cart.getTotalPrice());
            int rowEffect = prStm.executeUpdate();
            if (rowEffect == 0) {
                conn.rollback();
                return false;
            }
            rs = prStm.getGeneratedKeys();
            int oderId = -1;
            if (rs.next()) {
                // get orderId
                oderId = rs.getInt(1);
            } else {
                conn.rollback();
                return false;
            }

            // add detail
            String sqlOrderDetail = "INSERT INTO dbo.orderDetails ( orderID, bookID, quantity, price ) VALUES  ( ?, ?, ?, ?)";
            for (Map.Entry<String, BookDTO> book : cart.entrySet()) {
                prStm = conn.prepareStatement(sqlOrderDetail);
                prStm.setInt(1, oderId);
                prStm.setString(2, book.getValue().getId());
                prStm.setInt(3, book.getValue().getQuantity());
                prStm.setFloat(4, book.getValue().getQuantity());
                rowEffect = prStm.executeUpdate();
                if (rowEffect == 0) {
                    conn.rollback();
                    return false;
                }
            }

            String sqlDecreaseQuantity = "UPDATE dbo.books SET quantity = quantity - ? WHERE id = ?";
            for (Map.Entry<String, BookDTO> book : cart.entrySet()) {
                prStm = conn.prepareStatement(sqlDecreaseQuantity);
                prStm.setInt(1, book.getValue().getQuantity());
                prStm.setString(2, book.getKey());
                rowEffect = prStm.executeUpdate();
                if (rowEffect == 0) {
                    conn.rollback();
                    return false;
                }
            }
            conn.commit();
            return true;
        } finally {
            closeConn();
        }
    }

    public Map<String, BookDTO> checkQuantity(Cart cart) throws NamingException, SQLException {
        Map<String, BookDTO> invalidList = new HashMap();
        try {
            conn = MyConnection.getMyConnection();
            String sql = "SELECT quantity FROM dbo.books WHERE id = ? AND status ='active'";
            for (Map.Entry<String, BookDTO> book : cart.entrySet()) {
                prStm = conn.prepareStatement(sql);
                prStm.setString(1, book.getKey());
                rs = prStm.executeQuery();
                if (rs.next()) {
                    int quan = rs.getInt("quantity");
                    if (quan < book.getValue().getQuantity()) {
                        BookDTO bo = new BookDTO();
                        bo.setId(book.getKey());
                        bo.setTitle(book.getValue().getTitle());
                        bo.setQuantity(quan);
                        invalidList.put(book.getKey(), bo);
                    }
                } else {
                    BookDTO bo = new BookDTO();
                    bo.setId(book.getKey());
                    bo.setTitle(book.getValue().getTitle());
                    bo.setQuantity(-1);
                    invalidList.put(book.getKey(), bo);
                }
            }
        } finally {
            closeConn();
        }
        return invalidList;
    }
}
