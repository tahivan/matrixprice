<?php

class Peerforest_Revolutionslider_Model_Mysql4_Revolutionslider_Collection extends Mage_Core_Model_Mysql4_Collection_Abstract
{
    public function _construct()
    {
        parent::_construct();
        $this->_init('revolutionslider/revolutionslider');
    }
}