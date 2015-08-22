<?php class Peerforest_ExtraConfig_Model_Bannerposition
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'1', 'label'=>Mage::helper('ExtraConfig')->__('Display banner with header')),
            array('value'=>'2', 'label'=>Mage::helper('ExtraConfig')->__('Display banner below header')),
            array('value'=>'3', 'label'=>Mage::helper('ExtraConfig')->__('Display banner with content'))
        );
    }

}?>