<?php class Peerforest_ExtraConfig_Model_Banneroption
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'default', 'label'=>Mage::helper('ExtraConfig')->__('Default Slider')),
            array('value'=>'revolution', 'label'=>Mage::helper('ExtraConfig')->__('Revolution Slider'))
        );
    }

}?>