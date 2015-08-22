<?php

class Peerforest_Revolutionslider_Block_Adminhtml_Revolutionslider_Edit_Tabs extends Mage_Adminhtml_Block_Widget_Tabs
{

  public function __construct()
  {
      parent::__construct();
      $this->setId('revolutionslider_tabs');
      $this->setDestElementId('edit_form');
      $this->setTitle(Mage::helper('revolutionslider')->__('Information'));
  }

  protected function _beforeToHtml()
  {
      $this->addTab('form_section', array(
          'label'     => Mage::helper('revolutionslider')->__('General Information'),
          'title'     => Mage::helper('revolutionslider')->__('General Information'),
          'content'   => $this->getLayout()->createBlock('revolutionslider/adminhtml_revolutionslider_edit_tab_form')->toHtml(),
      ));
	  
	  
     
      return parent::_beforeToHtml();
  }
}