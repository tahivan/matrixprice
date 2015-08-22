<?php
class Peerforest_Megamenu_Model_Menutype extends Mage_Eav_Model_Entity_Attribute_Source_Abstract
{
   protected $_options = array();
   
   public function getAllOptions()
   {      
      $this->_options[] = array('value' => 'megamenu-horizontal','label' => 'Mega Menu');
      $this->_options[] = array('value' => 'megamenu-vertical','label' => 'Vertical');
        
      return $this->_options;
   }

}