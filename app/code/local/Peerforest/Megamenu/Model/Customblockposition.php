<?php class Peerforest_Megamenu_Model_Customblockposition extends Mage_Eav_Model_Entity_Attribute_Source_Abstract
{
   public function getAllOptions()
    {
        if ($this->_options === null) {
            $this->_options = array(
                array(
                    'value' => 'top',
                    'label' => 'Top of products only',
                ),
                 array(
                    'value' => 'top-sidebar',
                    'label' => 'Top of products & sidebar',
                ),
                  array(
                    'value' => 'top-sidebar-full',
                    'label' => 'Top of products & sidebar - fullwidth',
                ),
    
            );
        }
        return $this->_options;
    }

}?>