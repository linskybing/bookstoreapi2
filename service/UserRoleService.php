<?php

namespace Service;


use Model\UserRole;
use PDO;

class UserRoleService
{
    public function __construct($db)
    {
        $this->conn = $db;
        $this->obj = new UserRole();
    }

    //讀取
    public function read()
    {

        $query = 'SELECT * FROM ' . $this->obj->table . ' WHERE DeletedAt IS NULL';

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();
        if ($num > 0) {
            $response_arr = array();
            $response_arr['data'] = array();
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'UserRoleId' => $UserRoleId,
                    'User' => $User,
                    'RoleId' => $RoleId,
                    'CreatedAt' => $CreatedAt,
                    'UpdatedAt' => $UpdatedAt,
                );
                array_push($response_arr['data'], $data_item);
            }
        } else {
            $response_arr['info'] = '尚未擁有後臺角色';
        }

        return $response_arr;
    }

    //讀取角色權限相關資訊
    public function readpermisson($auth)
    {
        $query = "SELECT u.Name,
                        u.Account,
                        ur.RoleId,
                        r.RoleName,
                        f.FunctionName
                FROM users u,
                    userrole ur,
                    role r,
                    rolepermissions rs,
                    functionlist f
                WHERE u.Account = ur.`User` AND
                    ur.RoleId = r.RoleId AND
                    r.RoleId = rs.RoleId AND
                    rs.FunctionId = f.FunctionId AND
                    u.Account='" . $auth . "'";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();

        $response_arr = array();
        if ($num > 0) {
            $btn = true;
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'Name' => $Name,
                    'Account' => $Account,
                    'RoleId' => $RoleId,
                    'RoleName' => $RoleName,
                    'FunctionName' => $FunctionName,
                );

                if ($btn) {
                    $response_arr = array(
                        'Name' => $data_item['Name'],
                        'Account' => $data_item['Account'],
                        'RoleId' => $data_item['RoleId'],
                        'RoleName' => $data_item['RoleName'],
                    );
                    $response_arr['data'] = array();
                    $btn = false;
                }
                array_push($response_arr['data'], $data_item['FunctionName']);
            }
        } else {
            $response_arr = null;
        }

        return $response_arr;
    }

    //讀取角色權限相關資訊
    public function readpermissonall()
    {
        $query = "SELECT r.RoleId,
                         r.RoleName,
                         f.FunctionId,
                         f.FunctionName
                FROM role r,
                    rolepermissions rs,
                    functionlist f
                WHERE  r.RoleId = rs.RoleId AND
                    rs.FunctionId = f.FunctionId  AND r.DeletedAt IS NULL
                ORDER BY r.RoleId";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();

        $response_arr = array();
        if ($num > 0) {
            $count = -1;
            $nowid = 0;
            $btn = true;
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'RoleId' => $RoleId,
                    'RoleName' => $RoleName,
                    'FunctionId' => $FunctionId,
                    'FunctionName' => $FunctionName,
                );
                if ($nowid != $data_item['RoleId']) {
                    $btn = true;
                }
                if ($btn) {
                    $nowid = $data_item['RoleId'];
                    $count++;
                    $response_arr[$count] = array();

                    $response_arr[$count] = array(
                        'RoleId' => $data_item['RoleId'],
                        'RoleName' => $data_item['RoleName'],
                        'Count' => $this->checkuserrole($data_item['RoleId'])
                    );
                    $response_arr[$count]['Data'] = array();
                    $btn = false;
                }
                array_push($response_arr[$count]['Data'], array(
                    'FunctionId' => $data_item['FunctionId'],
                    'FunctionName' => $data_item['FunctionName'],
                ));
            }
        } else {
            $response_arr = null;
        }

        return $response_arr;
    }


    //讀取角色權限相關資訊
    public function readallpermisson()
    {
        $query = "SELECT u.Name,
                            u.Account,
                            list.RoleId,
                            list.RoleName                    
                    FROM users u                   
                    LEFT JOIN (SELECT r.*,ur.`User`
                                        FROM role r,
                                            userrole ur
                                        WHERE ur.RoleId = r.RoleId)list                    
                    ON u.Account = list.`User`";

        $stmt  = $this->conn->prepare($query);

        $result = $stmt->execute();

        $num = $stmt->rowCount();

        $response_arr = array();

        if ($num > 0) {
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);
                $data_item = array(
                    'Name' => $Name,
                    'Account' => $Account,
                    'RoleId' => $RoleId,
                    'RoleName' => $RoleName,

                );
                array_push($response_arr, $data_item);
            }
        } else {
            $response_arr = null;
        }

        return $response_arr;
    }

    //讀取單筆資料
    public function read_single($UserRoleId)
    {
        $query = "SELECT * FROM " . $this->obj->table . " WHERE UserRoleId = " . $UserRoleId . " AND DeletedAt IS NULL;";

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();


        if ($stmt->rowCount() > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            extract($row);

            $data = array(
                'UserRoleId' => $UserRoleId,
                'User' => $User,
                'RoleId' => $RoleId,
                'CreatedAt' => $CreatedAt,
                'UpdatedAt' => $UpdatedAt,
            );

            $response_arr = $data;
            return $response_arr;
        } else {
            $response_arr['info'] = '尚未擁有角色身分';
            return $response_arr;
        }
    }

    //上傳
    public function post($data)
    {

        date_default_timezone_set('Asia/Taipei');

        $query = "INSERT INTO " . $this->obj->table . "
                           (User, 
                           RoleId,                                                                                                               
                           CreatedAt,
                           UpdatedAt) 
                  VALUES ( ? , ? , ? , ? )";

        $stmt = $this->conn->prepare($query);

        $time = date('Y-m-d H:i:s');

        $result = $stmt->execute(array(
            $data['User'],
            $data['RoleId'],
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

    //更新
    public function update($User, $data)
    {
        date_default_timezone_set('Asia/Taipei');

        $query = $this->getupdatesql($User, $data);

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        if ($result) {
            return $response_arr['info'] = '資料更新成功';
        } else {
            return $response_arr['info'] = '資料更新失敗';
        }
    }

    //取得更新sql 
    public function getupdatesql($user, $data)
    {
        $query = "UPDATE " . $this->obj->table;
        $tempsql =  ' SET ';
        foreach ($data as $key => $value) {
            $tempsql .= $key . " = '" . $value . "', ";
        }
        $tempsql = substr($tempsql, 0, strrpos($tempsql, ','));
        $query .= $tempsql . " , UpdatedAt = '" . date('Y-m-d H:i:s') . "' WHERE User = '" . $user . "';";
        return $query;
    }

    //刪除
    public function delete($UserRoleId)
    {
        $query = 'DELETE FROM ' . $this->obj->table . " WHERE UserRoleId = " . $UserRoleId . ";";

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        if ($result) {
            $response_arr['info'] = '資料刪除成功';
            return $response_arr;
        } else {
            return $response_arr['info'] = '資料刪除失敗';
        }
    }

    //檢查重複新增
    public function checkinsert($user, $roleid)
    {
        $query = 'SELECT * FROM ' . $this->obj->table . " WHERE User = '" . $user . "' AND RoleId = " . $roleid . ' AND  DeletedAt IS NULL';

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        return ($stmt->rowCount() > 0) ? false : true;
    }

    public function checkuserrole($roleid)
    {
        $query = 'SELECT Count(*) AS Count FROM ' . $this->obj->table . " WHERE RoleId = " . $roleid;

        $stmt = $this->conn->prepare($query);

        $result = $stmt->execute();

        $Count = 0;

        if ($stmt->rowCount() > 0) {
            $row = $stmt->fetch(PDO::FETCH_ASSOC);
            extract($row);
        }

        return $Count;
    }
}
