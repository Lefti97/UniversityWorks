<html>
<head>
    <title>General Insurance Step 11</title>
</head>
    <body>
        <h1 style="text-align: center;">General Insurance Step 11</h1>
        <?php
            $servername = "localhost";
            $username = "root";
            $password = "";
            $dbname = "GENERAL_INSURANCE";

            $conn = new mysqli($servername, $username, $password, $dbname);

            if ($conn->connect_error) {
                die("Connection failed: " . $conn->connect_error);
            }
        ?>
        
        <form id="form1" name="form1" method="post" action="vhma11.php">
            <label>Select AFM: </label><input type="text" name="textAFM" size="7"/>
            <label>Year: </label><input type="text" name="textYear" size="1"/>
            <label>Month: </label><input type="text" name="textMonth" size="1"/>
            <label>Day: </label><input type="text" name="textDay" size="1"/>
            <input type="submit" name="Submit" value="Select"/>
        </form>
        

        <label><b>Result:</b></label><br>
        <?php
            if(isset($_POST['Submit'])){
                $sqlquery1 = "
                    SELECT FULL_NAME FROM CUSTOMERS WHERE AFM = ".$_POST['textAFM'];
                $result1 = $conn->query($sqlquery1);

                if($result1->num_rows == 1){
                    $result1 = $result1->fetch_assoc()['FULL_NAME'];

                    $sqlquery2 = "
                        CALL getClientInfoMonthly(".$_POST['textAFM'].", '".$_POST['textYear']."-".$_POST['textMonth']."-".$_POST['textDay']."')
                    ";
                    $result2 = $conn->query($sqlquery2);
                    if($result2->num_rows == 1){
                        $result2 = $result2->fetch_assoc();

                        echo "Customer ".$result1." has "
                            .$result2["Contracts at given month"]
                            ." contracts at given month and has to pay "
                            .$result2["Contracts cost at given month"]
                            ." euros for them.";
                    }else{
                        echo "myerror";
                    }
                }else{
                    echo "Customer with given AFM does not exist.";
                }
            }
        ?>    
        <?php $conn->close(); ?>



        <br><br><br>
        <form id="form1" name="form1" method="post" action="vhma9.php">
            <input type="submit" name="step9" value="Βήμα 9"/>
        </form>
        <form id="form1" name="form1" method="post" action="vhma10.php">
            <input type="submit" name="step10" value="Βήμα 10"/>
        </form>
        <p>
            <b>
            Authors:<br>
            ΕΛΕΥΘΕΡΙΟΣ ΒΑΓΓΕΛΗΣ - 18390008 <br>
            ΑΝΤΩΝΙΟΣ ΘΩΜΑΚΟΣ    - 18390037
            </b>
        </p>
    </body>
</html>
