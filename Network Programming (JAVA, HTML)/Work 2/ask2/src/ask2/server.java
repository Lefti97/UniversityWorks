package ask2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class server extends javax.swing.JFrame {

    private Connection conn = null;
    private ServerHandler serverThread = null;
    
    public server() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        outputPane = new javax.swing.JScrollPane();
        outputTextArea = new javax.swing.JTextArea();
        connectButton = new javax.swing.JButton();
        connectLabel = new javax.swing.JLabel();
        readAllButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("DB Server");

        outputTextArea.setColumns(20);
        outputTextArea.setRows(5);
        outputPane.setViewportView(outputTextArea);

        connectButton.setText("Connect to Database");
        connectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                connectButtonActionPerformed(evt);
            }
        });

        connectLabel.setText("Not connected to database.");

        readAllButton.setText("Read all students");
        readAllButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                readAllButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(outputPane)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(connectButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(connectLabel)
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
            .addGroup(layout.createSequentialGroup()
                .addGap(258, 258, 258)
                .addComponent(readAllButton)
                .addContainerGap(223, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(connectButton)
                    .addComponent(connectLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(outputPane, javax.swing.GroupLayout.PREFERRED_SIZE, 354, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 12, Short.MAX_VALUE)
                .addComponent(readAllButton)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void connectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_connectButtonActionPerformed
        if(conn == null){
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/askisi1_db", "Lefti", "123456789");
                connectLabel.setText("Connected to db \"askisi1_db\" as user \"Lefti\".");
                serverThread = new ServerHandler(conn);
                serverThread.start();
            } catch (ClassNotFoundException ex) {
                connectLabel.setText("DRiver class exception ");
                System.out.println("DRiver class exception " + ex);
            } catch (SQLException ex) {
                connectLabel.setText("DB Connection exception ");
                System.out.println("DB Connectrion exception " + ex);
            }
        }
    }//GEN-LAST:event_connectButtonActionPerformed

    private void readAllButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_readAllButtonActionPerformed
        if(conn != null){
            try{
                PreparedStatement pst = conn.prepareStatement("SELECT * FROM students");
                ResultSet rs = pst.executeQuery();

                outputTextArea.setText("LASTNAME\tFIRSTNAME\tDEPARTMENT\tSEMESTER\tPASSED\n\n");
                while (rs.next()){
                    String rsLine = rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5) + "\n";
                    outputTextArea.append(rsLine);
                }
            } catch (SQLException ex) {
                System.out.println("SQL Statement exception " + ex);
            }
        }
    }//GEN-LAST:event_readAllButtonActionPerformed

    public static void main(String args[]) {
        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new server().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton connectButton;
    private javax.swing.JLabel connectLabel;
    private javax.swing.JScrollPane outputPane;
    private javax.swing.JTextArea outputTextArea;
    private javax.swing.JButton readAllButton;
    // End of variables declaration//GEN-END:variables
}

class ServerHandler extends Thread{
    Connection dbConn;
    int port;
    ServerSocket serverSocket;
    Socket socket;
    
    public ServerHandler(Connection conn){
        this.dbConn = conn;
        this.port = 6000;
    }
    
    @Override
    public void run(){
        try{
            serverSocket = new ServerSocket(port);
            System.out.println("Server started on port " + port);
            System.out.println("Waiting for a client ...");
            while(true){
                socket = serverSocket.accept();
                ClientHandler clientHandler = new ClientHandler(socket, dbConn);
                clientHandler.start();
            }
        
        } catch(IOException ex){
        
        }

    }
}

class ClientHandler extends Thread{
    final Socket socket;
    final Connection dbConn;
    
    public ClientHandler(Socket socket, Connection conn){
        this.socket = socket;
        this.dbConn = conn;
    }
    
    @Override
    public void run(){
        InputStream inStream = null;
        OutputStream outStream = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try{
            System.out.println("A new client is connected : " + socket.getInetAddress().getHostName());
            
            inStream = socket.getInputStream();
            outStream = socket.getOutputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
            PrintWriter writer = new PrintWriter(new OutputStreamWriter(outStream, "UTF-8"), true);
            
            boolean done = false;
            while(!done){
                String[] received = reader.readLine().split(" ");
                String answer = "";
                
                try{
                    if(received[0].equalsIgnoreCase("_EXIT_")){
                        done = true;
                        answer = "Closing this connection...";
                    }
                    
                    else if(received[0].equalsIgnoreCase("_READLAST_")){
                        if(received.length == 2){
                            pst = dbConn.prepareStatement("SELECT * FROM students WHERE LASTNAME=?");
                            pst.setString(1, received[1]);
                            rs = pst.executeQuery();
                            if(rs.next())
                                answer = rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5);
                            else
                                answer = "Lastname " + received[1] + " is not in database.";
                        }else{
                            answer = "To read by LASTNAME, input must be LASTNAME.";
                        }
                    }
                    
                    else if(received[0].equalsIgnoreCase("_INSERT_")){
                        if(received.length == 6){
                            try{
                                pst = dbConn.prepareStatement("INSERT INTO students (LASTNAME, FIRSTNAME, DEPARTMENT, SEMESTER, PASSED) VALUES (?, ?, ?, ?, ?)");
                                pst.setString(1, received[1]);
                                pst.setString(2, received[2]);
                                pst.setString(3, received[3]);
                                pst.setInt(4, Integer.parseInt(received[4]));
                                pst.setInt(5, Integer.parseInt(received[5]));
                                pst.executeQuery();
                                answer = "INSERTED " + received[1] + " " + received[2] + " " +  received[3] + " " +  received[4] + " " +  received[5];
                            } catch(NumberFormatException ex){
                                pst = null;
                                answer = "To INSERT, input must be \"LASTNAME FIRSTNAME DEPARTMENT SEMESTER(INT) PASSED(INT)\"";
                            }
                        }else{
                            answer = "To INSERT, input must be \"LASTNAME FIRSTNAME DEPARTMENT SEMESTER(INT) PASSED(INT)\"";
                        }
                    }
                    
                    else{
                        answer = "Illegal command.";
                    }
                    
                    pst = null;
                    rs = null;
                } catch(SQLException ex){}
                
                writer.println(answer);
                writer.flush();
            }
            
            System.out.println("Connection closed: " + socket.getInetAddress().getHostName());
            socket.close();
        } catch (IOException ex){
        
        }
    }
}