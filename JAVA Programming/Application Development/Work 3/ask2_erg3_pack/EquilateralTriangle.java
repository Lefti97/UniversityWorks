package ask2_erg3_pack;

public class EquilateralTriangle extends Shape {
    double side;
    public EquilateralTriangle(double side){this.side = side;}
    
    @Override
    public double area()     {return (Math.sqrt(3)/4)*side*side;} // (sqr(3)/4)*a^2
    @Override
    public double perimeter(){return 3*side;}
}