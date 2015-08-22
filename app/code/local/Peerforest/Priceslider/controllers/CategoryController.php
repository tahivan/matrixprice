<?php
require_once Mage::getModuleDir('controllers', 'Mage_Catalog').DS.'CategoryController.php';
class Peerforest_Priceslider_CategoryController extends Mage_Catalog_CategoryController
{
    public function viewAction()
    {
        $ajax = 0;
        if($this->getRequest()->getParam('ajax', false)){
            $ajax = (int) $this->getRequest()->getParam('ajax', false);            
        }
        
        if ($category = $this->_initCatagory()) {
            $design = Mage::getSingleton('catalog/design');
            $settings = $design->getDesignSettings($category);

            // apply custom design
            if ($settings->getCustomDesign()) {
                $design->applyCustomDesign($settings->getCustomDesign());
            }

            Mage::getSingleton('catalog/session')->setLastViewedCategoryId($category->getId());

            $update = $this->getLayout()->getUpdate();
            $update->addHandle('default');

            if (!$category->hasChildren()) {
                $update->addHandle('catalog_category_layered_nochildren');
            }

            $this->addActionLayoutHandles();
            $update->addHandle($category->getLayoutUpdateHandle());
            $update->addHandle('CATEGORY_' . $category->getId());
            $this->loadLayoutUpdates();

            // apply custom layout update once layout is loaded
            if($ajax != 1){
                if ($layoutUpdates = $settings->getLayoutUpdates()) {
                    if (is_array($layoutUpdates)) {
                        foreach($layoutUpdates as $layoutUpdate) {
                            $update->addUpdate($layoutUpdate);
                        }
                    }
                }
            }
                $this->generateLayoutXml()->generateLayoutBlocks();
            if($ajax != 1){
                // apply custom layout (page) template once the blocks are generated
                if ($settings->getPageLayout()) {
                    $this->getLayout()->helper('page/layout')->applyTemplate($settings->getPageLayout());
                }
    
                if ($root = $this->getLayout()->getBlock('root')) {
                    $root->addBodyClass('categorypath-' . $category->getUrlPath())
                        ->addBodyClass('category-' . $category->getUrlKey());
                }
            }
            $this->_initLayoutMessages('catalog/session');
            $this->_initLayoutMessages('checkout/session');
            if($ajax == 1){
                $response = array();
                $response['status'] = 'success';
                $response['blockLayeredNav'] = $this->getLayout()->getBlock('catalog.leftnav')->toHtml();
                $response['products'] = $this->getLayout()->getBlock('product_list')->toHtml();
                $this->getResponse()->setBody(Mage::helper('core')->jsonEncode($response));
            }
            else{
                $this->renderLayout();    
            }
            
        }
        elseif (!$this->getResponse()->isRedirect()) {
            $this->_forward('noRoute');
        }
    }
}
