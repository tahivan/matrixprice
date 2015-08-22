<?php
class Peerforest_Revolutionslider_Block_Adminhtml_Revolutionslider extends Mage_Adminhtml_Block_Widget_Grid_Container
{
  public function __construct()
  {
    $this->_controller = 'adminhtml_revolutionslider';
    $this->_blockGroup = 'revolutionslider';
    $this->_headerText = Mage::helper('revolutionslider')->__('Banner Manager');
    $this->_addButtonLabel = Mage::helper('revolutionslider')->__('Add Banner');
    parent::__construct();
  }
}