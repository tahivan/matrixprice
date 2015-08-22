<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/11/2015
 * Time: 1:55 PM
 */
class QSoft_PriceMatrix_Model_Resource_Product_Attribute_Backend_Matrixprice extends
    Mage_Catalog_Model_Resource_Product_Attribute_Backend_Groupprice_Abstract
{
    public function _construct()
    {
        $this->_init('qsoft_pricematrix/product_attribute_matrix_price', 'value_id');
    }

    /**
     * Add DROP,WIDTH column
     *
     * @param array $columns
     * @return array
     */
    protected function _loadPriceDataColumns($columns)
    {
        $columns = parent::_loadPriceDataColumns($columns);
        $columns['drop'] = 'drop';
        $columns['width'] = 'width';
        return $columns;
    }
}