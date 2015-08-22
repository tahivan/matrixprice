<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/10/2015
 * Time: 3:51 PM
 */
class QSoft_PriceMatrix_Model_Observer
{

    public function adminhtmlCatalogProductEditPrepareForm(Varien_Event_Observer $observer)
    {
        $form = $observer->getEvent()->getForm();
        $matrixPrice = $form->getElement('matrix_price');
        if ($matrixPrice) {
            $matrixPrice->setRenderer(
                Mage::app()->getLayout()->createBlock('qsoft_pricematrix/adminhtml_catalog_product_edit_tab_price_matrix')
            );
        }
    }
}