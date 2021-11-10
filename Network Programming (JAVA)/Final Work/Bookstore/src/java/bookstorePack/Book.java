package bookstorePack;

public class Book {
    /*
        Getters and Setters of Book Class.
    */
    private int id, pages, publ_year, availability;
    private String title, author, publisher, genre;
    
    public int getId(){ 
        return this.id;}
    
    public void setId(int id){ 
        this.id = id;}
    
    public int getPages(){ 
        return this.pages;}
    
    public void setPages(int pages){ 
        this.pages = pages;}
    
    public int getPubl_year(){ 
        return this.publ_year;}
    
    public void setPubl_year(int publ_year){ 
        this.publ_year = publ_year;}
    
    public int getAvailability(){ 
        return this.availability;}
    
    public void setAvailability(int availability){ 
        this.availability = availability;}
    
    public String getTitle(){ 
        return this.title;}
    
    public void setTitle(String title){ 
        this.title = title;}
    
    public String getAuthor(){ 
        return this.author;}
    
    public void setAuthor(String author){ 
        this.author = author;}
    
    public String getPublisher(){ 
        return this.publisher;}
    
    public void setPublisher(String publisher){ 
        this.publisher = publisher;}
    
    public String getGenre(){ 
        return this.genre;}
    
    public void setGenre(String genre){ 
        this.genre = genre;}

}