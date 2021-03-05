import java.util.*;

class Person{
    private String  lastname,firstname;
    private int     age;
    private boolean married;
    private double  salary;
    private int     sex;
    
    public static final int MALE   = 0;
    public static final int FEMALE = 1;
    
    
    Person(String lastname, String firstname, int age, boolean married, double salary, int sex){
        this.lastname  = lastname;
        this.firstname = firstname;
        this.age       = age;
        this.married   = married;
        this.salary    = salary;
        this.sex       = sex;
        System.out.println("Person " + this.lastname +" "+ this.firstname + " created.");
    }
    
    public String  getFirstName(){return this.firstname;}
    public String  getLastName() {return this.lastname;}
    public int     getAge()      {return this.age;}
    public boolean isMarried()   {return this.married;}
    public double  getSalary()   {return this.salary;}
    public int     getSex()      {return this.sex;}
    
    public void setFirstName(String  firstname){this.firstname = firstname;}
    public void setLastName (String  lastname) {this.lastname  = lastname;}
    public void setAge      (int     age)      {this.age       = age;}
    public void setMarried  (boolean married)  {this.married   = married;}
    public void setSalary   (double  salary)   {this.salary    = salary;}
    public void setSex      (int     sex)      {this.sex       = sex;}
    
    public void printInfo(){
        System.out.println("\n PERSON INFO");
        System.out.println("First/Last Name: " + this.firstname +" "+ this.lastname);
        System.out.println("Age: "             + this.age);
        System.out.println("Married: "         + this.married);
        System.out.println("Salary: "          + this.salary);
        System.out.print  ("Sex: ");
        if      (this.sex == this.MALE)  {System.out.println("Male");}
        else if (this.sex == this.FEMALE){System.out.println("Female");}
        else    {System.out.println("Other");}
    }
}

class MarriedPerson extends Person{
    private int noOfChildren;
    
    MarriedPerson(String lastname, String firstname, int age, double salary, int sex, int noOfChildren){
        super(lastname, firstname, age, true, salary, sex);  this.noOfChildren = noOfChildren;}
    
    public int  getNoOfChildren()                {return this.noOfChildren;}
    public void setNoOfChildren(int noOfChildren){this.noOfChildren = noOfChildren;}
    
    public void printInfo(){
        super.printInfo();  System.out.println("No. Children: "+ noOfChildren);}
}

public class ask1_erg3 {
    public static void main(String[] args ) {
        ArrayList<MarriedPerson> mpList = new ArrayList<MarriedPerson>();
        MarriedPerson mp1 = new MarriedPerson("Kitsou", "Eva", 45, 9980.5f, 1, 3);
        //Person p1 = new Person("Mitsos", "Kimoulis", 60, true, 1260f, 0);        
        
        mpList.add(mp1);
        mpList.add(new MarriedPerson("Giwrgos",     "Giorgatoy", 32, 1650.5f, 0, 2));
        mpList.add(new MarriedPerson("Kwnstantina", "Giouverla", 29, 5243.5f, 1, 5));
        mpList.add(new MarriedPerson("Maria",       "Kontou",    58, 1000f,   1, 3));
        mpList.add(new MarriedPerson("Giovanka",    "Giouvela",  21, 3000f,   6, 0));
        
        Comparator<MarriedPerson> compByAge = new Comparator<MarriedPerson>(){
            @Override
            public int compare(MarriedPerson o1, MarriedPerson o2) {
                return o1.getAge() - o2.getAge();
            }
        };
        
        Collections.sort(mpList, compByAge);
        
        for(MarriedPerson mp : mpList){
            mp.printInfo();
        }
    }
}