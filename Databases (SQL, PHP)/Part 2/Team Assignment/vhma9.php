<html>
<head>
    <title>General Insurance Step 9</title>
</head>
<body>
    <h1 style="text-align: center;">General Insurance Step 9</h3>

    <?php
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "GENERAL_INSURANCE";

        $conn = new mysqli($servername, $username, $password, $dbname);

        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        $sqlquery = "SELECT * FROM INSURANCE_COVERS";
        $result = $conn->query($sqlquery);

        if ($result->num_rows > 0)
        {
            echo "<h3>General Insurance products:</h3>";
            while($row = $result->fetch_assoc())
            {
                echo "Product description : " . $row["DESCRIPTION"] . "<br>";
                echo "  Yearly cost : " . $row["COST_YEARLY"]. "$ <br>";
                echo "  Minumum month validity : " . $row["MIN_VALIDITY_MONTHLY"]. " Months <br><br>";
            }
        }
        else
        {
            echo "No entries found in database <br>";
        }

        $conn->close();
    ?>


    <br><br><br>
    <form id="form1" name="form1" method="post" action="vhma10.php">
        <input type="submit" name="step10" value="Βήμα 10"/>
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
