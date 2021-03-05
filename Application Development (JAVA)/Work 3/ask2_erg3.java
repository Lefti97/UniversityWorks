import ask2_erg3_pack.*;
import java.util.*;

public class ask2_erg3 {
    public static void main(String[] args){
        Random ran = new Random();
        
        EquilateralTriangle et1 = new EquilateralTriangle(ran.nextInt());
        Ellipse             el1 = new Ellipse(ran.nextInt(), ran.nextInt());
        Circle              c1  = new Circle(ran.nextInt());
        
        System.out.println(et1.toString());
        System.out.println(el1.toString());
        System.out.println(c1 .toString());
    }
}