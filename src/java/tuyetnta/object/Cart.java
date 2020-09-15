/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tuyetnta.object;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.naming.NamingException;
import tuyetnta.daos.OrderDAO;
import tuyetnta.dtos.BookDTO;
import tuyetnta.dtos.UserDTO;

/**
 *
 * @author tuyet
 */
public class Cart extends HashMap<String, BookDTO> implements Serializable {

    private UserDTO owner;

    public Cart() {
    }

    public float getTotalPrice() {
        float price = 0;
        for (Entry<String, BookDTO> book : this.entrySet()) {
            price += book.getValue().getPrice() * book.getValue().getQuantity();
        }
        return price;
    }

    public UserDTO getOwner() {
        return owner;
    }

    public void setOwner(UserDTO owner) {
        this.owner = owner;
    }

    public boolean confirm() throws SQLException, NamingException {
        OrderDAO dao = new OrderDAO();
        if (dao.confirmOrder(this)) {
            this.clear();
            return true;
        }
        return false;
    }

    public Map<String, BookDTO> checkQuantity() throws NamingException, SQLException {
        OrderDAO dao = new OrderDAO();
        return dao.checkQuantity(this);
    }
}
