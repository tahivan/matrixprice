<?php

class Peerforest_Revolutionslider_Model_Revolutionslider extends Mage_Core_Model_Abstract
{
    public function _construct()
    {
        parent::_construct();
        $this->_init('revolutionslider/revolutionslider');
    }
}