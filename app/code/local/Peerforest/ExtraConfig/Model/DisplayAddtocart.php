<?php class Peerforest_ExtraConfig_Model_DisplayAddtocart
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'off', 'label'=>Mage::helper('ExtraConfig')->__('Off')),
            array('value'=>'on', 'label'=>Mage::helper('ExtraConfig')->__('On')),            
            array('value'=>'onhover', 'label'=>Mage::helper('ExtraConfig')->__('On Hover'))
        );
    }

}?>