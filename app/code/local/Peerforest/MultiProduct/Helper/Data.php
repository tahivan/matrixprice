<?php 
class Peerforest_MultiProduct_Helper_Data extends Mage_Core_Helper_Abstract
{
    public function productMaxLimit($id)
    {	
	$limitConfig = 'multiproduct/block'.$id.'/product_load_max';	
	$default = 20;
	$limit = Mage::getStoreConfig($limitConfig);
	if($limit == null || $limit == " ") {
	    $limit = $default;
	}
	
	return $limit;
    }
}
?>