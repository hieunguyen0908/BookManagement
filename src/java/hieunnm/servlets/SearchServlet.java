/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import hieunnm.daos.BookDAO;
import hieunnm.daos.CategoryDAO;
import hieunnm.dtos.BookDTO;
import hieunnm.dtos.CategoryDTO;

/**
 *
 * @author PC
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SearchServlet.class);
    private static final String ERROR_PAGE = "error.jsp";
    private static final String SEARCH_PAGE = "search.jsp";

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
        request.setCharacterEncoding("UTF-8");
        String url = ERROR_PAGE;
        try {
            // get ALL Categories
            List<CategoryDTO> cats = getAllCategory();
            request.setAttribute("CATE_LIST", cats);

            // data
            String minMoneyS = request.getParameter("txtMin");
            String maxMoneyS = request.getParameter("txtMax");
            String title = request.getParameter("txtTitle");
            String category = request.getParameter("categorys");

            BookDAO bookDao = new BookDAO();

            if (minMoneyS == null && maxMoneyS == null && title == null && category == null) {
                // get all
                List<BookDTO> listBook = bookDao.search("", null, null, null);
                if (listBook != null) {
                    request.setAttribute("SEARCH_RESULT", listBook);
                }
 
            } else {
                // if not filled min and max
                if (minMoneyS.isEmpty()) {
                    minMoneyS = "0";
                }
                if (maxMoneyS.isEmpty()) {
                    maxMoneyS = "0";
                }
                try {
                    // money data 
                    Integer minMoney;
                    Integer maxMoney;
                    if (minMoneyS.equals("0") && maxMoneyS.equals("0")) {
                        minMoney = null;
                        maxMoney = null;
                    } else {
                        minMoney = Integer.parseInt(minMoneyS);
                        maxMoney = Integer.parseInt(maxMoneyS);
                    }
                    if (minMoney != null & maxMoney != null && minMoney > maxMoney) {
                        request.setAttribute("MSG_ERROR", "Max Money must be greater than Min Money.");
                    } else {
                        // category data
                        if (category.equals("all") || category.isEmpty()) {
                            category = null;
                        }

                        // Search Data
                        List<BookDTO> listBook = bookDao.search(title, minMoney, maxMoney, category);
                        if (listBook != null) {
                            request.setAttribute("SEARCH_RESULT", listBook);
                        }
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("MSG_ERROR", "Min Money and Max Money must be a number.");
                }
            }

            url = SEARCH_PAGE;
        } catch (SQLException | NamingException | NullPointerException ex) {
            LOGGER.error(ex.getMessage());
            request.setAttribute("ERROR", "Something was wrong here");
            url = ERROR_PAGE;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    private List<CategoryDTO> getAllCategory() throws SQLException, NamingException {
        CategoryDAO cateDao = new CategoryDAO();
        return cateDao.getAllCate();
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
