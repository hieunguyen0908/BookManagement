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
import javax.naming.NamingException;
import hieunnm.dtos.RoleDTO;
import hieunnm.dtos.UserDTO;
import hieunnm.util.MyConnection;

/**
 *
 * @author PC
 */
public class UserDAO implements Serializable {

    private Connection conn = null;
    private PreparedStatement prStm = null;
    private ResultSet rs = null;

    private void closeConn() {
        try {

            if (rs != null) {
                rs.close();
            }
            if (prStm != null) {
                prStm.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
        }
    }

    public UserDTO checkLogin(String id, String password) throws NamingException, SQLException {
        UserDTO user = null;
        try {
            conn = MyConnection.getMyConnection();
            String sql = "SELECT u.id, u.fullname, r.name "
                    + "AS roleName FROM dbo.users "
                    + "AS u JOIN dbo.roles "
                    + "AS r ON r.id = u.idRole "
                    + "WHERE u.id = ? AND u.password = ? AND u.status = 'active'";
            prStm = conn.prepareStatement(sql);
            prStm.setString(1, id);
            prStm.setString(2, password);
            rs = prStm.executeQuery();
            if (rs.next()) {
                user = new UserDTO();
                user.setId(rs.getString("id"));
                user.setFullname(rs.getNString("fullname"));
                user.setRole(new RoleDTO(rs.getString("roleName")));
            }
        } finally {
            closeConn();
        }
        return user;
    }
    
}
