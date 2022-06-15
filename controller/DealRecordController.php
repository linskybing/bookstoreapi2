<?php

namespace Controller;


use Service\Authentication;
use Service\CategoryService;
use Service\DealRecordService;
use Service\MailService;
use Service\ProductService;
use Service\ShoppingListService;
use Service\UserService;
use Service\Validator;


class DealRecordController
{
    protected $dealservice;
    protected $listservice;
    protected $mailservice;
    protected $memberservice;
    protected $productservice;
    protected $categroy;
    public function __construct($db)
    {
        $this->dealservice = new DealRecordService($db);
        $this->listservice = new ShoppingListService($db);
        $this->mailservice = new MailService();
        $this->memberservice = new UserService($db);
        $this->productservice = new ProductService($db);
        $this->categroy = new CategoryService($db);
    }

    public function Get($request, $state)
    {
        $auth = Authentication::getPayload();
        if (isset($auth['error'])) return $auth;
        if (isset($auth['CartId'])) {
            $data = $this->dealservice->read($auth['CartId'], $state);
        } else {
            $data = null;
        }

        return $data;
    }

    public function Get_Seller($request, $state)
    {
        $auth = Authentication::isAuth();
        if (isset($auth['error'])) return $auth;

        $data = $this->dealservice->read_seller($auth, $state);
        return $data;
    }


    public function Get_Single($request, $id)
    {
        $auth = Authentication::isAuth();
        if (isset($auth['error'])) return $auth;

        $data = $this->dealservice->read_single($id);
        return $data;
    }

    public function Post($request)
    {
        $auth = Authentication::isAuth();
        if (isset($auth['error'])) return $auth;

        $data = $request->getBody();

        $validate = Validator::check(array(
            'ShoppingId' => ['required'],
            'State' => ['required'],
            'Phone' => ['required'],
            'DealMethod' => ['required'],
            'SentAddress' => ['required'],
            'DealType' => ['required'],
        ), $data);
        if ($validate != '') {
            return $validate;
        } else {
            $result = $this->dealservice->post($data);
            return $result;
        }
    }

    public function Patch($request, $id)
    {
        $auth = Authentication::isAuth();
        if (isset($auth['error'])) return $auth;

        $data = $request->getBody();

        $datadeal = $this->dealservice->read_single($id);
        if (isset($datadeal['RecordId'])) {
            if (isset($data['State']) && $data['State'] == '未歸還') {
                date_default_timezone_set('Asia/Taipei');
                $data['StartTime'] =  date('Y-m-d H:i:s');
                $data['EndTime'] = date('Y-m-d H:i:s', strtotime(date('Y-m-d H:i:s') . '+ ' . $datadeal['Count'] . 'days'));
            }
            if (isset($data['State']) && $data['State'] == '已歸還') {
                date_default_timezone_set('Asia/Taipei');
                $data['ReturnTime'] = date('Y-m-d H:i:s');
            }

            if (isset($data['Customer_Agree']) && $data['Customer_Agree'] && !isset($data['State'])) {
                $deal = $this->dealservice->read_single($datadeal['RecordId']);
                $body = $this->mailservice->getcancelbody($id);
                $userdata = $this->memberservice->read_single($deal['Seller']);
                $this->mailservice->sendmail($userdata['Email'], $body);
            }

            if (isset($data['Seller_Agree']) && $data['Seller_Agree'] && !isset($data['State'])) {
                $deal = $this->dealservice->read_single($datadeal['RecordId']);
                $body = $this->mailservice->getcancelbody2($id);
                $userdata = $this->memberservice->read_single($deal['Member']);
                $this->mailservice->sendmail($userdata['Email'], $body);
            }

            if (isset($data['State']) && $data['State'] == '已取消') {
                $product = $this->productservice->read_single($datadeal['ProductId']);
                $count  = $product['Inventory'] + $datadeal['Count'];
                $update = array(
                    'Inventory' => $count
                );
                $this->productservice->update($datadeal['ProductId'], $update);
            }

            if (isset($data['State']) && $data['State'] == '完成交易') {
                $product = $this->productservice->read_single($datadeal['ProductId']);
                $userdata = $this->memberservice->read_single($product['Seller']);
                if ($datadeal['DealType'] == 'Rent') {
                    $userdata['Money'] = (int)$userdata['Money'] + (int) $datadeal['Count'] * (int) $datadeal['RentPrice'];
                } else {
                    $userdata['Money'] = (int)$userdata['Money'] + (int) $datadeal['Count'] * (int) $datadeal['Price'];
                }
                $this->memberservice->update($userdata['Account'], array('Money' => $userdata['Money']));
            }

            $result['info'] = $this->dealservice->update($id, $data);
            return $result;
        } else {
            return ['error' => '交易不存在'];
        }
    }

    public function Delete($request, $id)
    {
        $auth = Authentication::isAuth();
        if (isset($auth['error'])) return $auth;

        $data = $this->dealservice->read_single($id);
        if (isset($data['RecordId'])) {
            $result['info'] = $this->dealservice->delete($id);
            return $result;
        } else {
            return ['error' => '交易不存在'];
        }
    }

    public function TagForChart($request)
    {
        $data = array();
        $taglist = $this->categroy->read();

        foreach ($taglist['data'] as $item => $value) {
            $temp = array();
            if (isset($value['Tag'])) {
                $temp['CategoryId'] = $value['CategoryId'];
                $temp['Tag'] = $value['Tag'];
                $deal = $this->dealservice->readby_tag($value['Tag']);
                if ($deal['data']) {
                    $temp['Data'] = $deal['data'];
                }
                array_push($data, $temp);
            }
        }

        
        for ($i = 0; $i < Count($data); $i++) {

            $key = $i;
            if (!isset($data[$key]['Data'])) {
                $data[$key]['Data'] = array();
                $data[$key]['Total'] = 0;
            } else {

                $data[$key]['Total'] = 0;
                for ($j = 0; $j < Count($data[$key]['Data']); $j++) {
                    $data[$key]['Total'] += $data[$key]['Data'][$j]['Amount'] * $data[$key]['Data'][$j]['Count'];
                }
            }
        }

        // 排序
        for ($i = 0; $i < Count($data) - 1; $i++) {
            for ($j = 0; $j < Count($data) - 1 - $i; $j++) {
                if ($data[$j]['Total'] < $data[$j + 1]['Total']) {
                    $temp = $data[$j];
                    $data[$j] = $data[$j + 1];
                    $data[$j + 1] = $temp;
                }
            }
        }
        return $data;
    }
}
