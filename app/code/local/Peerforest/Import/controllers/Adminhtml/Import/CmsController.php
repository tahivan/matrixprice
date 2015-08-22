<?php
class Peerforest_Import_Adminhtml_Import_CmsController extends Mage_Adminhtml_Controller_Action
{
  public function indexAction()
  {
    $this->getResponse()->setRedirect($this->getUrl("adminhtml/system_config/edit/section/import"));
  }
                                      
  public function blocksAction()
  {
    $overWrite = Mage::getStoreConfig("import/general/overwirte_cms_block");
    if($overWrite == 1){$overWrite = true;} else {$overWrite = false;}
    $model = Mage::getModel("themeblockimport/import");
    $model->importThemeDefaultCms("cms_static_block", "cms/block", $overWrite);
    $this->indexAction();
  }
  
  public function pagesAction()
  {
    $overWrite = Mage::getStoreConfig("import/general/overwirte_cms_page");
    if($overWrite == 1){$overWrite = true;} else {$overWrite = false;}
    $model = Mage::getModel("themeblockimport/import");
    $model->importThemeDefaultCms("cms_page","cms/page", $overWrite);
    $this->indexAction();
  }
}
?>