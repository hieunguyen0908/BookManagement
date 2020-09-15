/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tuyetnta.servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tuyetnta.daos.BookDAO;
import tuyetnta.dtos.BookDTO;
import tuyetnta.dtos.CategoryDTO;
import tuyetnta.dtos.RoleDTO;
import tuyetnta.dtos.UserDTO;

/**
 *
 * @author tuyet
 */
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

    Pattern titlePattern = Pattern.compile("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀẾỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.]{1,100}$");
    Pattern authorPattern = Pattern.compile("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀẾỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.]{3,50}$");
    Pattern describePattern = Pattern.compile("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀẾỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.]{0,300}$");
    private static final String SEARCH_CONTROLLER = "SearchServlet";
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
            String id = request.getParameter("txtId");
            String title = request.getParameter("txtTitleUpdate");
            String image = request.getParameter("txtImage");
            String describe = request.getParameter("txtDescribe");
            float price = Float.parseFloat(request.getParameter("txtPrice"));
            String author = request.getParameter("txtAuthor");
            int catId = Integer.parseInt(request.getParameter("categoryUpdate"));
            String importDate = request.getParameter("txtImportDate");
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
            List<String> error = new ArrayList<>();
            if (title.isEmpty()) {
                error.add("Title cannot empty");
            }
            if (!titlePattern.matcher(title).matches()) {
                error.add("Title only contains alphabet chars and range 1-100 chars");
            }
            if (!describePattern.matcher(describe).matches()) {
                error.add("Describe only contains alphabet chars");
                if (!describe.isEmpty() && describe.length() > 300) {
                    error.add("Too long...");
                }
            }
            if (!authorPattern.matcher(author).matches()) {
                error.add("Author only contains alphabet chars and range 3-50");
            }
            if (!error.isEmpty()) {
                request.setAttribute("MSG_ERROR", error);
            } else {
                BookDAO dao = new BookDAO();
                BookDTO book = new BookDTO();
                book.setId(id);
                book.setTitle(title);
                book.setImage(image);
                book.setDescribe(describe);
                book.setPrice(price);
                book.setAuthor(author);
                
                CategoryDTO cateDto = new CategoryDTO();
                cateDto.setId(catId);
                
                book.setCategory(cateDto);
                book.setImportDate(Date.valueOf(importDate));
                book.setQuantity(quantity);
                if (dao.update(book)) {
                    request.setAttribute("MSG_SUCCESS", "Update success");
                } else {
                    request.setAttribute("MSG_ERROR", "Book not found");
                }
            }
            url = SEARCH_CONTROLLER;
        } catch (SQLException | NamingException | NumberFormatException ex) {
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
