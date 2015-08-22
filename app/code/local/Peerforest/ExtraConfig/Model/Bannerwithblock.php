<?php class Peerforest_ExtraConfig_Model_Bannerwithblock
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'1', 'label'=>Mage::helper('ExtraConfig')->__('Without Block')),
            array('value'=>'2', 'label'=>Mage::helper('ExtraConfig')->__('Left Block')),
            array('value'=>'3', 'label'=>Mage::helper('ExtraConfig')->__('Right Block')),
            array('value'=>'4', 'label'=>Mage::helper('ExtraConfig')->__('Left & Right block'))
        );
    }

}?>