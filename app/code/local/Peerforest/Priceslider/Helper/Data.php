<?php 
class Peerforest_Priceslider_Helper_Data extends Mage_Core_Helper_Data
{
    private $_categoryMinPrice;
    private $_categoryMaxPrice;
    private $_requestMinPrice;
    private $_requestMaxPrice;
    
    public function initSlider()
    {
        //$currentCategoryCollection = Mage::getSingleton('catalog/layer')->setCurrentCategory(Mage::registry('current_category'))->getProductCollection();
        $currentCategoryCollection = Mage::getSingleton('catalog/layer')->getProductCollection();
        $this->_categoryMinPrice = $currentCategoryCollection->getMinPrice();        
        $this->_categoryMaxPrice = $currentCategoryCollection->getMaxPrice();       
        
        if(isset($_GET['price']))
        { 
            $tmpPrice = explode("-",$_GET['price']);
            $this->_requestMinPrice = $tmpPrice[0];
            $this->_requestMaxPrice = $tmpPrice[1]-1;
        }
        else
        {
            $this->_requestMinPrice = $this->_categoryMinPrice;
            $this->_requestMaxPrice = $this->_categoryMaxPrice;
        }
    }
    
    public function getCategoryMinPrice(){
        return $this->_categoryMinPrice;
    }
    
    public function getCategoryMaxPrice(){
        return $this->_categoryMaxPrice;
    }
    
    public function getRequestedMinPrice(){
        return $this->_requestMinPrice;
    }
    
    public function getRequestedMaxPrice(){
        return $this->_requestMaxPrice;
    }
    
    public function getActionType(){
        if(Mage::getStoreConfig('priceslider/options/action',Mage::app()->getStore()) == 'button'){
            return 'click';
        }
        else{
            return 'valuesChanged';
        }
    }
    
    public function getActionElement(){
        if(Mage::getStoreConfig('priceslider/options/action',Mage::app()->getStore()) == 'button'){
            return '#priceslider-button';
        }
        else{
            return '.ui-rangeSlider';
        }
    }
}
?>