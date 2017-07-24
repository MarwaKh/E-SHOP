<?php
    
    
    class  access {
        var $dbhost = null;
        var $dbuser = null;
        var $dbpass = null;
        var $conn = null;
        var $dbname = null;
        var $result = null;
        
        function __construct() {
            $this->dbhost = Conn::$dbhost;
            $this->dbuser = Conn::$dbuser;
            $this->dbpass = Conn::$dbpass;
            $this->dbname = Conn::$dbname;
        }
        
        public function openConnection() {
            // establish connexion and store it in $conn
            $this->conn = new mysqli($this->dbhost, $this->dbuser, $this->dbpass, $this->dbname);
            if (mysqli_connect_errno()){
                echo new Exception("Could not establish connection with database");
            }
            
        }
        
        public function getConnection() {
            return $this->conn;
        }
        
        public function closeConnection() {
            if ($this->conn != null)
                $this->conn->close();
        }


       public function getAllProducts()
       {
           
            $sql = "SELECT * FROM Product";
            
            $result = $this->conn->query($sql);
            $zones= array();
            
            while($row = $result->fetch_array(MYSQLI_ASSOC)){
                $zones[] = $row;
            }
            
            return $zones;
           
        }


        
    }
    
    ?>
