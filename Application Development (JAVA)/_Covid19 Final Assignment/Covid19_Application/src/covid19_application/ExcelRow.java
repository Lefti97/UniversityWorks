package covid19_application;

public class ExcelRow{
    // Variable declarations
    private String dateRep;
    private String countryterritoryCode;
    private String countriesAndTerritories;
    private int    cases;
    private int    deaths;
    private int    popData2018;
    
    // Getters
    public String getDateRep()                {return this.dateRep;}
    public String getCountriesAndTerritories(){return this.countriesAndTerritories;}
    public String getCountryterritoryCode()   {return this.countryterritoryCode;}
    public int    getCases()                  {return this.cases;}
    public int    getDeaths()                 {return this.deaths;}
    public int    getPopData2018()            {return this.popData2018;}
    
    //Setters
    public void setDateRep                (String str){this.dateRep = str;}
    public void setCountriesAndTerritories(String str){this.countriesAndTerritories = str;}
    public void setCountryterritoryCode   (String str){this.countryterritoryCode = str;}
    public void setCases                  (int x)     {this.cases = x;}
    public void setDeaths                 (int x)     {this.deaths = x;}
    public void setPopData2018            (int x)     {this.popData2018 = x;}
    
    // Empty Constructor
    ExcelRow(){
        this.dateRep = "-";  
        this.cases=0;
        this.deaths=0;
        this.countriesAndTerritories="-";
        this.countryterritoryCode="-";
        this.popData2018=0;
    }
    
    // Copy Constructor
    ExcelRow(ExcelRow ob){
        this.dateRep                 = ob.dateRep;  
        this.cases                   = ob.cases;
        this.deaths                  = ob.deaths;
        this.countriesAndTerritories = ob.countriesAndTerritories;
        this.countryterritoryCode    = ob.countryterritoryCode;
        this.popData2018             = ob.popData2018;
    }
    
    @Override
    public String toString(){
        return  this.dateRep + "  \t" +   
                this.cases + " " +  
                this.deaths + "\t" +  
                this.countriesAndTerritories + " " +  
                this.countryterritoryCode + "\t" +  
                this.popData2018 + "\n";
    }
}