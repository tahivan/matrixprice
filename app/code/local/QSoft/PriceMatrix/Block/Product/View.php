<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/20/2015
 * Time: 3:01 PM
 */
class QSoft_PriceMatrix_Block_Product_View extends Mage_Catalog_Block_Product_View
{
    protected function _prepareLayout()
    {
        $block = $this->getLayout()->createBlock(
            'qsoft_pricematrix/measure',
            'measure',
            array('template' => 'qsoft/measure.phtml')
        );
        $this->setChild('measure', $block);
        $this->getLayout()->getBlock('head')->addJs('qsoft/calculate.js');
        return parent::_prepareLayout();
    }


}