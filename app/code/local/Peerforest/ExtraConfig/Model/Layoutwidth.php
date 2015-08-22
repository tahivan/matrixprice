<?php class Peerforest_ExtraConfig_Model_Layoutwidth
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'960', 'label'=>Mage::helper('ExtraConfig')->__('1024 px')),
            array('value'=>'1280', 'label'=>Mage::helper('ExtraConfig')->__('1280 px')),
            array('value'=>'1360', 'label'=>Mage::helper('ExtraConfig')->__('1360 px')),
            array('value'=>'1440', 'label'=>Mage::helper('ExtraConfig')->__('1440 px')),
            array('value'=>'1680', 'label'=>Mage::helper('ExtraConfig')->__('1680 px')),
            array('value'=>'1920', 'label'=>Mage::helper('ExtraConfig')->__('1920 px')),
            array('value'=>'custom', 'label'=>Mage::helper('ExtraConfig')->__('Custom Width'))            
        );
    }

}?>