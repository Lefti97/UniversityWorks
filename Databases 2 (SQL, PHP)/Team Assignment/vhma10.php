<html>
<head>
    <title>General Insurance Step 10</title>
    <style>
        table, td{
            border: 1px solid black;
            text-align: center;
        }
        table{
            width: 100%;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">General Insurance Step 10</h1>
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
    

    <form id="form1" name="form1" method="post" action="vhma10.php">
        <label>Select insurance product from dropdown list:</label>
        <select name='Product'>
            <option value="">--- Select ---</option>
            <?php
                $sqlquery1 = "select INSUR_CODE, DESCRIPTION from insurance_covers order by insur_code";
                $result1 = $conn->query($sqlquery1);

                if ($result1->num_rows > 0)
                {
                    while($row = $result1->fetch_assoc())
                    {
                        echo "<option value=". $row['INSUR_CODE'] .">". $row['DESCRIPTION'] ."</option>";
                    }
                }
                else
                {
                    echo "No entries found in database <br>";
                }
            ?>
        </select>
        <input type="submit" name="Submit" value="Select"/>
    </form>

    <?php
        if(isset($_POST['Submit']) && ($_POST['Product'] != "")){
            $sqlquery2 = "
                SELECT DISTINCT AFM, FULL_NAME, ADDRESS, PHONE, DOY, COST_OF_CONTRACTS FROM CUSTOMERS 
                INNER JOIN CONTRACTS USING (AFM)
                INNER JOIN INSURANCE_COVERS USING (INSUR_CODE)
                WHERE INSUR_CODE = ".$_POST['Product']."
                ORDER BY FULL_NAME;
            ";
            $result2 = $conn->query($sqlquery2);

            $sqlquery3 = "SELECT DESCRIPTION FROM INSURANCE_COVERS WHERE INSUR_CODE = ".$_POST['Product'];
            $result3 = $conn->query($sqlquery3);
            if($result3->num_rows == 1){
                $result3 = $result3->fetch_assoc()["DESCRIPTION"];
            }else{
                $result3 = "-";
            }
        }
    ?>

    <table>
        <br>    
        <label><b>Customers table of selected insurance product:</b></label>
        <br><br>
        <tr><td colspan="6">- <?php if(isset($result3)){echo $result3;} ?> -</td></tr>
        <tr><td>AFM</td><td>Full Name</td><td>Address</td><td>Phone</td><td>DOY</td><td>Contracts cost</td></tr>
        <?php
            if(isset($_POST['Submit']) && ($_POST['Product'] != "")){
                if ($result2->num_rows > 0)
                {
                    while($row = $result2->fetch_assoc())
                    {
                        echo "<tr>
                        <td>".$row["AFM"]."</td>
                        <td>".$row["FULL_NAME"]."</td>
                        <td>".$row["ADDRESS"]."</td>
                        <td>".$row["PHONE"]."</td>
                        <td>".$row["DOY"]."</td>
                        <td>".$row["COST_OF_CONTRACTS"]."</td>
                        </tr>";
                    }
                }
            }
        ?>
    </table>
    
    <?php $conn->close(); ?>


    <br><br><br>
    <form id="form1" name="form1" method="post" action="vhma9.php">
        <input type="submit" name="setp9" value="Βήμα 9"/>
    </form>
    <form id="form1" name="form1" method="post" action="vhma11.php">
        <input type="submit" name="step11" value="Βήμα 11"/>
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
