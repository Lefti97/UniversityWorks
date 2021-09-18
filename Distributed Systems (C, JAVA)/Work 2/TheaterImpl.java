import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class TheaterImpl 
    extends java.rmi.server.UnicastRemoteObject 
    implements TheaterInterface { 
    
    // "" == free seat
    public String zoneA[] = new String[200];    // ZA - 50$
    public String zoneB[] = new String[300];    // ZB - 40$
    public String zoneC[] = new String[500];    // ZC - 30$
    public String centr[] = new String[100];    // CE - 25$
    public String sides[] = new String[50];     // SI - 20$

    public TheaterImpl() throws java.rmi.RemoteException { 
        super(); 
        for(int i=0; i<200; i++)
            zoneA[i] = "";
        for(int i=0; i<300; i++)
            zoneB[i] = "";
        for(int i=0; i<500; i++)
            zoneC[i] = "";
        for(int i=0; i<100; i++)
            centr[i] = "";
        for(int i=0; i<50; i++)
            sides[i] = "";
    } 
 
    public String list() 
        throws java.rmi.RemoteException
    {
        System.out.println("List function called.\n");

        String listString;
        int emptyA     = 0;
        int emptyB     = 0;
        int emptyC     = 0;
        int emptyCen   = 0;
        int emptySides = 0;

        for(int i=0; i<200; i++)
            if(zoneA[i].equals(""))
                emptyA++;
        for(int i=0; i<300; i++)
            if(zoneB[i].equals(""))
                emptyB++;
        for(int i=0; i<500; i++)
            if(zoneC[i].equals(""))
                emptyC++;
        for(int i=0; i<100; i++)
            if(centr[i].equals(""))
                emptyCen++;
        for(int i=0; i<50; i++)
            if(sides[i].equals(""))
                emptySides++;

        listString  = String.valueOf(emptyA)     + " seats Zone A  (code: ZA) - Price: 50$\n";
        listString += String.valueOf(emptyB)     + " seats Zone B  (code: ZB) - Price: 40$\n";
        listString += String.valueOf(emptyC)     + " seats Zone C  (code: ZC) - Price: 30$\n";
        listString += String.valueOf(emptyCen)   + " seats Center  (code: CE) - Price: 25$\n";
        listString += String.valueOf(emptySides) + " seats Sides   (code: SI) - Price: 20$\n";
        
        return listString;
    }

    public String book(String type, int number, String name) 
        throws java.rmi.RemoteException
    {
        System.out.println("Book function called.\n");

        int totalcost = 0;
        int tmpNumber = number;

        if(name.equals(""))
            return "Name cannot be empty string \"\".\n";

        if     (type.equals("ZA")){
            for(int i=0; i<200; i++){
                if(tmpNumber == 0)
                    break;
                if(zoneA[i].equals("")){
                    tmpNumber--;
                    zoneA[i] = name;
                    totalcost += 50;
                }
            }
            return "Booked " + String.valueOf(number - tmpNumber) + 
                   " Zone A seats. Totalcost: " + String.valueOf(totalcost) + "\n";
        }
        else if(type.equals("ZB")){
            for(int i=0; i<300; i++){
                if(tmpNumber == 0)
                    break;
                if(zoneB[i].equals("")){
                    tmpNumber--;
                    zoneB[i] = name;
                    totalcost += 40;
                }
            }
            return "Booked " + String.valueOf(number - tmpNumber) + 
                   " Zone B seats. Totalcost: " + String.valueOf(totalcost) + "\n";
        }
        else if(type.equals("ZC")){
            for(int i=0; i<500; i++){
                if(tmpNumber == 0)
                    break;
                if(zoneC[i].equals("")){
                    tmpNumber--;
                    zoneC[i] = name;
                    totalcost += 30;
                }
            }
            return "Booked " + String.valueOf(number - tmpNumber) + 
                   " Zone C seats. Totalcost: " + String.valueOf(totalcost) + "\n";
        }
        else if(type.equals("CE")){
            for(int i=0; i<100; i++){
                if(tmpNumber == 0)
                    break;
                if(centr[i].equals("")){
                    tmpNumber--;
                    centr[i] = name;
                    totalcost += 25;
                }
            }
            return "Booked " + String.valueOf(number - tmpNumber) + 
                   " Center seats. Totalcost: " + String.valueOf(totalcost) + "\n";
        }
        else if(type.equals("SI")){
            for(int i=0; i<50; i++){
                if(tmpNumber == 0)
                    break;
                if(sides[i].equals("")){
                    tmpNumber--;
                    sides[i] = name;
                    totalcost += 20;
                }
            }
            return "Booked " + String.valueOf(number - tmpNumber) + 
                   " Sides seats. Totalcost: " + String.valueOf(totalcost) + "\n";
        }
        else{
            return "Type/code must be ZA, ZB, ZC, CE or SI";
        }

    }
 
    public String guests() 
        throws java.rmi.RemoteException
    {
        System.out.println("Guests function called.\n");

        ArrayList<String> guestNames = new ArrayList<String>();
        ArrayList<int[]> guestSeats = new ArrayList<int[]>();

        // ZA
        for(int i=0; i<200; i++)
        { 
            if(zoneA[i].equals(""))
                continue;
            else if(guestNames.contains(zoneA[i]))
                guestSeats.get(guestNames.indexOf(zoneA[i]))[0] += 1;
            else{
                int[] zeroArr = {0, 0, 0, 0, 0};
                guestNames.add(zoneA[i]);
                guestSeats.add(zeroArr);
                guestSeats.get(guestNames.indexOf(zoneA[i]))[0] += 1;
            }
        }
        // ZB
        for(int i=0; i<300; i++)
        { 
            if(zoneB[i].equals(""))
                continue;
            else if(guestNames.contains(zoneB[i]))
                guestSeats.get(guestNames.indexOf(zoneB[i]))[1] += 1;
            else{
                int[] zeroArr = {0, 0, 0, 0, 0};
                guestNames.add(zoneB[i]);
                guestSeats.add(zeroArr);
                guestSeats.get(guestNames.indexOf(zoneB[i]))[1] += 1;
            }
        }
        // ZC
        for(int i=0; i<500; i++)
        { 
            if(zoneC[i].equals(""))
                continue;
            else if(guestNames.contains(zoneC[i]))
                guestSeats.get(guestNames.indexOf(zoneC[i]))[2] += 1;
            else{
                int[] zeroArr = {0, 0, 0, 0, 0};
                guestNames.add(zoneC[i]);
                guestSeats.add(zeroArr);
                guestSeats.get(guestNames.indexOf(zoneC[i]))[2] += 1;
            }
        }
        // CE
        for(int i=0; i<100; i++)
        { 
            if(centr[i].equals(""))
                continue;
            else if(guestNames.contains(centr[i]))
                guestSeats.get(guestNames.indexOf(centr[i]))[3] += 1;
            else{
                int[] zeroArr = {0, 0, 0, 0, 0};
                guestNames.add(centr[i]);
                guestSeats.add(zeroArr);
                guestSeats.get(guestNames.indexOf(centr[i]))[3] += 1;
            }
        }
        // SI
        for(int i=0; i<50; i++)
        {
            if(sides[i].equals(""))
                continue;
            else if(guestNames.contains(sides[i]))
                guestSeats.get(guestNames.indexOf(sides[i]))[4] += 1;
            else{
                int[] zeroArr = {0, 0, 0, 0, 0};
                guestNames.add(sides[i]);
                guestSeats.add(zeroArr);
                guestSeats.get(guestNames.indexOf(sides[i]))[4] += 1;
            }
        }

        String guestsString = "";

        for(int i=0; i<guestSeats.size(); i++){
            System.out.print((i+1) + ": " + guestSeats.get(i)[0]);
            System.out.print(" " + guestSeats.get(i)[1]);
            System.out.print(" " + guestSeats.get(i)[2]);
            System.out.print(" " + guestSeats.get(i)[3]);
            System.out.println(" " + guestSeats.get(i)[4]);
        }

        for(int i=0; i<guestNames.size(); i++){
            int totalcost = 0;

            totalcost += guestSeats.get(i)[0] * 50;
            totalcost += guestSeats.get(i)[1] * 40;
            totalcost += guestSeats.get(i)[2] * 30;
            totalcost += guestSeats.get(i)[3] * 25;
            totalcost += guestSeats.get(i)[4] * 20;
            
            guestsString += guestNames.get(i) + " has booked: "
                +" ZA = "+ String.valueOf(guestSeats.get(i)[0])
                +", ZB = "+ String.valueOf(guestSeats.get(i)[1])
                +", ZC = "+ String.valueOf(guestSeats.get(i)[2])
                +", CE = "+ String.valueOf(guestSeats.get(i)[3])
                +", SI = "+ String.valueOf(guestSeats.get(i)[4])
                +" ... Totalcost = "+ String.valueOf(totalcost) + "\n";
        }
    

        return guestsString;
    }
 
    public String cancel(String type, int number, String name) 
        throws java.rmi.RemoteException
    {
        System.out.println("Cancel function called.\n");

        int tmpNumber = number;
        int remaining = 0;

        if(name.equals(""))
            return "Name cannot be empty string \"\".\n";

        if     (type.equals("ZA")){
            for(int i=0; i<200; i++)
                if(zoneA[i].equals(name)){
                    if(tmpNumber == 0)
                        remaining++;
                    else{
                        tmpNumber--;
                        zoneA[i] = "";
                    }
                }
            return name + ". Zone A seats. Cancelled: " + String.valueOf(number - tmpNumber) 
                + "\tRemaining: " + String.valueOf(remaining) + "\n";
        }
        else if(type.equals("ZB")){
            for(int i=0; i<300; i++)
                if(zoneB[i].equals(name)){
                    if(tmpNumber == 0)
                        remaining++;
                    else{
                        tmpNumber--;
                        zoneB[i] = "";
                    }
                }
        
            return name + ". Zone A seats. Cancelled: " + String.valueOf(number - tmpNumber) 
                + "\tRemaining: " + String.valueOf(remaining) + "\n";
        }
        else if(type.equals("ZC")){
            for(int i=0; i<500; i++)
                if(zoneC[i].equals(name)){
                    if(tmpNumber == 0)
                        remaining++;
                    else{
                        tmpNumber--;
                        zoneC[i] = "";
                    }
                }
            return name + ". Zone A seats. Cancelled: " + String.valueOf(number - tmpNumber) 
                + "\tRemaining: " + String.valueOf(remaining) + "\n";
        }
        else if(type.equals("CE")){
            for(int i=0; i<100; i++)
                if(centr[i].equals(name)){
                    if(tmpNumber == 0)
                        remaining++;
                    else{
                        tmpNumber--;
                        centr[i] = "";
                    }
                }
            return name + ". Zone A seats. Cancelled: " + String.valueOf(number - tmpNumber) 
                + "\tRemaining: " + String.valueOf(remaining) + "\n";
        }
        else if(type.equals("SI")){
            for(int i=0; i<50; i++)
                if(sides[i].equals(name)){
                    if(tmpNumber == 0)
                        remaining++;
                    else{
                        tmpNumber--;
                        sides[i] = "";
                    }
                }
            return name + ". Zone A seats. Cancelled: " + String.valueOf(number - tmpNumber) 
                + "\tRemaining: " + String.valueOf(remaining) + "\n";
        }
        else{
            return "Type/code must be ZA, ZB, ZC, CE or SI";
        }

    }
}

