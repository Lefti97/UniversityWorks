import java.util.Scanner;

public class ask1_erg1{
	public static void main (String args[]){
		Scanner in = new Scanner(System.in);
		char ty;
		double temp, convTemp;
		
		System.out.print("Temperature converter Celsius-Fahrenheit.\n");
		
		System.out.print("Give temperature number : ");
		temp = in.nextFloat();
		
		System.out.print("Give temperature type. C/c for Celsius or F/f for Fahrenheit.\n" +
			"TYPE : ");
		ty = in.next().charAt(0);
		
		if(ty == 'C' || ty == 'c'){
			convTemp = (9*temp)/5 + 32;
			System.out.print(temp + " C are " + convTemp + " F.\n");
		}
		else if(ty == 'F' || ty == 'f'){
			convTemp = (5.0/9.0)*(temp-32);
			System.out.print(temp + " F are " + convTemp + " C.\n");
		}
		else{
			System.out.print("ERROR type can only be C,c,F,f\n");
		}
	}
}

