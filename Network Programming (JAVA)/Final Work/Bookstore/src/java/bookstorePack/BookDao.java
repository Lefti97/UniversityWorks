package bookstorePack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
    
    // Συνδεόμαστε στην βάση δεδομένων books, με username "Vaggelis" και password "123456789".
    public static Connection getConnection(){
        Connection conn = null;
        
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bookstore", "Vaggelis", "123456789");
        } catch (ClassNotFoundException | SQLException ex) {}
        
        return conn;
    }
    
    
    // Λειτουργια 1. Παίρνουμε μια λίστα με όλα τα διαθέσιμα βιβλία.
    public static List<Book> getAvailableBooks(){
        List<Book> list = new ArrayList<>();
        
        Connection conn = BookDao.getConnection();
        
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE AVAILABILITY > 0");

            ResultSet rs=ps.executeQuery();  
            while(rs.next()){  
                Book book = new Book();
                
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthor(rs.getString(3));
                book.setPublisher(rs.getString(4));
                book.setPages(rs.getInt(5));
                book.setPubl_year(rs.getInt(6));
                book.setGenre(rs.getString(7));
                book.setAvailability(rs.getInt(8));
                
                list.add(book);  
            }  
            conn.close(); 
        } catch (SQLException ex) {}
        
        return list;
    }
    
    
    // Λειτουργία 2. Παίρνουμε ένα βιβλίο με ένα ID
    public static Book getBook(int id){
        Book book = null;
        
        Connection conn = BookDao.getConnection();
        
         try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE ID = ?");
            ps.setInt(1, id);
            ResultSet rs=ps.executeQuery();  
            if(rs.next()){  
                book = new Book();
                
                book.setId(rs.getInt(1));
                book.setTitle(rs.getString(2));
                book.setAuthor(rs.getString(3));
                book.setPublisher(rs.getString(4));
                book.setPages(rs.getInt(5));
                book.setPubl_year(rs.getInt(6));
                book.setGenre(rs.getString(7));
                book.setAvailability(rs.getInt(8));
            }  
            conn.close(); 
        } catch (SQLException ex) {}
        
        return book;
    }
    
    
    // Λειτουργίας 3. Παραγγελία ενός συγγράματος, x αντίτυπα.
    public static int orderBook(int id, int x){
        Book book = BookDao.getBook(id);
        
        if((book == null) || (x <= 0)){
            return 2; // Order Error
        }
        else if(x >= book.getAvailability()){
            return 1; // Out of Stock
        }
        else{
            Connection conn = BookDao.getConnection();

             try {
                PreparedStatement ps = conn.prepareStatement("UPDATE books SET AVAILABILITY = AVAILABILITY - ? WHERE ID = ?;");
                ps.setInt(1, x);
                ps.setInt(2, id);
                ps.executeQuery();
                conn.close(); 
            } catch (SQLException ex) {}

            return 0; // Succesfull Order
        }
    }
    
    
    // Λειτουργία 4. Καταχώρηση νέου συγγράματος.
    public static int addBook(Book newBook){
        Connection conn = BookDao.getConnection();

        try {
           PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO books (TITLE, AUTHOR, PUBLISHER, PAGES, PUBL_YEAR, GENRE, AVAILABILITY) VALUES(?, ?, ?, ?, ?, ?, ?)");
           ps.setString(1, newBook.getTitle());
           ps.setString(2, newBook.getAuthor());
           ps.setString(3, newBook.getPublisher());
           ps.setInt(4, newBook.getPages());
           ps.setInt(5, newBook.getPubl_year());
           ps.setString(6, newBook.getGenre());
           ps.setInt(7, newBook.getAvailability());
                   
           ps.executeQuery();
           conn.close(); 
       } catch (SQLException ex) {
           return 1; // Insert Error
       }

       return 0; // Insert Completed
    }
    
    
    // Λειτουργία 5. Ενημέρωση συγγράματος.
    public static int updateBook(Book updatedBook){
        Book oldBook = BookDao.getBook(updatedBook.getId());
        
        if(oldBook == null){
            return 1; // Update Error
        }
        else{
            Connection conn = BookDao.getConnection();
            
            try {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE books SET TITLE = ?, AUTHOR = ?, PUBLISHER = ?, PAGES = ?, PUBL_YEAR = ?, GENRE = ?, AVAILABILITY = ? WHERE ID = ?");
            ps.setString(1, updatedBook.getTitle());
            ps.setString(2, updatedBook.getAuthor());
            ps.setString(3, updatedBook.getPublisher());
            ps.setInt(4, updatedBook.getPages());
            ps.setInt(5, updatedBook.getPubl_year());
            ps.setString(6, updatedBook.getGenre());
            ps.setInt(7, updatedBook.getAvailability());
            ps.setInt(8, updatedBook.getId());

            ps.executeQuery();
            conn.close(); 
            } catch (SQLException ex) {
                return 2; // Update Error
            }

        return 0; // Update Completed
        }        
    }
    
    // Λειτουργία 6. Διαγραφή συγγράματος.
    public static int deleteBook(int id){
        Book book = BookDao.getBook(id);
        
        if(book == null){
            return 1; // Delete Error
        }else{
            Connection conn = BookDao.getConnection();

            try {
                PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM books WHERE ID = ?");
                ps.setInt(1, id);
                ps.executeQuery();

                conn.close(); 
            } catch (SQLException ex) {
                return 1; // Delete Error
            }

            return 0; // Delete Completed
        }
    }
    
}
