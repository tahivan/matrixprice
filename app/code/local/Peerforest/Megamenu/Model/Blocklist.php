<?php 
class Peerforest_Megamenu_Model_Blocklist extends Mage_Eav_Model_Entity_Attribute_Source_Abstract
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
        $blocks = Mage::getModel("cms/block")->getCollection();
        $i=1;
        foreach($blocks as $block){
            if(substr($block->getIdentifier(),0,5) == "menu_") {
            $this->_options[] = array(
                    'value' => $i.")".$block->getIdentifier(),
                    'label' => $i.". ".$block->getTitle()
                );
             $i++;
            }
        }
        return $this->_options;
    }
}