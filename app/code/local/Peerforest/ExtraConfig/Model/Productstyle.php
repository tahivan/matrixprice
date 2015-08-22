<?php class Peerforest_ExtraConfig_Model_Productstyle
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'1', 'label'=>Mage::helper('ExtraConfig')->__('Product Style 1')),
            array('value'=>'2', 'label'=>Mage::helper('ExtraConfig')->__('Product Style 2')),
            array('value'=>'3', 'label'=>Mage::helper('ExtraConfig')->__('Product Style 3'))       
        );
    }

}?>