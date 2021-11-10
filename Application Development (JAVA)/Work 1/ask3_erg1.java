class Point{
	double x;
	double y;
	String name;
	
	Point(double tX, double tY, String str){
		x = tX;
		y = tY;
		name = str;
	}
	
	public String toString(){
		return name+"("+x+","+y+").";
	}
	
}

public class ask3_erg1{
	public static void main(String[] args){
		Point pt = new Point(5,6,"B");
		System.out.print(pt);
	}
}
