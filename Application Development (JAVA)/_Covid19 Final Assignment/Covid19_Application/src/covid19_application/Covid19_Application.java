package covid19_application;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.cell.PropertyValueFactory;
import org.apache.poi.ss.usermodel.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.geometry.Pos;
import javafx.scene.control.Label;

public class Covid19_Application extends Application {
    private final String XLSX_FILE = "COVID-19-geographic-disbtribution-worldwide.xlsx";
    private final String Covid_Icon = "Covid_logo.png";
    
    //These variables are global so they can be used inside
    //the ChoiceBox's Listener.(Couldn't find other solution)
    private LineChart<String,Integer> lineCh;
    private VBox vBox2;
    private Scene scene2;
    private Stage stage2;
    
    @Override
    public void start(Stage primaryStage) throws IOException{
        // 1st Window visuals
        primaryStage.setTitle("COVID-19 Application");
        primaryStage.getIcons().add(new Image
        (new File(Covid_Icon).toURI().toURL().toExternalForm()));
        
        // 2nd Window creation and visuals
        stage2 = new Stage();
        stage2.setTitle("COVID-19 Application - Line Chart");
        stage2.getIcons().add(new Image
        (new File(Covid_Icon).toURI().toURL().toExternalForm()));
        
        // list has all the rows of the Excel with the requested content
        ObservableList<ExcelRow> list = getRowsList();
        
        
        // 1st WINDOW
        
        // TableView Creation (1st Window)
        TableView<ExcelRow> table = getTableView();
        table.setItems(list);
        
        // Button that opens 2nd Window (creation)
        Button btnChart = new Button("Chart");  btnChart.setPrefWidth(100);
        btnChart.setOnAction(value -> stage2.show());
        // Button that Exits program (creation)
        Button btnExit = new Button("Exit");    btnExit.setPrefWidth(100);
        btnExit.setOnAction(value -> System.exit(0));
        
        // Layout of 1st Window
        VBox vBox1 = new VBox(10);
        HBox hBox1 = new HBox(20);  hBox1.setAlignment(Pos.CENTER);
        hBox1.getChildren().addAll(btnChart,btnExit);
        vBox1.getChildren().addAll(table,hBox1);
        
        //1st Window Scene creation and show()
        Scene scene1 = new Scene(vBox1,425,450);
        primaryStage.setScene(scene1);
        primaryStage.show();
       
        
        // 2nd WINDOW
        
        // Label on top of 2nd Window
        Label lbl = new Label("Corona Virus Statistics: ");
        lbl.setFont(Font.font(25));
        
        // countriesList is used by the ChoiceBox and has each country in the excel once
        ObservableList<String> countriesList = getCountriesList(list);
        // ChoiceBox creation (2nd Window)
        ChoiceBox cBox = new ChoiceBox();      
        cBox.setPrefWidth(200);
        cBox.setItems(countriesList);
        
        // Button to close 2nd window (creation)
        Button btnClose = new Button("Close"); btnClose.setPrefWidth(100);
        btnClose.setOnAction(value -> stage2.close());
        
        // Empty LineChart creation
        lineCh = new LineChart(new CategoryAxis(),new NumberAxis());

        // Layout of 2nd Window
        vBox2 = new VBox(10); vBox2.setAlignment(Pos.CENTER);
        HBox hBox2 = new HBox(20); hBox2.setAlignment(Pos.CENTER);
        hBox2.getChildren().addAll(cBox,btnClose);
        vBox2.getChildren().addAll(lbl,lineCh,hBox2);
        
        // 2nd Window Scene creation
        scene2 = new Scene(vBox2,1000,500);
        stage2.setScene(scene2);
        
        // ChoiceBox Listener creation. Is executed when cBox country is changed.
        cBox.getSelectionModel().selectedItemProperty().addListener(new ChangeListener<String>() { 
            @Override
            public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
                // cBox country selected is added to lbl
                lbl.setText(" Corona Virus Statistics: " + newValue);
                // Linechart, Layout, Scene and Stage of 2nd Window are "restarted" with new cBox country
                lineCh = getLineChart(newValue, list); // new LineChart with new coutry selection data
                vBox2 = new VBox(10); vBox2.setAlignment(Pos.CENTER);
                vBox2.getChildren().addAll(lbl,lineCh,hBox2);
                scene2 = new Scene(vBox2,1000,500);
                stage2.setScene(scene2);
            }
        });
    }
    
    
    // Returns the wanted TableView
    private TableView<ExcelRow> getTableView(){
        // Empty TableView Initialisation
        TableView<ExcelRow> table = new TableView<>();
        
        // TableView Columns Initialised
        TableColumn<ExcelRow, String> dateCol      = new TableColumn<>("Date");
        TableColumn<ExcelRow, Integer> casesCol    = new TableColumn<>("Cases");
        TableColumn<ExcelRow, Integer> deathsCol   = new TableColumn<>("Deaths");
        TableColumn<ExcelRow, String> countriesCol = new TableColumn<>("Countries"); 
        TableColumn<ExcelRow, String> codeCol      = new TableColumn<>("Code");
        TableColumn<ExcelRow, Integer> popCol      = new TableColumn<>("Population 2018");
        
        // Set which ExcelRow values are read by each column
        dateCol.setCellValueFactory     (new PropertyValueFactory<>("dateRep"));
        casesCol.setCellValueFactory    (new PropertyValueFactory<>("cases"));
        deathsCol.setCellValueFactory   (new PropertyValueFactory<>("deaths"));
        countriesCol.setCellValueFactory(new PropertyValueFactory<>("countriesAndTerritories"));
        codeCol.setCellValueFactory     (new PropertyValueFactory<>("countryterritoryCode"));
        popCol.setCellValueFactory      (new PropertyValueFactory<>("popData2018"));
        // Add columns to table 
        table.getColumns().addAll(dateCol, casesCol, deathsCol, countriesCol, codeCol, popCol);
        
        return table;
    }
    
    
    // Returns ObservableList that contains all wanted row content of Excel
    private ObservableList<ExcelRow> getRowsList() throws IOException{
        // ArrayList to hold all rows from the Excel until method finishes
        ArrayList<ExcelRow> arrList = new ArrayList<>();
        // Workbook, Sheet, DataFormatter are POI API objects used to read the Excel
        Workbook wb = WorkbookFactory.create(new File(XLSX_FILE));
        Sheet sheet = wb.getSheetAt(0);
        DataFormatter dF = new DataFormatter();
        
        int i=0; // cell counter
        int x=0;
                
        for(Row row: sheet){ // Loop for all rows in excel sheet
            ExcelRow tmp = new ExcelRow(); // tmp holds the row values of current loop 
            for(Cell cell: row){ // Loop for all cells in row
                String cellValue = dF.formatCellValue(cell); // cellValue = current cell(as String)
                try{ // convert cellValue to int
                    x = Integer.parseInt(cellValue);} catch (NumberFormatException e)  {}
                
                // Set tmp content depending on which cell is currently read
                if     (i==0)tmp.setDateRep(cellValue);
                else if(i==4)tmp.setCases(x);
                else if(i==5)tmp.setDeaths(x);
                else if(i==6)tmp.setCountriesAndTerritories(cellValue);
                else if(i==8)tmp.setCountryterritoryCode(cellValue);
                else if(i==9)tmp.setPopData2018(x);
                
                i++; // Increase cell counter
            }
            //Small fix for the missing countryCodes in the Excel.(Cant fix population)
            if((tmp.getPopData2018()==0)) 
                tmp.setCountryterritoryCode(tmp.getCountriesAndTerritories().substring(0,3).toUpperCase());
            
            arrList.add(tmp); // Add the row read to arrList
            i=0; // Restart cell counter

        }
        arrList.remove(0); // Remove first row in arrList.(First row are column headers)
        // Create ObservableList and set content to arrList
        ObservableList<ExcelRow> list = FXCollections.observableArrayList(arrList);
        return list;
    }
    
    
    // Returns ObservableList with each country in excelRows
    private ObservableList<String> getCountriesList(ObservableList<ExcelRow> excelRows){
        ArrayList<String> arrList = new ArrayList<>(); // Holds countries until method exit
        String tmp1, tmp2;
        int i,j;
        
        // Gets countries in excelRows. (If Excel is not sorted by countries, arrList will have duplicates)
        arrList.add(excelRows.get(0).getCountriesAndTerritories());
        for(i=1;i<excelRows.size(); i++){
            tmp1 = excelRows.get(i).getCountriesAndTerritories();
            tmp2 = excelRows.get(i-1).getCountriesAndTerritories();
            if(tmp1.equals(tmp2) == false){
                arrList.add(tmp1);
            }
        }
        // Check if arrList has duplicates
        for(i=0;i<arrList.size();i++){
            tmp1 = arrList.get(i);
            for(j=i+1;j<arrList.size();j++){
                tmp2 = arrList.get(j);
                if(tmp1.equals(tmp2))
                    arrList.remove(j--);
            }
        }
        
        // return ObservableList
        ObservableList<String> list = FXCollections.observableArrayList(arrList);
        return list;
    }
    
    
    // Returns LineChart with given country data from list
    private LineChart<String,Integer> getLineChart(String country,ObservableList<ExcelRow> list){
        int i;
        String tmpStr;
        int tmpInt;
        
        // LineChart initialization
        CategoryAxis xAxis = new CategoryAxis(); xAxis.setLabel("Date");
        NumberAxis yAxis = new NumberAxis(); yAxis.setLabel("Cases/Deaths");
        LineChart<String,Integer> line = new LineChart(xAxis,yAxis);
        // Data Initialization
        XYChart.Series<String,Integer> dataCases = new XYChart.Series<>(); dataCases.setName("Cases");
        XYChart.Series<String,Integer> dataDeaths = new XYChart.Series<>(); dataDeaths.setName("Deaths");
        
        // Loop that sets dataCases and dataDeaths. Gets the elements of list, that are of given country.
        for(i=0;i<list.size();i++){
            if(country.equals(list.get(i).getCountriesAndTerritories())){
                tmpStr = list.get(i).getDateRep();
                tmpInt = list.get(i).getCases();
                dataCases.getData().add(new XYChart.Data(tmpStr,tmpInt));
                tmpInt = list.get(i).getDeaths();
                dataDeaths.getData().add(new XYChart.Data(tmpStr,tmpInt));
            }
        }
        // Set LineChart data
        line.getData().add(dataCases);
        line.getData().add(dataDeaths);
        
        return line;
    }
    
    
    public static void main(String[] args) {
        launch(args);
    }
}