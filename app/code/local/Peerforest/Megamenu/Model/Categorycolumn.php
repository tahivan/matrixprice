<?php 
class Peerforest_Megamenu_Model_Categorycolumn extends Mage_Eav_Model_Entity_Attribute_Source_Abstract
{
    protected $_options = array();
    
    public function getAllOptions()
    {
        $this->_options[] = array( 'value' => 1, 'label' => 1 );
        $this->_options[] = array( 'value' => 2, 'label' => 2 );
        $this->_options[] = array( 'value' => 3, 'label' => 3 );
        $this->_options[] = array( 'value' => 4, 'label' => 4 );
        $this->_options[] = array( 'value' => 5, 'label' => 5 );
        $this->_options[] = array( 'value' => 6, 'label' => 6 );
        $this->_options[] = array( 'value' => 7, 'label' => 7 );
        $this->_options[] = array( 'value' => 8, 'label' => 8 );
        return $this->_options;
    }
}