<?php 
class Peerforest_Import_Model_Adminhtml_Import extends Mage_Core_Model_Abstract
{
  protected $_importPath;
  protected $_defaultBannerImageName = "default.jpg";  
  protected $_defaultBannerDataPath;
  
  public function __construct()  
  {
    parent::__construct();
    $this->_importPath = Mage::getBaseDir() . '/app/code/local/Peerforest/Import/etc/import/';    
    $this->_defaultBannerDataPath = Mage::getBaseDir() . '/app/code/local/Peerforest/Import/etc/import/banner/default.xml';
  }
  
  public function importThemeDefaultCms($source, $model, $overWrite = false)
  {
    $fileName = str_replace("_","/",$source).".xml";
    $sourcePath = $this->_importPath.$fileName;
    
    $conflictingOldBlocks = array();
    try
    {
      $xmlObj = new Varien_Simplexml_Config($sourcePath);
      $xmlData = $xmlObj->getNode($source);
      
      $importBlockCount = 0;
      foreach($xmlData->children() as $data)
      {
        $oldBlocks = Mage::getModel($model)->getCollection()
                 ->addFieldToFilter('identifier', $data->identifier)
                 ->load();
  
                 
        if(count($oldBlocks) > 0)
        {
          if($overWrite)
          {
              $conflictingOldBlocks[] = $data->identifier;
              foreach($oldBlocks as $old)
              {
               $old->delete(); 
              }              
          }
          else
          {
               $conflictingOldBlocks[] = $data->identifier;
               continue;       
          }
        }
        
        
        if($model == "cms/block")
        {
          $ImportData = array(
                              'title' => $data->title,                                                            
                              'identifier' => $data->identifier,
                              'is_active' => $data->status,
                              'stores' => array(0),
                              'content' => $data->content
                              
                          );
        }
        
        if($model == "cms/page")
        {
          $ImportData = array(
                              'title' => $data->title,                              
                              'identifier' => $data->identifier,
			      'root_template' => 'one_column',
                              'is_active' => $data->status,                              
                              'stores' => array(0),
                              'content' => $data->content                              
                          );
        }  
        Mage::getModel($model)->setData($ImportData)->save();         
         $importBlockCount++;
      }
      
      	if ($importBlockCount)
	{
	  Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('peerforest_import')->__('Number of imported items: %s', $importBlockCount));
              
            if ($overWrite)
            {
               if ($conflictingOldBlocks)
                  Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('peerforest_import')->__('Number of items overwritten : %s<br>Overwritten Identifiers :<br/>%s', count($conflictingOldBlocks), implode(',  ', $conflictingOldBlocks)));
            }
            else
            {
               if ($conflictingOldBlocks)
                  Mage::getSingleton('adminhtml/session')->addNotice(Mage::helper('peerforest_import')->__('Number of items unable to import : %s<br> Not imported items for identifiers (which already exist in the database) :<br/>%s', count($conflictingOldBlocks), implode(',  ', $conflictingOldBlocks)));
            }					
	}
	else
	{
		Mage::getSingleton('adminhtml/session')->addNotice(Mage::helper('peerforest_import')->__('No items were imported'));
		if ($conflictingOldBlocks) {
		  Mage::getSingleton('adminhtml/session')->addNotice(Mage::helper('peerforest_import')->__('Number of items already exist : %s<br> Not imported items for identifiers (which already exist in the database) :<br/>%s', count($conflictingOldBlocks), implode(',  ', $conflictingOldBlocks)));
		}		
	}
    }
    catch(Exception $e)
    {
      Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
		Mage::logException($e);
    }    
  }
  
  public function importThemeDefaultBanner()
  {
    try {
      $xmlObj = new Varien_Simplexml_Config($this->_defaultBannerDataPath);
      $xmlData = $xmlObj->getNode('import');      
      $importBannerCount = 0;
      foreach($xmlData->children() as $data)
      {
	$importData = array();
	$importData['title'] = $data->title;
	$importData['stores'] = array(0);
	if(isset($data->filename) && $data->filename != '') {
	  $importData['filename'] = $data->filename;  
	}
	else {
	  $importData['filename'] = $this->_defaultBannerImageName;  
	}	
	$importData['status'] = $data->status;
	$importData['sorting_order'] = $data->sorting_order;
	$importData['weblink'] = '';
	$importData['content'] = $data->content;
	
	if(isset($importData['filename']) && $importData['filename'] != '') {
	  try {		
		$model = Mage::getModel('bannerslider/bannerslider');		
		$model->setData($importData);
		if ($model->getCreatedTime == NULL || $model->getUpdateTime() == NULL) {
			$model->setCreatedTime(now())
				->setUpdateTime(now());
		} else {
			$model->setUpdateTime(now());
		}
		
		$model->setStores(implode(',',$importData['stores']));		
		$model->save();
		Mage::getSingleton('adminhtml/session')->addSuccess(Mage::helper('peerforest_import')->__('Successfully Inserted Banner Id : '.$model->getId()));
		  
	  } catch (Exception $e) {
		Mage::getSingleton('adminhtml/session')->addNotice(Mage::helper('peerforest_import')->__('Banner Image Failed To Insert : '.$importData['filename']));  
	  }	  
	}
	
      }
    }
    catch(Exception $e)
    {
      Mage::getSingleton('adminhtml/session')->addError($e->getMessage());
		Mage::logException($e);
    } 
  }
}
?>