package bookstorePack;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Get id of selected book from ViewServlet
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Delete book and get Delete message
        int status = BookDao.deleteBook(id);
        
        if(status == 0){
            out.print("<p>Delete Completed.</p>");
        } else if(status == 1){
            out.print("<p>Delete Error.</p>");
        }
        
        request.getRequestDispatcher("index.html").include(request, response);  
        
        out.close();
    }

}
