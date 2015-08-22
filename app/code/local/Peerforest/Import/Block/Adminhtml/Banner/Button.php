<?php
class Peerforest_Import_Block_Adminhtml_Banner_Button extends Mage_Adminhtml_Block_System_Config_Form_Field
{
  protected function _getElementHtml(Varien_Data_Form_Element_Abstract $element)
    {
		$elementImportData = $element->getOriginalData();		
		
		$buttonLabel = '';
		if (isset($elementImportData['label']))
			$buttonLabel = ' ' . $elementImportData['label'];

		$url = $this->getUrl('peerforest/import_banner/default');
		
		$html = $this->getLayout()->createBlock('adminhtml/widget_button')
			->setType('button')
			->setClass('import-cms')
			->setLabel('Import' . $buttonLabel)
			->setOnClick("setLocation('$url')")
			->toHtml();
			
        return $html;
    } 
}
?>