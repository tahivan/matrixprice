<?php class Peerforest_ExtraConfig_Model_Captionposition
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'left', 'label'=>Mage::helper('ExtraConfig')->__('Left')),
             array('value'=>'right', 'label'=>Mage::helper('ExtraConfig')->__('Right'))
        );
    }

}?>