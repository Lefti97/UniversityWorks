package ask2_erg3_pack;

public class Ellipse extends Shape implements Eccentric {
    double a,b;
    public Ellipse(double a, double b){this.a=a;   this.b=b;}
    
    @Override
    public double area()     {return Math.PI*a*b;}
    @Override
    public double perimeter(){return 2*Math.PI*(Math.sqrt(((a*a)+(b*b))/2));}
    @Override
    public double eccentricity(){
        if(this.a>this.b) return Math.sqrt((a*a)-(b*b))/a;
        else              return Math.sqrt((b*b)-(a*a))/b;}
    
    @Override
    public String toString() {
        return "\n"+name()+"\nArea="+area()+"\nPerimeter="+perimeter()
            +"\nEccentricity="+eccentricity()+"\n";}
}