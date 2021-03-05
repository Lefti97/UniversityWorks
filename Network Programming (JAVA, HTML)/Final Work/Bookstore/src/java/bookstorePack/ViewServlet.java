package bookstorePack;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // ListOption decides if it will give all available books or
        // one specific book by ID.
        String listOption = request.getParameter("ListOption");
        
        int id = 0; // For searching by ID
        
        List<Book> list = null;
        
        // Print rows of all available books
        if(listOption.equals("AllAvail")){ 
            list = BookDao.getAvailableBooks();
        // Print a book with a specific ID
        }else if(listOption.equals("ByID")){ 
            list = new ArrayList<>();
            String sID = request.getParameter("sID");
            try{
                id = Integer.parseInt(sID);
                Book book = BookDao.getBook(id);
                if(book != null){
                    list.add(book);
                }
            } catch(NumberFormatException e){ }
        }
        
        
        // Prints an html file, that contains a table with the rows that
        // have resulted from the previous list actions.
        out.print(
        "<!DOCTYPE html>\n" +
        "<html>\n" +
        "    <head>\n" +
        "        <title>Bookstore DB View</title>\n" +
        "        <style>\n" +
        "            table, td, th{\n" +
        "                border: 1px solid black;\n" +
        "            }\n" +
        "            table{\n" +
        "                width: 100%;\n" +
        "            }\n" +
        "        </style>\n" +
        "    </head>\n" +
        "    <body>\n" +
        "        <h1 style=\"text-align: center;\">Bookstore DB Management</h1>\n" +
        "        <form action=\"index.html\">\n" +
        "            <input type=\"submit\" value=\"Main Page\"> </form>"+
        "        <form action=\"View\" method=\"GET\">\n" +
        "            <input type=\"hidden\" name=\"ListOption\" value=\"AllAvail\"/>\n" +
        "            <input type=\"submit\" value=\"List available books\">\n" +
        "        </form>\n" +
        "        <form action=\"View\" method=\"GET\">\n" +
        "            <input type=\"hidden\" name=\"ListOption\" value=\"ByID\"/>\n" +
        "            <input type=\"submit\" value=\"Search book by ID: \">\n" +
        "            <input type=\"number\" min=\"10000\" style=\"width: 5em\" name=\"sID\"/>\n" +
        "        </form>\n" +
        "        <form action=\"addBook.html\"> <input type=\"submit\" value=\"Add book\"> </form>" +
        "        <br>" +
        "        <table>\n" +
        "            <tr><th colspan=\"11\">Bookstore Database</th></tr>\n" +
        "            <tr><th>ID</th><th>Title</th><th>Author</th><th>Publisher</th><th>Pages</th><th>Year</th><th>Genre</th><th>Copies</th><th>Order</th><th>Update</th><th>Delete</th></tr>\n");
        
        // Print book rows resulting from previous searches and add
        // buttons for ordering, updating and deleting.
        for(Book e: list){
            out.print(
        "            <tr><td style=\"width: 50px; text-align: center;\">"+e.getId()+"</td>\n" +
        "                <td>"+e.getTitle()+"</td>\n" +
        "                <td>"+e.getAuthor()+"</td>\n" +
        "                <td>"+e.getPublisher()+"</td>\n" +
        "                <td style=\"width: 50px; text-align: center;\">"+e.getPages()+"</td>\n" +
        "                <td style=\"width: 50px; text-align: center;\">"+e.getPubl_year()+"</td>\n" +
        "                <td>"+e.getGenre()+"</td>\n" +
        "                <td style=\"width: 50px; text-align: center;\">"+e.getAvailability()+"</td>\n" +
        "                <td style=\"width: 100px; text-align: center;\">\n" +
        "                    <form action=\"OrderBook\" method=\"POST\">\n" +
        "                        <input type=\"hidden\" name=\"id\" value=\""+e.getId()+"\">\n" +
        "                        <input type=\"submit\" value=\"Ord.\">\n" +
        "                        <input type=\"number\" min=\"1\" style=\"width: 3em\" name=\"xBooks\"/></form></td>" +
        "                <td style=\"width: 60px; text-align: center;\">\n" +
        "                    <form action=\"UpdateBook\" method=\"GET\">\n" +
        "                        <input type=\"hidden\" name=\"id\" value=\""+e.getId()+"\">\n" +
        "                        <input type=\"submit\" value=\"Update\"></form></td>" +
        "                <td style=\"width: 60px; text-align: center;\">\n" +
        "                    <form action=\"DeleteBook\" method=\"POST\">\n" +
        "                        <input type=\"hidden\" name=\"id\" value=\""+e.getId()+"\">\n" +
        "                        <input type=\"submit\" value=\"Delete\"></form></td>" +
        "            </tr>\n");
        }
        
        out.print(
        "        </table>\n" +
        "    </body>\n" +
        "</html>"); 

        out.close();
    }
}
