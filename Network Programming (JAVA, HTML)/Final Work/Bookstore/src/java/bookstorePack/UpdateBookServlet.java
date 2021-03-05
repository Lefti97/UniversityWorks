package bookstorePack;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateBookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        // Get id of selected book from ViewServlet
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Get book info to autofill input texts
        Book book = BookDao.getBook(id);
        
        out.print(
        "<!DOCTYPE html>\n" +
        "<html>\n" +
        "    <head>\n" +
        "        <title>Bookstore DB Update Book</title>\n" +
        "    </head>\n" +
        "    <body>\n" +
        "        <h1 style=\"text-align: center;\">Bookstore DB Management</h1>\n" +
        "        <form action=\"index.html\">\n" +
        "            <input type=\"submit\" value=\"Main Page\"> </form>\n" +
        "        <form action=\"View\" method=\"GET\">\n" +
        "            <input type=\"hidden\" name=\"ListOption\" value=\"AllAvail\"/>\n" +
        "            <input type=\"submit\" value=\"List available books\">\n" +
        "        </form>\n" +
        "        <form action=\"View\" method=\"GET\">\n" +
        "            <input type=\"hidden\" name=\"ListOption\" value=\"ByID\"/>\n" +
        "            <input type=\"submit\" value=\"Search book by ID: \">\n" +
        "            <input type=\"number\" min=\"10000\" style=\"width: 5em\" name=\"sID\"/>\n" +
        "        </form>\n" +
        "        <form action=\"addBook.html\"> <input type=\"submit\" value=\"Add book\"> </form>\n" +
        "        <br>\n" +
        "        \n" +
        "        <h2>Update Book Details</h2>\n" +
        "        <form action=\"UpdateBookRun\" method=\"POST\">\n" +
        "            <input type=\"hidden\" name=\"id\" value=\""+book.getId()+"\">" +
        "            <table>  \n" +
        "                <tr><td>ID:</td><td><label>"+book.getId()+"</label></td></tr>  \n" +
        "                <tr><td>Title:</td><td><input type=\"text\" name=\"title\" value=\""+book.getTitle()+"\"/></td></tr>  \n" +
        "                <tr><td>Author:</td><td><input type=\"text\" name=\"author\" value=\""+book.getAuthor()+"\"/></td></tr>  \n" +
        "                <tr><td>Publisher:</td><td><input type=\"text\" name=\"publisher\" value=\""+book.getPublisher()+"\"/></td></tr>  \n" +
        "                <tr><td>Pages:</td><td><input type=\"number\" name=\"pages\" min=\"0\" value=\""+book.getPages()+"\"/></td></tr>  \n" +
        "                <tr><td>Year:</td><td><input type=\"number\" name=\"year\" min=\"0\" value=\""+book.getPubl_year()+"\"/></td></tr>  \n" +
        "                <tr><td>Genre:</td><td><input type=\"text\" name=\"genre\" value=\""+book.getGenre()+"\"/></td></tr>  \n" +
        "                <tr><td>Copies:</td><td><input type=\"number\" name=\"copies\" min=\"0\" value=\""+book.getAvailability()+"\"/></td></tr>\n" +
        "                \n" +
        "                <tr><td colspan=\"2\"><br><input type=\"submit\" value=\"Update\"/></td></tr>  \n" +
        "            </table>  \n" +
        "        </form>\n" +
        "    \n" +
        "\n" +
        "    </body>\n" +
        "</html>");
        
        
    }

}
