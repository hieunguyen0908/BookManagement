/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author PC
 */
public class HistoryDTO implements Serializable {
    private int id;
    private UserDTO user;
    private Date buyAt;
    private DiscountDTO discount;
    private float discountPrice;
    private float totalPrice;
    private String status;
}
