/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.servlets;

import hieunnm.daos.BookDAO;
import hieunnm.daos.DiscountDAO;
import hieunnm.dtos.BookDTO;
import hieunnm.dtos.CategoryDTO;
import hieunnm.dtos.DiscountDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "ApplyDiscountCodeServlet", urlPatterns = {"/ApplyDiscountCodeServlet"})
public class ApplyDiscountCodeServlet extends HttpServlet {

    private static final String VIEWCART_PAGE = "viewCart.jsp";
    private static final String ERROR_PAGE = "error.jsp";
    private static final Logger LOGGER = Logger.getLogger(UpdateServlet.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR_PAGE;
        try {
            String code = request.getParameter("txtCode");
            int percentDiscount = 0;
            String status = "";
            DiscountDAO discountDAO = new DiscountDAO();
            boolean checkCode = discountDAO.checkCode(code);  // Nhap code dung => true, nguoc lai => false
            if (checkCode) {
                request.setAttribute("MSG_CODE_SUCCESS", "Su dung code giam gia thanh cong");
            } else {
                request.setAttribute("MSG_CODE_ERROR", "Code khong hop le hoac da duoc su dung");
            }
            url = VIEWCART_PAGE;
        } catch (NamingException | SQLException | NumberFormatException ex) {
            LOGGER.error(ex.getMessage());
            request.setAttribute("ERROR", ex.getMessage());
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
        processRequest(request, response);
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
