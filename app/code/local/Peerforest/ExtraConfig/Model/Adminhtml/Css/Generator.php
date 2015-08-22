<?php
class Peerforest_ExtraConfig_Model_Adminhtml_Css_Generator
{
  protected $_cssFileName = array();  
  protected $_themeSkinCssPath;  
   
  public function __construct()
  {    
    $this->_cssFileName[] = "peer_grid";
    $this->_cssFileName[] = "peer_layout";
    $package = Mage::getStoreConfig('design/package/name');
    $overridefilename = "";    
    if(Mage::app()->getRequest()->getParam('store')){
      $overridefilename .= "_".Mage::app()->getRequest()->getParam('store');
    }
    else{
      $overridefilename .= "_default";
    }
    
    foreach($this->_cssFileName as $filename) {             
      $this->_themeSkinCssPath = Mage::getBaseDir()."/skin/frontend/neighborhood/default/css/override/".$filename.$overridefilename.".css";      
      $updateCss = Mage::getBaseDir('design')."/frontend/neighborhood/default/template/override/".$filename.".phtml";      
      if (is_file($updateCss))
      {
        ob_start();
        include $updateCss;
        $updateCss = ob_get_clean();
      }      
      $this->_writeFile($updateCss,$this->_themeSkinCssPath);
      $this->_themeSkinCssPath = "";
    }
  }  
  
  private function _writeFile($cssdata = "",$path = "")
  {
    chmod($path, 0644);
    if(file_exists($path))
    {
      unlink($path);
    }        
    $FileHandle = fopen($path, 'x') or die("can't create or open file");
    ftruncate($FileHandle, 0);    
    fwrite($FileHandle, $cssdata);    
    fclose($FileHandle);    
  }
}

?>