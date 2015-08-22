<?php class Peerforest_ExtraConfig_Model_HeaderType
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'header', 'label'=>Mage::helper('ExtraConfig')->__('Default')),
            array('value'=>'header2', 'label'=>Mage::helper('ExtraConfig')->__('Header 2')),
            array('value'=>'header3', 'label'=>Mage::helper('ExtraConfig')->__('Header 3')),
            array('value'=>'header4', 'label'=>Mage::helper('ExtraConfig')->__('Header 4')),
            array('value'=>'header5', 'label'=>Mage::helper('ExtraConfig')->__('Header 5'))
        );
    }

}?>