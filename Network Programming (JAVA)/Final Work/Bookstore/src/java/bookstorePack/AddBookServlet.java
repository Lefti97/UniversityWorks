package bookstorePack;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        
        
        // Get the parameters given at addBook.html
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String genre = request.getParameter("genre");
        int pages = 0;
        int year = 0;
        int copies = 0;
        
        try{
            pages = Integer.parseInt(request.getParameter("pages"));
        }catch(NumberFormatException e){}
        try{
            year = Integer.parseInt(request.getParameter("year"));
        }catch(NumberFormatException e){}
        try{
            copies = Integer.parseInt(request.getParameter("copies"));
        }catch(NumberFormatException e){}
        
        // Create the Book class that is to be inserted
        Book book = new Book();
        
        book.setTitle(title);
        book.setAuthor(author);
        book.setPublisher(publisher);
        book.setPages(pages);
        book.setPubl_year(year);
        book.setGenre(genre);
        book.setAvailability(copies);
        
        // Create book and get function message
        int status = BookDao.addBook(book);
        
        if(status == 0){
            out.print("<p>Insert Completed.</p>");
        } else if(status == 1){
            out.print("<p>Insert Error.</p>");
        }
        
        request.getRequestDispatcher("index.html").include(request, response);  
        
        out.close();
    }

}
