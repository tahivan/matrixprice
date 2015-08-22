<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/20/2015
 * Time: 4:53 PM
 */
class QSoft_PriceMatrix_Block_Measure extends Mage_Core_Block_Template
{
    protected function _prepareLayout()
    {
        return parent::_prepareLayout();
    }

    public function getMeasureAction()
    {
        return $this->getUrl('matrix/index/calculate');
    }
    public function getCurrentProductId()
    {
        $prdId = '';
        $currentProduct = Mage::registry('current_product');
        if ($currentProduct) {
            $prdId = $currentProduct->getId();
        }
        return $prdId;
    }

}