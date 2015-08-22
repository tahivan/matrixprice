<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/11/2015
 * Time: 1:50 PM
 */
class QSoft_PriceMatrix_Model_Product_Attribute_Backend_Matrixprice extends
    Mage_Catalog_Model_Product_Attribute_Backend_Groupprice_Abstract
{
    /**
     * Retrieve resource instance
     *
     * @return Mage_Catalog_Model_Resource_Eav_Mysql4_Product_Attribute_Backend_Tierprice
     */
    protected function _getResource()
    {
        return Mage::getResourceSingleton('qsoft_pricematrix/product_attribute_backend_matrixprice');
    }

    /**
     * Error message when duplicates
     *
     * @return string
     */
    protected function _getDuplicateErrorMessage()
    {
        return Mage::helper('catalog')->__('Duplicate matrix price.');
    }

    /**
     * Don't need validate as group price and tier price
     * because structure is different
     *
     * @return bool
     */
    public function validate()
    {
        return true;
    }

    /**
     * @param array $objectArray
     * @return array
     */
    protected function _getAdditionalUniqueFields($objectArray)
    {
        $uniqueFields = parent::_getAdditionalUniqueFields($objectArray);
        $uniqueFields['drop'] = $objectArray['drop'] * 1;
        $uniqueFields['width'] = $objectArray['width'] * 1;
        return $uniqueFields;
    }

}