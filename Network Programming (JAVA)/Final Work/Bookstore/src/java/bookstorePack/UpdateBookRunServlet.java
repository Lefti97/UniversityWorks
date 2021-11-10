package bookstorePack;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateBookRunServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Get the parameters given at UpdateBookServlet
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String genre = request.getParameter("genre");
        int pages = 0;
        int year = 0;
        int copies = 0;
        int id = 0;
        
        try{
            pages = Integer.parseInt(request.getParameter("pages"));
        }catch(NumberFormatException e){}
        try{
            year = Integer.parseInt(request.getParameter("year"));
        }catch(NumberFormatException e){}
        try{
            copies = Integer.parseInt(request.getParameter("copies"));
        }catch(NumberFormatException e){}
        try{
            id = Integer.parseInt(request.getParameter("id"));
        }catch(NumberFormatException e){}
        
        // Create the book that will replace the old book.
        Book newBook = new Book();
        
        newBook.setId(id);
        newBook.setTitle(title);
        newBook.setAuthor(author);
        newBook.setPublisher(publisher);
        newBook.setPages(pages);
        newBook.setPubl_year(year);
        newBook.setGenre(genre);
        newBook.setAvailability(copies);
        
        // Update book and get function message
        int status = BookDao.updateBook(newBook);
        
        if(status == 0){
            out.print("<p>Update Completed.</p>");
        } else if(status == 1){
            out.print("<p>Update Error.</p>");
        } else if(status == 2){
            out.print("<p>Update SQL Error.</p>");
        }
        
        request.getRequestDispatcher("index.html").include(request, response);  
        
        out.close();
    }

}
