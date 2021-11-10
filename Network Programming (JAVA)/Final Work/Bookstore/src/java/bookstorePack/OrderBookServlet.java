package bookstorePack;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class OrderBookServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Get id of selected book and number of books to order from ViewServlet
        int id = Integer.parseInt(request.getParameter("id"));
        int xBooks = Integer.parseInt(request.getParameter("xBooks"));
        
        // Order books and get Order message
        int status = BookDao.orderBook(id, xBooks);
        
        if(status == 0){
            out.print("<p>Succesfull Order.</p>");
        } else if(status == 1){
            out.print("<p>Out of Stock.</p>");
        } else if(status == 2){
            out.print("<p>Order Error.</p>");
        }
        
        request.getRequestDispatcher("index.html").include(request, response);  
        
        out.close();
        
    }

}
