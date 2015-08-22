<?php class Peerforest_Megamenu_Model_Thumnailpositionsublevel
{
    public function toOptionArray()
    {
        return array(                        
            array('value'=>'left', 'label'=>Mage::helper('megamenu')->__('Left')),
            array('value'=>'right', 'label'=>Mage::helper('megamenu')->__('Right'))
        );
    }

}?>