
class Point{
	double x;
	double y;
	String name;
	
	Point(){
		x = 0;
		y = 0;
		name= "";}
	
	Point(double tX, double tY, String str){
		x = tX;
		y = tY;
		name = str;}
		
	Point(Point b){
		x=b.x;
		y=b.y;
		name=b.name;
	}
		
	public String toString(){
		return name+"("+x+","+y+").";}
	
}

class Pixel extends Point{
	String color;
	static int numberOfPixels = 0;
	
	Pixel(){
		super();
		this.color ="#000000";
		numberOfPixels++;}
	
	Pixel(double x1, double y1, String str, String col){
		super(x1,y1,str);
		this.color = col;
		numberOfPixels++;}
	
	Pixel(Point p, String col){
		super(p);
		this.color = col;
		numberOfPixels++;;
	}
	
	public String toString(){
		return "Name : "+this.name+
			 "\nX : "+this.x+"	Y : "+this.y+
			 "\nColor : "+this.color;
	}
}

public class ask3_erg2{
	public static void main(String[] args){
		Point px    = new Point(1,3,"point1");
		Pixel pix1 = new Pixel();
		Pixel pix2 = new Pixel(4,5,"pix2","pixel2");
		Pixel pix3 = new Pixel(px,"pixel3");
		
		System.out.print(Pixel.numberOfPixels+"\n");
		System.out.print(pix1.toString() + "\n\n");
		System.out.print(pix2.toString() + "\n\n");		
		System.out.print(pix3.toString() + "\n\n");

	}
}








