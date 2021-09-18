import java.rmi.Naming; 
import java.rmi.RemoteException; 
import java.net.MalformedURLException; 
import java.rmi.NotBoundException; 
 
public class TheaterClient { 
 
    public static void main(String[] args) { 
        try { 
            if       ((args.length == 2) && args[0].equals("list")){
                TheaterInterface theater = (TheaterInterface)Naming.lookup(args[1]);
                System.out.println( theater.list() );
            } else if((args.length == 5) && args[0].equals("book")){
                TheaterInterface theater = (TheaterInterface)Naming.lookup(args[1]);
                System.out.println( theater.book(args[2], Integer.parseInt(args[3]), args[4]) );
            } else if((args.length == 2) && args[0].equals("guests")){
                TheaterInterface theater = (TheaterInterface)Naming.lookup(args[1]);
                System.out.println( theater.guests() );
            } else if((args.length == 5) && args[0].equals("cancel")){
                TheaterInterface theater = (TheaterInterface)Naming.lookup(args[1]);
                System.out.println( theater.cancel(args[2], Integer.parseInt(args[3]), args[4]) );
            } else{
                System.out.println("ERROR at command line parameters.");
                System.out.println("java TheaterClient list <hostname>"); 
                System.out.println("java TheaterClient book <hostname> <type> <number> <name>:"); 
                System.out.println("java TheaterClient guests <hostname>:"); 
                System.out.println("java TheaterClient cancel <hostname> <type> <number> <name>"); 
            }


        } 
        catch (MalformedURLException murle) { 
            System.out.println(); 
            System.out.println("MalformedURLException"); 
            System.out.println(murle); 
        } 
        catch (RemoteException re) { 
            System.out.println(); 
            System.out.println("RemoteException"); 
            System.out.println(re); 
        } 
        catch (NotBoundException nbe) { 
            System.out.println(); 
            System.out.println("NotBoundException"); 
            System.out.println(nbe); 
        } 
        catch (java.lang.ArithmeticException ae) { 
            System.out.println(); 
            System.out.println("java.lang.ArithmeticException"); 
            System.out.println(ae); 
        } 
    } 
} 

