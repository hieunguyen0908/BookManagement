/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.servlets;

import hieunnm.daos.DiscountDAO;
import hieunnm.dtos.DiscountDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author PC
 */
@WebServlet(name = "CreateDiscountCodeServlet", urlPatterns = {"/CreateDiscountCodeServlet"})
public class CreateDiscountCodeServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class);
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String ERROR_PAGE = "error.jsp";
    private static final String CREATE_DISCOUNT_CODE_PAGE = "createDiscountCode.jsp";
    private static final String CREATE_DISCOUNT_CODE_SUCCESS_PAGE = "createDiscountCodeSuccessful.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, NumberFormatException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR_PAGE;
        try {

            String code = request.getParameter("txtCode");
            String percentDiscountStr = request.getParameter("txtPercentDiscount");
            int percentDiscount = Integer.parseInt(percentDiscountStr);
            String description = request.getParameter("txtDescription");
            java.sql.Date createAt = java.sql.Date.valueOf(LocalDate.now());
            String defaultStatus = "not use";

            DiscountDTO discount = new DiscountDTO(code, percentDiscount, description, createAt, defaultStatus);

            DiscountDAO discountDAO = new DiscountDAO();

            discountDAO.insert(discount);
            HttpSession session = request.getSession();
            request.setAttribute("CODE", code);
            request.setAttribute("PERCENT_DISCOUNT", percentDiscountStr);
            request.setAttribute("MSG_SUCCESS", "Ban vua tao code giam gia thanh cong");
//            url = CREATE_DISCOUNT_CODE_PAGE;
            url = CREATE_DISCOUNT_CODE_SUCCESS_PAGE;

        } catch (Exception ex) {
            LOGGER.error(ex.getMessage());
            request.setAttribute("ERROR", "Something was wrong here");
            url = ERROR_PAGE;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(CreateDiscountCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            java.util.logging.Logger.getLogger(CreateDiscountCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CreateDiscountCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException ex) {
            java.util.logging.Logger.getLogger(CreateDiscountCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NumberFormatException ex) {
            java.util.logging.Logger.getLogger(CreateDiscountCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(CreateDiscountCodeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
}
