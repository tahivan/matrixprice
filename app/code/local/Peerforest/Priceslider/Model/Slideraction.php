<?php class Peerforest_Priceslider_Model_Slideraction
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'slider', 'label'=>Mage::helper('priceslider')->__('On Slide')),
            array('value'=>'button', 'label'=>Mage::helper('priceslider')->__('On Click (Button)'))
        );
    }

}?>