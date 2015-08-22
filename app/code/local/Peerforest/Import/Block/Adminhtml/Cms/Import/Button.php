<?php
class Peerforest_Import_Block_Adminhtml_Cms_Import_Button extends Mage_Adminhtml_Block_System_Config_Form_Field
{
  protected function _getElementHtml(Varien_Data_Form_Element_Abstract $element)
    {
		$elementImportData = $element->getOriginalData();
		if (isset($elementImportData['import_for']))
		{
			$name = $elementImportData['import_for'];
		}
		else
		{
			return '<div>Action can not be performed.</div>';
		}
		
		$buttonLabel = '';
		if (isset($elementImportData['label']))
			$buttonLabel = ' ' . $elementImportData['label'];

		$url = $this->getUrl('peerforest/import_' . $name);
		
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