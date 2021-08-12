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
public class DiscountDTO implements Serializable {

    private String code;
    private int percent;
    private String describe;
    private Date date;
    private String status;

    public DiscountDTO() {
    }

    public DiscountDTO(String code) {
        this.code = code;
    }

    public DiscountDTO(String code, int percent) {
        this.code = code;
        this.percent = percent;
    }

    public DiscountDTO(String code, int percent, String status) {
        this.code = code;
        this.percent = percent;
        this.status = status;
    }
    
    

    public DiscountDTO(String code, int percent, String describe, Date date, String status) {
        this.code = code;
        this.percent = percent;
        this.describe = describe;
        this.date = date;
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getPercent() {
        return percent;
    }

    public void setPercent(int percent) {
        this.percent = percent;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
