<?php class Magestore_Bannerslider_Model_System_Config_Bannertransitionstyle
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'default', 'label'=>Mage::helper('ExtraConfig')->__('Default')),
            array('value'=>'backSlide', 'label'=>Mage::helper('ExtraConfig')->__('Back slide')),
            array('value'=>'fade', 'label'=>Mage::helper('ExtraConfig')->__('Fade')),
            array('value'=>'fadeUp', 'label'=>Mage::helper('ExtraConfig')->__('Fade up')),
            array('value'=>'goDown', 'label'=>Mage::helper('ExtraConfig')->__('Go down'))
            
        );
    }

}?>