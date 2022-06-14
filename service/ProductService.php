<?php

namespace Service;

use Model\Product;
use PDO;

class ProductService
{
    protected $imageservice;
    protected $producttag;
    public function __construct($db)
    {
        $this->conn = $db;
        $this->obj = new Product();
        $this->imageservice = new ProductImageService($db);
        $this->producttag = new TagListService($db);
    }

    //讀取
    public function read($auth = null)
    {
        $query = "SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,
                            Image,
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice,
                            p.ProductId IN (SELECT ProductId
                                            FROM shoppingcart sc,
                                                 shoppinglist sl
                                            WHERE sc.CartId = sl.CartId AND
                                                  State = '未結帳' AND
                                                  Member = '" . $auth . "') AS InCart                        
                        FROM product p
                        LEFT JOIN productimage img
                        ON p.ProductId = img.ProductId
                        WHERE p.DeletedAt IS NULL AND
                            State = 'on'
                        GROUP BY ProductId
                        HAVING Rent = 0
                        ORDER BY CreatedAt";


        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'InCart' => $InCart,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'Image' => $Image,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );

                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];
                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }

    //複合查詢
    public function read_muti($auth = null, $data)
    {
        $query = "SELECT *
                    FROM(SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,                        
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice,
                            p.ProductId IN (SELECT ProductId
                                            FROM shoppingcart sc,
                                                shoppinglist sl
                                            WHERE sc.CartId = sl.CartId AND
                                                State = '未結帳' AND
                                                Member = '" . $auth . "') AS InCart,
                            (SELECT lists
                                    FROM 
                                    (SELECT 
                                    CONCAT(GROUP_CONCAT(Tag)) AS lists,
                                    ProductId
                                    FROM (SELECT tl.ProductId,c.Tag 
                                        FROM taglist tl,
                                        category c
                                        WHERE tl.CategoryId = c.CategoryId) AS taglist
                                    GROUP BY ProductId) AS totaltag
                                    RIGHT JOIN 	product a
                                    ON totaltag.ProductId = a.ProductId
                                    WHERE p.ProductId = a.ProductId)list,
                            IFNULL((SELECT SUM(CustomerScore) / COUNT(CustomerScore) AS AverageScore
                                    FROM recorddeal rd,
                                          dealreview dr,
                                          shoppinglist sp
                                    WHERE rd.RecordId = dr.RecordId AND
                                            sp.ShoppingId = rd.ShoppingId
                                    GROUP BY sp.ProductId
                                    HAVING ProductId = p.ProductId),0) AS AverageScore
                                                                                    
                            FROM product p                    
                            WHERE p.DeletedAt IS NUll AND
                            p.Rent = 0)AAA
                WHERE State = 'on' ";

        $addstring = "";
        $last = "";
        foreach ($data as $key => $value) {
            if ($key == 'Name') {
                $addstring .= " AND Name LIKE '%" . $value . "%'";
            }
            if ($key == 'Price') {
                $param = explode(",", $value);
                $addstring .= " AND Price > " . $param[0];
                if ($param[0] != 700) {
                    $addstring .= " AND Price < " . $param[1];
                }
            }
            if ($key == 'MaxPrice') {
                $addstring .= " AND Price < " . $value;
            }
            if ($key == 'Category' && strlen($value) > 0) {
                $param = explode(",", $value);
                $addstring .= " AND (";
                $count = 1;
                foreach ($param as $item) {
                    $string = "list LIKE '";
                    $string .= "%" . $item . "%";
                    $string .=  "' ";

                    if ($count < Count($param)) {
                        $string .= "OR ";
                    } else {
                        $string .= ")";
                    }
                    $addstring .= $string;
                    $count++;
                }
            }
            if ($key = 'Sort') {
                $param = explode(",", $value);
                foreach ($param as $item) {
                    switch ($item) {
                        case "pricedesc":
                            if ($last != "") {
                                $last .= ", Price DESC";
                                break;
                            } else {
                                $last .= "ORDER BY Price DESC";
                                break;
                            }
                        case "reviewasc": {
                                if ($last != "") {
                                    $last .= ", AverageScore";
                                    break;
                                } else {
                                    $last .= "ORDER BY AverageScore";
                                    break;
                                }
                            }
                    }
                }
            }
        }

        $query .= $addstring;


        if ($last != "") {
            $query .= $last;
        } else {
            $query .= " ORDER BY Price ASC,
            AverageScore DESC,
            CreatedAt ";
        }

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'AverageScore' => $AverageScore,
                    'InCart' => $InCart,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );

                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];

                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }

    //複合查詢
    public function read_muti_rent($auth = null, $data)
    {
        $query = "SELECT *
                    FROM(SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,                        
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice,
                            p.ProductId IN (SELECT ProductId
                                            FROM shoppingcart sc,
                                                shoppinglist sl
                                            WHERE sc.CartId = sl.CartId AND
                                                State = '未結帳' AND
                                                Member = '" . $auth . "') AS InCart,
                            (SELECT lists
                                    FROM 
                                    (SELECT 
                                    CONCAT(GROUP_CONCAT(Tag)) AS lists,
                                    ProductId
                                    FROM (SELECT tl.ProductId,c.Tag 
                                        FROM taglist tl,
                                        category c
                                        WHERE tl.CategoryId = c.CategoryId) AS taglist
                                    GROUP BY ProductId) AS totaltag
                                    RIGHT JOIN 	product a
                                    ON totaltag.ProductId = a.ProductId
                                    WHERE p.ProductId = a.ProductId)list,
                            IFNULL((SELECT SUM(CustomerScore) / COUNT(CustomerScore) AS AverageScore
                                    FROM recorddeal rd,
                                          dealreview dr,
                                          shoppinglist sp
                                    WHERE rd.RecordId = dr.RecordId AND
                                            sp.ShoppingId = rd.ShoppingId
                                    GROUP BY sp.ProductId
                                    HAVING ProductId = p.ProductId),0) AS AverageScore                                                                                    
                            FROM product p                    
                            WHERE p.DeletedAt IS NUll AND
                            p.Rent = 1)AAA
                WHERE State = 'on' ";

        $addstring = "";
        $last = "";
        foreach ($data as $key => $value) {
            if ($key == 'Name') {
                $addstring .= " AND Name LIKE '%" . $value . "%'";
            }
            if ($key == 'Price') {
                $param = explode(",", $value);
                $addstring .= " AND Rent > " . $param[0];
                if ($param[0] != 700) {
                    $addstring .= " AND Rent < " . $param[1];
                }
            }
            if ($key == 'Category' && strlen($value) > 0) {
                $param = explode(",", $value);
                $addstring .= " AND (";
                $count = 1;
                foreach ($param as $item) {
                    $string = "list LIKE '";
                    $string .= "%" . $item . "%";
                    $string .=  "' ";

                    if ($count < Count($param)) {
                        $string .= "OR ";
                    } else {
                        $string .= ")";
                    }
                    $addstring .= $string;
                    $count++;
                }
            }
            if ($key = 'Sort') {
                $param = explode(",", $value);
                foreach ($param as $item) {
                    switch ($item) {
                        case "pricedesc":
                            if ($last != "") {
                                $last .= ", Price DESC";
                                break;
                            } else {
                                $last .= "ORDER BY Price DESC";
                                break;
                            }
                        case "reviewasc": {
                                if ($last != "") {
                                    $last .= ", AverageScore";
                                    break;
                                } else {
                                    $last .= "ORDER BY AverageScore";
                                    break;
                                }
                            }
                    }
                }
            }
        }

        $query .= $addstring;


        if ($last != "") {
            $query .= $last;
        } else {
            $query .= " ORDER BY Price ASC,
            AverageScore DESC,
            CreatedAt ";
        }

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'AverageScore' => $AverageScore,
                    'InCart' => $InCart,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );

                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];

                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }

    //讀取
    public function read_rent($auth = null)
    {
        $query = "SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,
                            Image,
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice,
                            p.ProductId IN (SELECT ProductId
                                            FROM shoppingcart sc,
                                                 shoppinglist sl
                                            WHERE sc.CartId = sl.CartId AND
                                                  State = '未結帳' AND
                                                  Member = '" . $auth . "') AS InCart                        
                        FROM product p
                        LEFT JOIN productimage img
                        ON p.ProductId = img.ProductId
                        WHERE p.DeletedAt IS NULL AND
                            State = 'on'
                        GROUP BY ProductId
                        HAVING Rent = 1
                        ORDER BY CreatedAt";


        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'InCart' => $InCart,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'Image' => $Image,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );

                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];
                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }

    public function read_seller($state,  $auth)
    {


        $query = "SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,
                            Image,
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice
                    FROM product p
                    LEFT JOIN productimage img
                    ON p.ProductId = img.ProductId
                    WHERE p.DeletedAt IS NULL AND
                        State = '" . $state . "' AND                        
                        Seller = '" . $auth . "'
                    GROUP BY ProductId
                    HAVING Rent = 0
                    ORDER BY CreatedAt DESC
                    ";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'Image' => $Image,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );
                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];

                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }

    public function read_seller_rent($state,  $auth)
    {


        $query = "SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,
                            Image,
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice
                    FROM product p
                    LEFT JOIN productimage img
                    ON p.ProductId = img.ProductId
                    WHERE p.DeletedAt IS NULL AND
                        State = '" . $state . "' AND                        
                        Seller = '" . $auth . "'
                    GROUP BY ProductId
                    HAVING Rent = 1
                    ORDER BY CreatedAt DESC
                    ";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'Image' => $Image,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );
                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];

                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }


    public function incart($ProductId, $auth = null)
    {
        $query  = "
        SELECT p.ProductId IN (SELECT ProductId
								FROM shoppingcart sc,
                        	  shoppinglist sl
                        WHERE sc.CartId = sl.CartId AND
                              State = '未結帳' AND
                              Member = '" . $auth . "') AS InCart 
        FROM product p
        WHERE p.ProductId = " . $ProductId . "
        LIMIT 1;
        ";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();

        if ($num > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            extract($row);
        }

        return ($InCart > 0);
    }

    public function read_cartid($ProductId)
    {
        $query = "SELECT ProductId,CartId,sl.Count FROM ShoppingList sl WHERE sl.ProductId =  " . $ProductId . " AND State = '未結帳'";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();

        if ($num > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            extract($row);
            return array('CartId' => $CartId, 'ProductId' => $ProductId, 'Count' => $Count);
        }

        return null;
    }
    //讀取單筆資料
    public function read_single($ProductId, $auth = null)
    {
        $query = "
                        SELECT p.ProductId,
                            Name,
                            Description,
                            Price,
                            Inventory,
                            Image,
                            State,
                            Seller,
                            Watch,
                            p.CreatedAt,
                            Rent,
                            MaxRent,
                            RentPrice,
                            p.ProductId IN (SELECT ProductId
                                            FROM shoppingcart sc,
                                                 shoppinglist sl
                                            WHERE sc.CartId = sl.CartId AND
                                                  State = '未結帳' AND
                                                  Member = '" . $auth . "') AS InCart                        
                        FROM product p
                        LEFT JOIN productimage img
                        ON p.ProductId = img.ProductId
                        WHERE p.DeletedAt IS NULL AND                           
                            p.ProductId = " . $ProductId . "
                        GROUP BY ProductId
                        ORDER BY CreatedAt
        ";

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();


        if ($stmt->rowCount() > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            extract($row);

            $data = array(
                'ProductId' => $ProductId,
                'Name' => $Name,
                'Description' => $Description,
                'Price' => $Price,
                'Inventory' => $Inventory,
                'State' => $State,
                'InCart' => $InCart,
                'Rent' => $Rent,
                'MaxRent' => $MaxRent,
                'RentPrice' => $RentPrice,
                'Seller' => $Seller,
                'Watch' => $Watch,
                'CreatedAt' => $CreatedAt,
            );
            $response_arr = $data;
            return $response_arr;
        } else {
            $response_arr['data'] = null;
            return $response_arr;
        }
    }

    //上傳商品
    public function post($data)
    {

        date_default_timezone_set('Asia/Taipei');

        $query = "INSERT INTO Product
                              (Name,
                               Description,
                               Price,
                               Inventory,                               
                               Seller,                               
                               CreatedAt,
                               UpdatedAt)
                           VALUES ( ? , ? , ? , ? , ? , ? , ? )";

        $stmt = $this->conn->prepare($query);

        $time = date('Y-m-d H:i:s');

        $result = $stmt->execute(array(
            $data['Name'],
            $data['Description'],
            $data['Price'],
            $data['Inventory'],
            $data['Seller'],
            $time,
            $time
        ));

        if ($result) {
            $id = $this->conn->lastInsertId();
            $response_arr = $this->read_single($id);
        } else {

            $response_arr['error'] = '資料新增失敗';
        }
        return $response_arr;
    }

    //上傳商品
    public function post_rent($data)
    {

        date_default_timezone_set('Asia/Taipei');

        $query = "INSERT INTO Product
                              (Name,
                               Description,
                               Price,
                               Inventory,                               
                               Seller,
                               Rent,
                               MaxRent,                               
                               RentPrice,                               
                               CreatedAt,
                               UpdatedAt)
                           VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )";

        $stmt = $this->conn->prepare($query);

        $time = date('Y-m-d H:i:s');

        $result = $stmt->execute(array(
            $data['Name'],
            $data['Description'],
            $data['Price'],
            $data['Inventory'],
            $data['Seller'],
            1,
            $data['MaxRent'],
            $data['RentPrice'],
            $time,
            $time
        ));

        if ($result) {
            $id = $this->conn->lastInsertId();
            $response_arr = $this->read_single($id);
        } else {

            $response_arr['error'] = '資料新增失敗';
        }
        return $response_arr;
    }

    //更新商品
    public function update($ProductId, $data)
    {
        date_default_timezone_set('Asia/Taipei');

        $query = $this->getupdatesql($ProductId, $data);

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        if ($result) {
            return $response_arr['info'] = '資料更新成功';
        } else {
            return $response_arr['info'] = '資料更新失敗';
        }
    }

    //取得更新sql 
    public function getupdatesql($ProductId, $data)
    {
        $query = "UPDATE " . $this->obj->table;
        $tempsql =  ' SET ';
        foreach ($data as $key => $value) {
            $tempsql .= $key . " = '" . $value . "', ";
        }
        $tempsql = substr($tempsql, 0, strrpos($tempsql, ','));
        $query .= $tempsql . " , UpdatedAt = '" . date('Y-m-d H:i:s') . "' WHERE ProductId = " . $ProductId . ";";
        return $query;
    }

    //刪除
    public function delete($ProductId)
    {
        date_default_timezone_set('Asia/Taipei');
        if (!$this->deletecheck($ProductId)) {
            $response_arr['error'] = '該商品已有交易紀錄，不可刪除';
            return $response_arr;
        }
        $query = 'UPDATE ' . $this->obj->table . " SET DeletedAt = '" . date('Y-m-d H:i:s') . "' WHERE ProductId = " . $ProductId . ";";

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        if ($result) {
            $response_arr['info'] = '資料刪除成功';
        } else {
            $response_arr['info'] = '資料刪除失敗';
        }
        return $response_arr;
    }

    public function deletecheck($ProductId)
    {
        $query = "SELECT *
                FROM product p,
                    shoppinglist sl,
                    recorddeal rd
                WHERE p.ProductId = sl.ProductId AND
                    sl.ShoppingId = rd.ShoppingId AND
                    p.ProductId = " . $ProductId . "
        ";

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        if ($stmt->rowCount() > 0) return false;
        return true;
    }

    //推薦商品
    public function recommendproduct($auth, $productid, $type)
    {
        switch ($type) {
            case 0:
                $string = "Buy";
                break;
            case 1:
                $string = "Rent";
                break;
        }
        $query = "
        SELECT p.* ,
                COUNT(*) AS DealCount,
                p.ProductId IN (SELECT ProductId
                                FROM shoppingcart sc,
                                        shoppinglist sl
                                WHERE sc.CartId = sl.CartId AND
                                State = '未結帳' AND
                                Member = '" . $auth . "') AS InCart
        FROM recorddeal rd,
            shoppinglist sl,
            shoppingcart sc,
            product p
        WHERE rd.ShoppingId = sl.ShoppingId AND
            sl.CartId = sc.CartId AND
            sc.Member IN
                (SELECT DISTINCT sc.Member
                FROM recorddeal rd,
                    shoppinglist sl,
                    product p,
                    shoppingcart sc
                WHERE rd.ShoppingId = sl.ShoppingId AND
                    sl.ProductId = p.ProductId AND
                    rd.State = '完成交易' AND
                    rd.DealType = '" . $string . "' AND
                    sc.CartId = sl.CartId AND
                    p.ProductId = " . $productid . ") AND		      
                sl.ProductId <> " . $productid . " AND
                rd.State = '完成交易' AND
                sl.ProductId = p.ProductId AND
                p.State = 'on' AND
                p.Rent = " . $type . "
        GROUP BY p.ProductId
        ";
        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'ProductId' => $ProductId,
                    'Name' => $Name,
                    'InCart' => $InCart,
                    'Description' => $Description,
                    'Price' => $Price,
                    'Inventory' => $Inventory,
                    'State' => $State,
                    'Rent' => $Rent,
                    'MaxRent' => $MaxRent,
                    'RentPrice' => $RentPrice,
                    'Seller' => $Seller,
                    'Watch' => $Watch,
                    'CreatedAt' => $CreatedAt,
                );

                $data_item['Image'] = $this->imageservice->read($data_item['ProductId'])['data'];
                $data_item['Category'] = $this->producttag->read($data_item['ProductId'])['data'];
                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['data'] = null;
        }

        return $response_arr;
    }
}
