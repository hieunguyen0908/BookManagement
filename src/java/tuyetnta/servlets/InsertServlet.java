/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tuyetnta.servlets;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
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
import org.apache.log4j.Logger;
import tuyetnta.daos.BookDAO;
import tuyetnta.dtos.BookDTO;
import tuyetnta.dtos.CategoryDTO;

/**
 *
 * @author tuyet
 */
@WebServlet(name = "InsertServlet", urlPatterns = {"/InsertServlet"})
public class InsertServlet extends HttpServlet {

    Pattern idPattern = Pattern.compile("[A-Za-z0-9]{2,30}");
    Pattern titlePattern = Pattern.compile("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀẾỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.]{1,100}$");
    Pattern authorPattern = Pattern.compile("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀẾỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.]{3,50}$");
    Pattern describePattern = Pattern.compile("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀẾỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s.]{0,300}$");
    Pattern numberPattern = Pattern.compile("[0-9]{0,20}");
    private static final String INSERT_PAGE = "LoadInsertServlet";
    private static final String ERROR_PAGE = "error.jsp";
    private static final Logger LOGGER = Logger.getLogger(InsertServlet.class);

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
        List<String> error = new ArrayList<>();
        try {
            //get all category
            //List<CategoryDTO> cats = getAllCategory();
            //request.setAttribute("CATE_LIST", cats);

            String id = request.getParameter("txtId");
            String title = request.getParameter("txtTitle");
            String image = request.getParameter("txtImage");
            String describe = request.getParameter("txtDescribe");
            String price = request.getParameter("txtPrice");
            String author = request.getParameter("txtAuthor");
            String categoryName = request.getParameter("categorys");
            Date importDate = Date.valueOf(LocalDate.now());
            String quantity = request.getParameter("txtQuantity");
            String status = "active";
            float priceF = 0;
            int quantityI = 0;
            try {
                priceF = Float.parseFloat(price);
                quantityI = Integer.parseInt(quantity);
            } catch (NumberFormatException e) {
                request.setAttribute("MSG_ERROR", "It must be a number");
            }
            if(id.isEmpty()){
                error.add("ID cannot empty");
            }
            if (!idPattern.matcher(id).matches()) {
                error.add("Id only contain alpha number char");
            }
            if (title.isEmpty()) {
                error.add("Title cannot empty");
            }
            if (!titlePattern.matcher(title).matches()) {
                error.add("Title only contains alphabet chars and range 1-100 chars");
            }
            if (!describe.isEmpty() || !describePattern.matcher(describe).matches()) {
                error.add("Describe only contains alphabet chars");
                if (!describe.isEmpty() && describe.length() > 300) {
                    error.add("Too long...");
                }
            }
            if(price.isEmpty()){
                error.add("Price cannot empty");
            }
            if (author.isEmpty() || !authorPattern.matcher(author).matches()) {
                error.add("Author only contains alphabet chars and range 3-50");
            }
            if(quantity.isEmpty()){
                error.add("Quantity cannot empty");
            }
            if (!error.isEmpty()) {
                request.setAttribute("MSG_ERROR", error);
            } else {
                BookDAO bookDao = new BookDAO();
                BookDTO book = new BookDTO();
                book.setId(id);
                book.setTitle(title);
                book.setImage(image);
                book.setDescribe(describe);
                book.setPrice(priceF);
                book.setAuthor(author);

                CategoryDTO dto = new CategoryDTO();
                int cateID = Integer.parseInt(categoryName);
                dto.setId(cateID);

                book.setCategory(new CategoryDTO(categoryName));
                book.setImportDate(importDate);
                book.setQuantity(quantityI);
                book.setStatus(status);
                boolean result = bookDao.insert(book);
                if (result) {
                    request.setAttribute("MSG_SUCCESS", "Created successfull");
                } else {
                    request.setAttribute("MSG_ERROR", "Create failed");
                }
            }
            url = INSERT_PAGE;

        } catch (SQLException | NamingException | NumberFormatException ex) {
            String msg = ex.getMessage();
            if (msg.contains("duplicate")) {
                error.add("ID has already. please choose another id");
                request.setAttribute("MSG_ERROR", error);
                url = INSERT_PAGE;
            }
            LOGGER.error(ex.getMessage());
            request.setAttribute("ERROR", "Something was wrong");
            url = ERROR_PAGE;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

//    private List<CategoryDTO> getAllCategory() throws SQLException, NamingException {
//        CategoryDAO cateDao = new CategoryDAO();
//        return cateDao.getAllCate();
//    }
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
