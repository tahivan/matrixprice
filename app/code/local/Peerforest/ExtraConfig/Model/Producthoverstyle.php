<?php class Peerforest_ExtraConfig_Model_Producthoverstyle
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'1', 'label'=>Mage::helper('ExtraConfig')->__('Product Hover Style 1')),
            array('value'=>'2', 'label'=>Mage::helper('ExtraConfig')->__('Product Hover Style 2')),
            array('value'=>'3', 'label'=>Mage::helper('ExtraConfig')->__('Product Hover Style 3')),
            array('value'=>'4', 'label'=>Mage::helper('ExtraConfig')->__('Product Hover Style 4'))       
        );
    }

}?>