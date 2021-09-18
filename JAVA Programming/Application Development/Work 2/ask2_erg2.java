
class Point{
	double x;
	double y;
	String name;
	
	Point(double tX, double tY, String str){
		x = tX;
		y = tY;
		name = str;}
		
	public String toString(){
		return name+"("+x+","+y+").";}
}

class LineSegment{
	Point p1,p2;
	String name;
	double len;
	
	LineSegment(Point a, Point b){
		p1=a;	p2=b;
		name = p1.name + p2.name;}
		
	void length(){
		len = Math.sqrt(Math.pow((p2.x - p1.x),2.0) + Math.pow((p2.y - p1.y),2.0));}
		
	public String toString(){
		return "Line segment "+name+"{("+p1.x+","+p1.y+"),("+p2.x+","+p2.y+")}" +
			" has length "+len;}
	
}


public class ask2_erg2{
	public static void main(String[] args){
		Point o1 = new Point(1,2,"A");
		Point o2 = new Point(3,4,"B");
		LineSegment line1 = new LineSegment(o1,o2);
		line1.length();
		System.out.print(line1.toString());
	}
}
