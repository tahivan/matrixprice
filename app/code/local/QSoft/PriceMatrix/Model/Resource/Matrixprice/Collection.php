<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/21/2015
 * Time: 10:46 AM
 */
class QSoft_PriceMatrix_Model_Resource_Matrixprice_Collection extends Mage_Core_Model_Resource_Db_Collection_Abstract
{
    protected function _construct()
    {
        $this->_init('qsoft_pricematrix/matrixprice');
    }
}