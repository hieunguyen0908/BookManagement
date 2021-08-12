/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hieunnm.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import hieunnm.dtos.UserDTO;

/**
 *
 * @author PC
 */
public class FilterRoleManagement implements Filter {

    private static Logger LOGGER = Logger.getLogger(FilterRoleManagement.class);
    private static String ERROR_PAGE = "error.jsp";
    private static final boolean debug = true;
    private static Map<String, List<String>> roleMap = new HashMap();
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public FilterRoleManagement() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterRoleManagement:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("FilterRoleManagement:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    private boolean checkRole(String role, String action) {
        if (role == null) {
            role = "guest";
        }
        return roleMap.get(role).contains(action);
    }

    private void initRoleMapping() {
        roleMap = new HashMap<>();
        roleMap.put("admin", new ArrayList<>());
        roleMap.put("user", new ArrayList<>());
        roleMap.put("allUser", new ArrayList<>());

        roleMap.get("admin").add("LoadInsertServlet");
        roleMap.get("admin").add("DeleteServlet");
        roleMap.get("admin").add("CreateDiscountCodeServlet");
        roleMap.get("admin").add("UpdateServlet");
        roleMap.get("admin").add("InsertServlet");
        roleMap.get("admin").add("insert.jsp");
        roleMap.get("admin").add("createDiscountCode.jsp");
        roleMap.get("admin").add("createDiscountCodeSuccessful.jsp");

        roleMap.get("user").add("AddToCartServlet");
        roleMap.get("user").add("UpdateCartServlet");
        roleMap.get("user").add("DeleteCartServlet");
        roleMap.get("user").add("ConfirmCartServlet");
        roleMap.get("user").add("HistoryServlet");
        roleMap.get("user").add("ApplyDiscountCodeServlet");
        roleMap.get("user").add("viewCart.jsp");
        roleMap.get("user").add("history.jsp");
        roleMap.get("user").add("OnlinePaymentServlet");
        roleMap.get("user").add("onlinePayment.jsp");
        roleMap.get("user").add("vnpay_ipn.jsp");
        roleMap.get("user").add("vnpay_return.jsp");

        roleMap.get("allUser").add("viewCart.jsp");
        roleMap.get("allUser").add("login.jsp");
        roleMap.get("allUser").add("error.jsp");
        roleMap.get("allUser").add("search.jsp");
        roleMap.get("allUser").add("LogoutServlet");
        roleMap.get("allUser").add("LoginServlet");
        roleMap.get("allUser").add("SearchServlet");
        roleMap.get("allUser").add("LoginGoogleServlet");
        roleMap.get("allUser").add("login-with-google");
        roleMap.get("allUser").add("loginGoogle.jsp");
//        roleMap.get("allUser").add("OnlinePaymentServlet");
//        roleMap.get("allUser").add("onlinePayment.jsp");
//        roleMap.get("allUser").add("vnpay_ipn.jsp");
//        roleMap.get("allUser").add("vnpay_return.jsp");



    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        req.setCharacterEncoding("UTF-8");
        String url = ERROR_PAGE;
        try {
            String uri = req.getRequestURI();
            int lastIndex = uri.lastIndexOf("/");
            String action = uri.substring(lastIndex + 1);
            List<String> allUserAction = roleMap.get("allUser");

            if (allUserAction.contains(action)) {
                chain.doFilter(request, response);
                return;
            }
            HttpSession session = req.getSession();
            UserDTO user = (UserDTO) session.getAttribute("USER");
            String role = null;
            if (user != null) {
                role = user.getRole().getName();
            } else {
                RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
                return;
            }
            if (checkRole(role, action)) {
                chain.doFilter(request, response);
                return;
            } else {
                req.setAttribute("ERROR", "You can't go to this page");
                RequestDispatcher rd = req.getRequestDispatcher(url);
                rd.forward(request, response);
            }
        } catch (IOException | ServletException e) {
            req.setAttribute("ERROR", "Something was wrong. Please check logs.");
            LOGGER.error(e.getMessage());
            RequestDispatcher rd = req.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        initRoleMapping();
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("FilterRoleManagement:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("FilterRoleManagement()");
        }
        StringBuffer sb = new StringBuffer("FilterRoleManagement(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
