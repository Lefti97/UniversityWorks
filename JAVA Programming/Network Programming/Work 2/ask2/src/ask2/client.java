package ask2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class client extends javax.swing.JFrame {

    private String hostname = "localhost";
    private int port = 6000;
    
    private Socket socket = null;
    private BufferedReader reader;
    private PrintWriter out;
    
    private void clientAction(String command){
        try{
            out.println(command + " " + inputTextField.getText());
            out.flush();
            serverAnswerTextArea.setText(reader.readLine());
        } catch (IOException ex){
        }
    }
    
    public client() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        connectButton = new javax.swing.JButton();
        connectLabel = new javax.swing.JLabel();
        inputTextField = new javax.swing.JTextField();
        readLastButton = new javax.swing.JButton();
        insertButton = new javax.swing.JButton();
        serverAnswerLabel = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        helpTextArea = new javax.swing.JTextArea();
        jScrollPane2 = new javax.swing.JScrollPane();
        serverAnswerTextArea = new javax.swing.JTextArea();
        inputLabel = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("DB Client");

        connectButton.setText("Connect to Server");
        connectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                connectButtonActionPerformed(evt);
            }
        });

        connectLabel.setText("Not connected to server.");

        inputTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                inputTextFieldActionPerformed(evt);
            }
        });

        readLastButton.setText("Read by LASTNAME");
        readLastButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                readLastButtonActionPerformed(evt);
            }
        });

        insertButton.setText("Insert Student");
        insertButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                insertButtonActionPerformed(evt);
            }
        });

        serverAnswerLabel.setText("SERVER ANSWER: ");

        helpTextArea.setBackground(new java.awt.Color(204, 204, 204));
        helpTextArea.setColumns(20);
        helpTextArea.setRows(5);
        helpTextArea.setText("\nRead by LASTNAME input : \"LASTNAME\"\n\nInsert Student input : \"LASTNAME FIRSTNAME DEPARTMENT SEMESTER(INT) PASSED(INT)\"");
        jScrollPane1.setViewportView(helpTextArea);

        serverAnswerTextArea.setColumns(20);
        serverAnswerTextArea.setRows(5);
        jScrollPane2.setViewportView(serverAnswerTextArea);

        inputLabel.setText("INPUT: ");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane2)
                    .addComponent(jScrollPane1)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(12, 12, 12)
                        .addComponent(readLastButton, javax.swing.GroupLayout.PREFERRED_SIZE, 257, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(insertButton, javax.swing.GroupLayout.PREFERRED_SIZE, 263, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 14, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(inputLabel)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(inputTextField))
                    .addComponent(serverAnswerLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(connectButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(connectLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(connectButton)
                    .addComponent(connectLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(serverAnswerLabel)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(readLastButton)
                    .addComponent(insertButton))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(inputTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(inputLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(20, 20, 20))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void insertButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_insertButtonActionPerformed
        clientAction("_INSERT_");
    }//GEN-LAST:event_insertButtonActionPerformed

    private void connectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_connectButtonActionPerformed
        try{
            if(socket == null){
                    socket = new Socket(hostname, port);
                    reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                    out = new PrintWriter(socket.getOutputStream(), true);
                    connectLabel.setText("Connected to server.");

            } else{
                clientAction("_EXIT_");
                socket.close();
                socket = null;
                connectLabel.setText("Not connected to server.");
            }
        }catch(IOException ex){}
    }//GEN-LAST:event_connectButtonActionPerformed

    private void readLastButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_readLastButtonActionPerformed
        clientAction("_READLAST_");
    }//GEN-LAST:event_readLastButtonActionPerformed

    private void inputTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_inputTextFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_inputTextFieldActionPerformed

    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(client.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(client.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(client.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(client.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new client().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton connectButton;
    private javax.swing.JLabel connectLabel;
    private javax.swing.JTextArea helpTextArea;
    private javax.swing.JLabel inputLabel;
    private javax.swing.JTextField inputTextField;
    private javax.swing.JButton insertButton;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JButton readLastButton;
    private javax.swing.JLabel serverAnswerLabel;
    private javax.swing.JTextArea serverAnswerTextArea;
    // End of variables declaration//GEN-END:variables
}