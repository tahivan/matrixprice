<?php 
class Peerforest_ExtraConfig_Model_Blocklist extends Mage_Eav_Model_Entity_Attribute_Source_Abstract
{
    protected $_options = array();
    
    public function getAllOptions()
    {
        $blocks = Mage::getModel("cms/block")->getCollection();        
        
        $this->_options[] = array(
            'value' => '',
            'label' => 'none'
        );
        foreach($blocks as $block){
            $this->_options[] = array(
                    'value' => $block->getIdentifier(),
                    'label' => $block->getTitle()
                );
        }
        return $this->_options;
    }
    
    public function toOptionArray()
    {        
        return $this->getAllOptions();
    }
}