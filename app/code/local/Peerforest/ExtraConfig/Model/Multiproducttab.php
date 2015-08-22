<?php class Peerforest_ExtraConfig_Model_Multiproducttab
{
    public function toOptionArray()
    {
        $options = array();
        $options[] = array('value'=>'1_featured', 'label'=>Mage::helper('ExtraConfig')->__('1: Featured'));
        $options[] = array('value'=>'2_new', 'label'=>Mage::helper('ExtraConfig')->__('2: New'));
        $options[] = array('value'=>'3_hit', 'label'=>Mage::helper('ExtraConfig')->__('3: Hit'));
        $options[] = array('value'=>'4_random', 'label'=>Mage::helper('ExtraConfig')->__('4: Random'));
        $options[] = array('value'=>'5_rated', 'label'=>Mage::helper('ExtraConfig')->__('5: Rated'));
        
        
        $attributeId = Mage::getResourceModel('eav/entity_attribute')->getIdByCode('catalog_product','custom_product');
        $attribute = Mage::getModel('catalog/resource_eav_attribute')->load($attributeId);
        $attributeOptions = $attribute ->getSource()->getAllOptions();	
        
        $attributeOptions = array_slice($attributeOptions, 1);
        
        $i = 6;    
        foreach ($attributeOptions as $option)
        {
            $options[] = array('value'=> $i."_".strtolower($option['label']), 'label'=>Mage::helper('ExtraConfig')->__(ucfirst($i.": ".$option['label'])));
            $i++;
        }
        
        return $options;
    }

}?>