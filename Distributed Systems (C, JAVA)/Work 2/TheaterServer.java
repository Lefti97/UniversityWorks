import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.*;

public class TheaterServer {

   public TheaterServer() {
     	try {
            TheaterInterface c = new TheaterImpl();
            Naming.rebind("//localhost/Theater", c);
            System.out.println("PeerServer bound in registry");
     	} catch (Exception e) {
       		System.out.println("Trouble: " + e);
     	}
   }

   public static void main(String args[]) {
	   System.out.println("RMI server started");
	   try {
            LocateRegistry.createRegistry(1099);
            System.out.println("java RMI registry created.");
        } catch (RemoteException e) {
            System.out.println("java RMI registry already exists.");
		}   
	   //Instantiate RmiServer
	   new TheaterServer();
   }
}
