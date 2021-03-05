package practice0;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import java.util.Random;

public class Practice0 extends Application {
    @Override
    public void start(Stage primaryStage) {
        Random ran = new Random();
        
        BorderPane bordP = new BorderPane();
        Button btn = new Button();
        Scene scene = new Scene(bordP, 300, 300);

        btn.setText("Red, Green or Blue");
        btn.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                int x = ran.nextInt() % 3;
                if(x == 0){
                    bordP.setBackground
                    (new Background(new BackgroundFill(Color.RED,null,null)));
                }
                if(x == 1){
                    bordP.setBackground
                    (new Background(new BackgroundFill(Color.GREEN,null,null)));
                }
                if(x == 2){
                    bordP.setBackground
                    (new Background(new BackgroundFill(Color.BLUE,null,null)));
                }
            }
        });
        
        bordP.setCenter(btn);
        
        primaryStage.setTitle("Button handler");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
    
}
