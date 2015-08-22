<?php class Peerforest_MultiProduct_Model_DualMultiproducttab
{
    public function toOptionArray()
    {
        $options = array();        
        $options[] = array('value'=>'1_new', 'label'=>Mage::helper('ExtraConfig')->__('1: New'));        
        $options[] = array('value'=>'2_random', 'label'=>Mage::helper('ExtraConfig')->__('2: Random'));
        $options[] = array('value'=>'3_rated', 'label'=>Mage::helper('ExtraConfig')->__('3: Rated'));        
        
        
        $attributeId = Mage::getResourceModel('eav/entity_attribute')->getIdByCode('catalog_product','custom_product');
        $attribute = Mage::getModel('catalog/resource_eav_attribute')->load($attributeId);
        $attributeOptions = $attribute ->getSource()->getAllOptions();	
        
        $attributeOptions = array_slice($attributeOptions, 1);
        
        $i = 4;    
        foreach ($attributeOptions as $option)
        {
            $options[] = array('value'=> $i."_".strtolower($option['label']), 'label'=>Mage::helper('ExtraConfig')->__(ucfirst($i.": ".$option['label'])));
            $i++;
        }
        $options[$i] = array('value'=> "_customblock", 'label'=>Mage::helper('ExtraConfig')->__(ucfirst($i.": Custom Block")));
        return $options;
    }

}?>