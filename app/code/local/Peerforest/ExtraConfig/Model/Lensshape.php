<?php class Peerforest_ExtraConfig_Model_Lensshape
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'square', 'label'=>Mage::helper('ExtraConfig')->__('square')),
            array('value'=>'round', 'label'=>Mage::helper('ExtraConfig')->__('round'))
        );
    }

}?>