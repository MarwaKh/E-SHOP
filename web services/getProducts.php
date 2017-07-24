<?php
    
    
    require("conn.php");
    require("sqlAccess.php");
    
    
//    $id = htmlentities($_REQUEST["ProductID"]);
//    $name = htmlentities($_REQUEST["ProductName"]);
//    $description = htmlentities($_REQUEST["ProductDescription"]);

    
    
//    
//    if(empty($id) || empty($name) || empty($description))
//    {
//        $returnArray["status"] = "400";
//        $returnArray["message"] = "Missing required fields";
//        echo json_encode($returnArray);
//        return;
//    }
//    
    
    $response = array();
    
    $response['products'] = array();
    
    $access = new access();
    $access->openConnection();

    
    $products = $access->getAllProducts();
    
//    $array=array();
    
    if(!empty($products))
    {
        foreach ($products as $product) {
//            $returnArray["status"] = "200";
//            $returnArray["message"] = "product exists";
//            $returnArray["ProductID"] = $product["ProductID"];
//            $returnArray["ProductName"] = $product["ProductName"];
//            $returnArray["ProductDescription"] = $product["ProductDescription"];
//            array_push($array,$returnArray);
            
            $tempArray=array();
            
            $tempArray["ProductID"] = $product["ProductID"];
            $tempArray["name"] = $product["name"];
            $tempArray["price"]  = $product["price"];
            $tempArray["description"] = $product["description"];
            $tempArray["size"] = $product["size"];
            $tempArray["stars"] = $product["stars"];
            $tempArray["quantity"] = $product["quantity"];
            $tempArray["imagePath"] = $product["imagePath"];
            $tempArray["colors"] = $product["colors"];
            $tempArray["about"]  = $product["about"];
            
            array_push($response['products'],$tempArray);
        }
        
    } else {
        
        $returnArray["status"] = "400";
        $returnArray["message"] = "Unfound zone";
        
    }

    
    $access->closeConnection();
    
    echo json_encode($response);
    return;
    
    ?>
