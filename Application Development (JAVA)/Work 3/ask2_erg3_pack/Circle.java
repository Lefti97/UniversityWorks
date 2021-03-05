package ask2_erg3_pack;

public class Circle extends Shape {
    double r;
    public Circle(double r){this.r = r;}
    
    @Override
    public double area()     {return Math.PI*r*r;}
    @Override
    public double perimeter(){return 2*Math.PI*r;}
}