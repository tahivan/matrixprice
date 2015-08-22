<?php class Peerforest_ExtraConfig_Model_Alterimage
{
    public function toOptionArray()
    {
        return array(
            array('value'=>'sortorder', 'label'=>Mage::helper('ExtraConfig')->__('By SortOrder')),
            array('value'=>'label', 'label'=>Mage::helper('ExtraConfig')->__('By Label'))
        );
    }

}?>