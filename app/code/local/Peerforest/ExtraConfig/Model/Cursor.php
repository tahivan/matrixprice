<?php class Peerforest_ExtraConfig_Model_Cursor
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'default', 'label'=>Mage::helper('ExtraConfig')->__('default')),
            array('value'=>'cursor', 'label'=>Mage::helper('ExtraConfig')->__('cursor')),
            array('value'=>'crosshair', 'label'=>Mage::helper('ExtraConfig')->__('crosshair'))
        );
    }

}?>