/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.daos;

import hieunnm.dtos.DiscountDTO;
import hieunnm.util.MyConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;

/**
 *
 * @author PC
 */
public class DiscountDAO implements Serializable {
    
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
    
    public boolean insert(DiscountDTO discount) throws NamingException, SQLException {
        boolean check = false;
        try {
            conn = MyConnection.getMyConnection();
            String sql = "INSERT INTO discounts(code, [percent], describe, date, status) VALUES(?, ?, ?, ?, ?)";
            prStm = conn.prepareStatement(sql);
            prStm.setString(1, discount.getCode().toUpperCase());
            prStm.setInt(2, discount.getPercent());
            prStm.setNString(3, discount.getDescribe());
            prStm.setDate(4, (Date) discount.getDate());
            prStm.setString(5, discount.getStatus());
            check = prStm.executeUpdate() > 0;
        } finally {
            closeConn();
        }
        return check;
    }
    
//    public DiscountDTO checkDiscountCode(String discountCode) throws NamingException, SQLException {
//        DiscountDTO discount = null;
//        try {
//            conn = MyConnection.getMyConnection();
//            String sql = "SELECT d.code, d.[percent], d.status, o.discountCode, o.discountPrice "
//                    + "FROM dbo.discounts "
//                    + "AS d JOIN dbo.orders "
//                    + "AS o ON o.discountCode = d.code "
//                    + "WHERE d.code = ? AND d.status = 'not use'";
//            prStm = conn.prepareStatement(sql);
//            prStm.setString(1, discountCode);
//            rs = prStm.executeQuery();
//            while (rs.next()) {
//                discount = new DiscountDTO();
//                discount.setCode(rs.getString("code"));
//                discount.setPercent(rs.getInt("[percent]"));
//                discount.setStatus(rs.getString("status"));
//            }
//        } finally {
//            closeConn();
//        }
//        return discount;
//    }

    public DiscountDTO applyDiscount(String discountCode) throws NamingException, SQLException {
        DiscountDTO discount = null;
        try {
            conn = MyConnection.getMyConnection();
            String sql = "SELECT code, [percent], status "
                    + "FROM dbo.discounts "
                    + "WHERE code = ? AND status = 'not use'";
            prStm = conn.prepareStatement(sql);
            prStm.setString(1, discountCode);
            rs = prStm.executeQuery();
            while (rs.next()) {
                discount = new DiscountDTO();
                discount.setCode(rs.getString("code"));
                discount.setPercent(rs.getInt("[percent]"));
                discount.setStatus(rs.getString("status"));
            }
        } finally {
            closeConn();
        }
        return discount;
    }
    
    public boolean setStatus(String discountCode) throws NamingException, SQLException {
        try {
            conn = MyConnection.getMyConnection();
            String sql = "UPDATE dbo.discounts "
                    + "SET status = 'used' "
                    + "WHERE code = ? AND status = 'not use'";
            prStm = conn.prepareStatement(sql);
            prStm.setString(1, discountCode);
            int rowEffect = prStm.executeUpdate();
            if (rowEffect > 0) {
                return true;
            }
        } finally {
            closeConn();
        }
        return false;
    }
    
    public boolean checkCode(String discountCode) throws NamingException, SQLException {
        boolean check = false;
        try {
            conn = MyConnection.getMyConnection();
            if (conn != null) {
                String sql = "Select code, [percent] "
                        + " FROM dbo.discounts "
                        + " Where code = ? AND status = 'not use'";
                prStm = conn.prepareStatement(sql);
                prStm.setString(1, discountCode);
                rs = prStm.executeQuery();
                while (rs.next()) {
                    check = true;
                    
                }
            }
        } catch (Exception e) {
            
        } finally {
            closeConn();
        }
        return check;
    }
    
}
