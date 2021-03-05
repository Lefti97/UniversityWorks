package netprog_ask1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class window extends javax.swing.JFrame {
    
    private Connection conn = null;
    private PreparedStatement pst = null;
    private ResultSet rs = null;
    private int choice = 0; //0 == none, 1 == ReadAll, 2 == SearchLastname, 3 == SearchSemester, 4 == UpdatePassed, 5 == DeleteLastName, 6 == DeleteAll

    public window() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        connectButton = new javax.swing.JButton();
        connectLabel = new javax.swing.JLabel();
        readAllButton = new javax.swing.JButton();
        outputPane = new javax.swing.JScrollPane();
        outputTextArea = new javax.swing.JTextArea();
        searchLastnameButton = new javax.swing.JButton();
        searchSemesterButton = new javax.swing.JButton();
        updatePassedButton = new javax.swing.JButton();
        deleteLastnameButton = new javax.swing.JButton();
        deleteAllButton = new javax.swing.JButton();
        inputTextField = new javax.swing.JTextField();
        inputLabel = new javax.swing.JLabel();
        inputHelpLabel = new javax.swing.JLabel();
        executeButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        connectButton.setText("Connect");
        connectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                connectButtonActionPerformed(evt);
            }
        });

        connectLabel.setText("Not Connected.");

        readAllButton.setText("Read ALL");
        readAllButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                readAllButtonActionPerformed(evt);
            }
        });

        outputTextArea.setEditable(false);
        outputTextArea.setBackground(new java.awt.Color(255, 255, 204));
        outputTextArea.setColumns(5);
        outputTextArea.setRows(5);
        outputPane.setViewportView(outputTextArea);

        searchLastnameButton.setText("Search Last.");
        searchLastnameButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                searchLastnameButtonActionPerformed(evt);
            }
        });

        searchSemesterButton.setText("Search Sem.");
        searchSemesterButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                searchSemesterButtonActionPerformed(evt);
            }
        });

        updatePassedButton.setText("Update Pass.");
        updatePassedButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                updatePassedButtonActionPerformed(evt);
            }
        });

        deleteLastnameButton.setText("Delete Last.");
        deleteLastnameButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                deleteLastnameButtonActionPerformed(evt);
            }
        });

        deleteAllButton.setText("Delete ALL");
        deleteAllButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                deleteAllButtonActionPerformed(evt);
            }
        });

        inputTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                inputTextFieldActionPerformed(evt);
            }
        });

        inputLabel.setHorizontalAlignment(javax.swing.SwingConstants.RIGHT);
        inputLabel.setText("INPUT: ");

        inputHelpLabel.setText("INPUT HELP:");

        executeButton.setText("EXECUTE DB COMMAND");
        executeButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                executeButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(42, 42, 42)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(connectButton)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(connectLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(readAllButton, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(searchLastnameButton)
                                .addGap(18, 18, 18)
                                .addComponent(searchSemesterButton)
                                .addGap(18, 18, 18)
                                .addComponent(updatePassedButton)
                                .addGap(18, 18, 18)
                                .addComponent(deleteLastnameButton)
                                .addGap(18, 18, 18)
                                .addComponent(deleteAllButton))
                            .addComponent(outputPane, javax.swing.GroupLayout.PREFERRED_SIZE, 730, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(12, 12, 12)
                                .addComponent(inputHelpLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 689, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(inputLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 54, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(inputTextField))))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(206, 206, 206)
                        .addComponent(executeButton, javax.swing.GroupLayout.PREFERRED_SIZE, 361, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(42, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(connectButton)
                    .addComponent(connectLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 26, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(outputPane, javax.swing.GroupLayout.PREFERRED_SIZE, 351, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(readAllButton)
                    .addComponent(searchLastnameButton)
                    .addComponent(searchSemesterButton)
                    .addComponent(updatePassedButton)
                    .addComponent(deleteLastnameButton)
                    .addComponent(deleteAllButton))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(inputTextField)
                    .addComponent(inputLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 28, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(inputHelpLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 24, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(executeButton)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void connectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_connectButtonActionPerformed
        if(conn == null){
        try {
        	//2. Load and Register the relevant database driver
        	//use the db driver fro your database (e.g. mysql, mariabd, etc)
            Class.forName("org.mariadb.jdbc.Driver");
            
            //3. Create the connection
            //Use your dbname, dbusername and password
            conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/askisi1_db", "Lefti", "123456789");
            connectLabel.setText("Connected to db \"askisi1_db\" as user \"Lefti\".");
        } catch (ClassNotFoundException ex) {
            connectLabel.setText("DRiver class exception ");
            System.out.println("DRiver class exception " + ex);
        } catch (SQLException ex) {
            connectLabel.setText("DB Connection exception ");
            System.out.println("DB Connectrion exception " + ex);
        }
        }
    }//GEN-LAST:event_connectButtonActionPerformed

    private void inputTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_inputTextFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_inputTextFieldActionPerformed

    private void readAllButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_readAllButtonActionPerformed
        choice = 1;
        inputHelpLabel.setText("INPUT HELP: Read ALL . No input needed.");
    }//GEN-LAST:event_readAllButtonActionPerformed

    private void searchLastnameButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_searchLastnameButtonActionPerformed
        choice = 2;
        inputHelpLabel.setText("INPUT HELP: Search LASTNAME . Input only 'LASTNAME'.");
    }//GEN-LAST:event_searchLastnameButtonActionPerformed

    private void searchSemesterButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_searchSemesterButtonActionPerformed
        choice = 3;
        inputHelpLabel.setText("INPUT HELP: Search SEMESTER . Input only number 'SEMESTER'.");
    }//GEN-LAST:event_searchSemesterButtonActionPerformed

    private void updatePassedButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_updatePassedButtonActionPerformed
        choice = 4;
        inputHelpLabel.setText("INPUT HELP: Update PASSED . Input must be the lastname and passed number 'LASTNAME PASSED'.");
    }//GEN-LAST:event_updatePassedButtonActionPerformed

    private void deleteLastnameButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_deleteLastnameButtonActionPerformed
        choice = 5;
        inputHelpLabel.setText("INPUT HELP: Delete LASTNAME . Input must be the lastname 'LASTNAME'.");
    }//GEN-LAST:event_deleteLastnameButtonActionPerformed

    private void executeButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_executeButtonActionPerformed
        if(conn == null)
            return;
        
        try{
            switch(choice){
                case 0:
                    break;
                    
                    
                case 1:
                    pst = conn.prepareStatement("SELECT * FROM students");
                    rs = pst.executeQuery();
                    break;
                    
                    
                case 2:
                    if((!inputTextField.getText().isEmpty())){
                        String[] str = inputTextField.getText().split(" ");
                        if(str.length == 1){
                            pst = conn.prepareStatement("SELECT * FROM students WHERE LASTNAME=?");
                            pst.setString(1, str[0]);
                            rs = pst.executeQuery();
                        }
                    }
                    break;
                    
                    
                case 3:
                    if((!inputTextField.getText().isEmpty())){
                        String[] str = inputTextField.getText().split(" ");
                        if((str.length == 1) ){
                            boolean numeric = false;
                            try {
                                Integer.parseInt(str[0]);
                                numeric = true;
                            } catch (NumberFormatException e) {
                                numeric = false;
                            }
                            if(numeric){
                                pst = conn.prepareStatement("SELECT * FROM students WHERE SEMESTER=?");
                                pst.setString(1, str[0]);
                                rs = pst.executeQuery();
                            }
                        }
                    }
                    break;
                    
                    
                case 4:
                    if((!inputTextField.getText().isEmpty())){
                        String[] str = inputTextField.getText().split(" ");
                        if(str.length == 2){
                            boolean numeric = false;
                            try {
                                Integer.parseInt(str[1]);
                                numeric = true;
                            } catch (NumberFormatException e) {
                                numeric = false;
                            }
                            if(numeric){
                                pst = conn.prepareStatement("UPDATE students SET PASSED=? WHERE LASTNAME=?");
                                pst.setString(1, str[1]);
                                pst.setString(2, str[0]);
                                pst.executeQuery();
                            }
                        }
                    }
                    break;
                    
                    
                case 5:
                    if((!inputTextField.getText().isEmpty())){
                        String[] str = inputTextField.getText().split(" ");
                        if(str.length == 1){
                            pst = conn.prepareStatement("DELETE FROM students WHERE LASTNAME=?");
                            pst.setString(1, str[0]);
                            rs = pst.executeQuery();
                        }
                    }
                    break;
                    
                case 6:
                    pst = conn.prepareStatement("TRUNCATE TABLE students");
                    pst.executeQuery();
                    break;
            }
        }catch (SQLException ex) {
            System.out.println("SQL Statement exception " + ex);
        }
        
        if(1 <= choice && choice <= 3){
            try {
                outputTextArea.setText("LASTNAME\tFIRSTNAME\tDEPARTMENT\tSEMESTER\tPASSED\n\n");
                
                while (rs.next()){
                    String rsLine = rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4) + "\t" + rs.getString(5) + "\n";
                    outputTextArea.append(rsLine);
                }
            } catch (SQLException ex) {
                System.out.println("SQL Statement exception " + ex);
            }
        }
        
        pst = null;
        
    }//GEN-LAST:event_executeButtonActionPerformed

    private void deleteAllButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_deleteAllButtonActionPerformed
        choice = 6;
        inputHelpLabel.setText("INPUT HELP: Delete ALL . No input needed.");
    }//GEN-LAST:event_deleteAllButtonActionPerformed

    public static void main(String args[]) {
        
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new window().setVisible(true);
            }
        });
        
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton connectButton;
    private javax.swing.JLabel connectLabel;
    private javax.swing.JButton deleteAllButton;
    private javax.swing.JButton deleteLastnameButton;
    private javax.swing.JButton executeButton;
    private javax.swing.JLabel inputHelpLabel;
    private javax.swing.JLabel inputLabel;
    private javax.swing.JTextField inputTextField;
    private javax.swing.JScrollPane outputPane;
    private javax.swing.JTextArea outputTextArea;
    private javax.swing.JButton readAllButton;
    private javax.swing.JButton searchLastnameButton;
    private javax.swing.JButton searchSemesterButton;
    private javax.swing.JButton updatePassedButton;
    // End of variables declaration//GEN-END:variables
}
