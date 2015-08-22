<?php
class Peerforest_Import_Adminhtml_Import_BannerController extends Mage_Adminhtml_Controller_Action
{
  public function indexAction()
  {
    $this->getResponse()->setRedirect($this->getUrl("adminhtml/system_config/edit/section/import"));
  }
                                      
  public function defaultAction()
  {     
    $model = Mage::getModel("themeblockimport/import");
    $model->importThemeDefaultBanner();
    $this->indexAction();
  }
}
?>