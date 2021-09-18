public interface TheaterInterface extends java.rmi.Remote { 
    public String list() 
        throws java.rmi.RemoteException; 

    public String book(String type, int number, String name) 
        throws java.rmi.RemoteException; 
 
    public String guests() 
        throws java.rmi.RemoteException; 
 
    public String cancel(String type, int number, String name) 
        throws java.rmi.RemoteException; 
} 