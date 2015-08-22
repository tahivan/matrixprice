<?php class Peerforest_ExtraConfig_Model_Zoomtype
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'window', 'label'=>Mage::helper('ExtraConfig')->__('window')),
            array('value'=>'lens', 'label'=>Mage::helper('ExtraConfig')->__('lens')),
            array('value'=>'inner', 'label'=>Mage::helper('ExtraConfig')->__('inner'))
        );
    }

}?>