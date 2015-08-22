<?php

class Peerforest_Revolutionslider_Model_Mysql4_Revolutionslider extends Mage_Core_Model_Mysql4_Abstract
{
    public function _construct()
    {    
        // Note that the bannerslider_id refers to the key field in your database table.
        $this->_init('revolutionslider/revolutionslider', 'revolutionslider_id');
    }
}