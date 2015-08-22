<?php 
class Peerforest_Megamenu_Block_Topmenu extends Peerforest_Megamenu_Block_Html_Topmenu
{
    protected $_isHomeActive = true;
    protected $_verticalMenu = false;
    public function getHtml($outermostClass = '', $childrenWrapClass = '', $mobile = false)
    {
        $this->_isHomeActive = true;
        if(!Mage::getStoreConfig('peermegamenu/options/enabled',Mage::app()->getStore()))
            return parent::getHtml($outermostClass = '', $childrenWrapClass = '');        
        
        return $this->getMegaMenuHtml($mobile);        
    }
    
    public function getSideHtml()
    {
        $this->_isHomeActive = true;
            
        
        return $this->getSideMegaMenuHtml();        
    }
    
    public function getMegaMenuHtml($mobile)
    {
        Mage::dispatchEvent('page_block_html_topmenu_gethtml_before', array(
            'menu' => $this->_menu,
            'block' => $this
        ));
        
        $customLinks = '';
        if(Mage::getStoreConfig('peermegamenu/options/enable_custom_Link',Mage::app()->getStore())){
            $customLinks = $this->_getMegaCustomMenu($mobile);
        }
        $levelItem = 0;
        if($this->_getHomeLinkHtml($mobile)){         
            $levelItem++;
        }
        if(!$mobile){
            $htmlCategory = $this->_getMegaMenuHtml($this->_menu, $levelItem);
        }
        else {
            $htmlCategory = $this->_getMobileMenuHtml($this->_menu, $levelItem);
        }
        
        $htmlHome = '';        
        if($this->_getHomeLinkHtml($mobile)){
            $htmlHome = $this->_getHomeLinkHtml($mobile);            
        }               
        
        $html = $htmlHome . $htmlCategory. $customLinks;
        
        Mage::dispatchEvent('page_block_html_topmenu_gethtml_after', array(
            'menu' => $this->_menu,
            'html' => $html
        ));
        return $html;
    }
    
    public function getSideMegaMenuHtml()
    {
        Mage::dispatchEvent('page_block_html_topmenu_gethtml_before', array(
            'menu' => $this->_menu,
            'block' => $this
        ));
        
        $htmlCategory = $this->_getSideMegaMenuHtml($this->_menu, $levelItem);
        
        $html = $htmlCategory;
        
        Mage::dispatchEvent('page_block_html_topmenu_gethtml_after', array(
            'menu' => $this->_menu,
            'html' => $html
        ));
        return $html;
    }
    
    
    protected function _getSideMegaMenuHtml(Varien_Data_Tree_Node $menuTree, $levelItem,$columnCount = 0)
    {
        $html = '';

        $children = $menuTree->getChildren();
        $parentLevel = $menuTree->getLevel();
        $childLevel = is_null($parentLevel) ? 0 : $parentLevel + 1;        
        $childrenCount = $children->count();
        
        $columnClass = '';
        if($childLevel == 1){            
            $columnClass = " item";
        }
        
        foreach ($children as $child) {
            $child->setLevel($childLevel);
            $activeClass = "";
            if($child->getIsActive()) {
                $activeClass = " active";
            }
            
            $category = Mage::getModel('catalog/category')->load(str_replace("category-node-","",$child->getId()));                                              
            
            $parentClass = '';
            if($childLevel == 0 && $child->hasChildren()){
                $parentClass = ' parent';
            }
            
            $html .= '<li class="level-'.$childLevel.' item-'.$levelItem.$activeClass.' '.$columnClass.$parentClass.'">';
        
            $categoryLabel = '';
            if($category->getData('category_label')){
                $categoryLabel = '<span class="category-label">' . $category->getCategoryLabel() . '</span>';
            }
             
            $html .= '<a href="' . $child->getUrl() . '">';
            
            $html .= $this->escapeHtml($child->getName());
           
                $html .= $categoryLabel;
           
            $html .= '</a>';
           
            
            
           
            if ($child->hasChildren()) {                            
                if($childLevel == 0){                    
                    $html .= '<div id="sidepopup'.$childLevel.$levelItem.'" class="sidemenu-block">';    
                }
                
                $html .= '<ul class="level' . ($childLevel+1) . (($childLevel == 0)? ' subs no-both-margin columngrid columngrid-4col' : "").'">';
                $html .= $this->_getSideMegaMenuHtml($child, 0);
                $html .= '</ul>';
                if($childLevel == 0){
                    $html .= '</div>';
                }
              
            }
            
            
            $html .= '</li>';            
            $levelItem++;            
        }

        return $html;
    }
    
    protected function _getMegaMenuHtml(Varien_Data_Tree_Node $menuTree, $levelItem,$columnCount = 0)
    {
        $html = '';

        $children = $menuTree->getChildren();
        $parentLevel = $menuTree->getLevel();
        $childLevel = is_null($parentLevel) ? 0 : $parentLevel + 1;        
        $childrenCount = $children->count();
        
        $columnClass = '';
        if($columnCount != 0 && $childLevel == 1){            
            $columnClass = " item";
        }
        
        foreach ($children as $child) {
            $child->setLevel($childLevel);
            $activeClass = "";
            if($child->getIsActive()) {
                $activeClass = " active";
                $this->_isHomeActive = false;
            }
            
            $category = Mage::getModel('catalog/category')->load(str_replace("category-node-","",$child->getId()));                                              
            $menuType = "";            
            if($childLevel == 0 && $category->getMenutype()){
                $menuType = $category->getMenutype();
                if($menuType == 'megamenu-vertical'){
                    $this->_verticalMenu = true;
                }
                else{
                    $this->_verticalMenu = false;
                }                
            }
            
            $parentClass = '';
            if($childLevel == 0 && $child->hasChildren()){
                $parentClass = ' parent';
            }
            
            $html .= '<li class="level-'.$childLevel.' item-'.$levelItem.$activeClass.' '.$menuType.$columnClass.$parentClass.'" onmouseover="showMegamenu(this,\'popup'.$childLevel.$levelItem.'\')">';
            $categoryThumnailImage = '';
            $categoryLabel = '';
            if($category->getData('category_label')){
                $categoryLabel = '<span class="category-label">' . $category->getCategoryLabel() . '</span>';
            }
            if($childLevel == 1 && $this->_verticalMenu == false && $this->_getThumbnailImage($category) && Mage::getStoreConfig('peermegamenu/options/display_category_thumnail_image',Mage::app()->getStore())){
                $categoryThumnailImage =  $this->_getThumbnailImage($category);               
                                
                $html .=  $categoryThumnailImage;
                $html .= '<a href="' . $child->getUrl() . '">'.$this->escapeHtml($child->getName()) .$categoryLabel.'</a>';                
            }            
            elseif($childLevel > 1 && $this->_verticalMenu == false && $this->_getThumbnailImage($category) && Mage::getStoreConfig('peermegamenu/options/display_subcategory_thumnail_image',Mage::app()->getStore())){                
                $thumnailPosition = Mage::getStoreConfig('peermegamenu/options/subcategory_thumnail_image_position',Mage::app()->getStore());
                $categoryThumnailImage =  $this->_getThumbnailImage($category,$thumnailPosition);                           
                if($thumnailPosition == 'left') {$html .=  $categoryThumnailImage;}
                $html .= '<a href="' . $child->getUrl() . '" >'.$this->escapeHtml($child->getName()) .$categoryLabel.'</a>';
                if($thumnailPosition == 'right') {$html .=  $categoryThumnailImage;}               
            }
            else
            {           
                $html .= '<a href="' . $child->getUrl() . '">';
                if($childLevel == 0) {
                    $html .= $categoryLabel;
                }
                $html .= $this->escapeHtml($child->getName());
                if($childLevel > 0) {
                    $html .= $categoryLabel;
                }
                $html .= '</a>';
            }
            
            
            $leftBlockWidth = false;            
            $rightBlockWidth = false;
            $centerBlockWidth = false;
            $addBlock = false;
            if($childLevel == 0 &&  $this->_verticalMenu == false ){
                $customCategoryBlock = array();
                $customCategoryBlock['top'] = ($category->getTopblock())? $category->getTopblock() : false ;
                $customCategoryBlock['left'] = ($category->getLeftblock())? $category->getLeftblock() : false ;
                $customCategoryBlock['right'] = ($category->getRightblock())? $category->getRightblock() : false ;
                $customCategoryBlock['bottom'] = ($category->getBottomblock())? $category->getBottomblock() : false ;
                
                foreach($customCategoryBlock as $key => $value) {
                    $customCategoryBlock[$key] = $this->_loadCustomCategoryBlock($value);
                    if($customCategoryBlock[$key]){
                        $addBlock = true;
                    }
                }
                if($customCategoryBlock['left']){
                    $leftBlockWidth = $category->getData('leftblockWidth');    
                }                
                if($customCategoryBlock['right']){
                    $rightBlockWidth = $category->getData('rightblockWidth');
                }                
                
                if($addBlock){
                    $html .= '<div id="popup'.$childLevel.$levelItem.'" class="mega-block">';
                    $html .= $this->_getBlockHtml($customCategoryBlock,'top');
                    $html .= '<div class="no-both-margin grid_12">';
                    $html .= $this->_getBlockHtml($customCategoryBlock,'left',$leftBlockWidth);
                }                
                                
            }
            if ($child->hasChildren()) {                
                $centerBlockWidth = '';
                if($category->getData('centerBlockWidth') && $childLevel == 0 &&  $this->_verticalMenu == false){
                    $centerBlockWidth = ' grid_'.$category->getData('centerBlockWidth');
                    if(!$addBlock){
                        $centerBlockWidth = ' grid_12';
                    }
                }                
                if(!$addBlock && $childLevel == 0){                    
                    $html .= '<div id="popup'.$childLevel.$levelItem.'" class="mega-block">';    
                }
                $columnCount = 0;
                if($category->getData('totalColumnCategory')){
                    $columnCount = $category->getData('totalColumnCategory');    
                }
                $html .= '<ul class="level' . ($childLevel+1) . (($childLevel == 0 && $this->_verticalMenu == false)? ' subs no-both-margin columngrid columngrid-'.$columnCount.'col' : "").(($childLevel == 0 && $this->_verticalMenu == true)?' subs': '').$centerBlockWidth.'">';
                $html .= $this->_getMegaMenuHtml($child, 0, $columnCount);
                $html .= '</ul>';
                if(!$addBlock && $childLevel == 0){
                    $html .= '</div>';
                }
            }
            
            if($childLevel == 0 && $addBlock &&  $this->_verticalMenu == false){
                $html .= $this->_getBlockHtml($customCategoryBlock,'right',$rightBlockWidth);
                $html .= '</div>';
                $html .= $this->_getBlockHtml($customCategoryBlock,'bottom');
                $html .= '</div>';
                
            }
            $html .= '</li>';            
            $levelItem++;            
        }

        return $html;
    }
    
    
    protected function _getMobileMenuHtml(Varien_Data_Tree_Node $menuTree, $levelItem)
    {
        $html = '';

        $children = $menuTree->getChildren();
        $parentLevel = $menuTree->getLevel();
        $childLevel = is_null($parentLevel) ? 0 : $parentLevel + 1;

        $counter = 1;
        $childrenCount = $children->count();

        
        foreach ($children as $child) {
            $child->setLevel($childLevel);
            $outermostClassCode = '';
            
            if(($child->getIsActive())){
                $this->_isHomeActive = false;    
            }           

            $html .= '<li>';            
            $html .= '<a href="' . $child->getUrl() . '" ><span>' . $this->escapeHtml($child->getName()).'</span></a>';                        
            if ($child->hasChildren()) {
                $html .= '<span class="open" onclick="mobileMenu(this,\''.$child->getId().'\');"></span>';
                $html .= '<ul id="'.$child->getId().'">';
                $html .= $this->_getMobileMenuHtml($child, 1);
                $html .= '</ul>';
            }            
            $html .= '</li>';

            $counter++;
            $levelItem++;
        }

        return $html;
    }
    
    protected function _getMegaCustomMenu($mobile)
    {
        $customMenuLink = Mage::getStoreConfig('peermegamenu/options/add_custom_menu',Mage::app()->getStore());
        $customMenuOrder = Mage::getStoreConfig('peermegamenu/options/custom_menu_order',Mage::app()->getStore());        
        $customMenuLink = explode(",",$customMenuLink);
        
        if($customMenuOrder != ""){
            $temp = array();
            $customMenuOrder = explode(",",$customMenuOrder);
            foreach($customMenuOrder as $key => $value){
                foreach($customMenuLink as $custom) {
                    $custom = explode(")",$custom);
                    if($custom[0] == $value){
                        $temp[] = $custom[1];
                    }
                }                
            }
            $customMenuLink = $temp;
        }
        else{
            foreach($customMenuLink as $key => $value) {
                $temp = explode(")",$value);
                $customMenuLink[$key] = $temp[1];
            }
        }
        
        $html = '';
        $customItem = 0;
        $i=1;
        foreach($customMenuLink as $linkId){
            $block = Mage::getModel('cms/block')->getCollection()
                 ->addFieldToFilter('identifier', $linkId)
                 ->load();
            
            foreach($block as $blockData){                
                $blockTitle = $blockData->getData('title');
                $blockUrl = Mage::getBaseUrl().str_replace("menu_","",$linkId);
                $blockUrl1 = str_replace("menu_","",$linkId);
                if(strpos(Mage::helper('core/url')->getCurrentUrl(), str_replace("menu_","",$linkId))){
                    $this->_isHomeActive = false;
                }
                
                if(!$mobile){
                    $tempHtml = '';                    
                    if(substr($linkId,0,11) == "menu_block_"){                                                
                        $content = $this->_loadCustomCategoryBlock($linkId);
                        if($content != ''){
                            $tempHtml .= '<li class="level-0 customitem-'.$customItem.' '.(($blockUrl1 == Mage::getSingleton('cms/page')->getIdentifier())? ' active': '').' parent"  onmouseover="showMegamenu(this,\'popup-c'.$i.'\')">';
                            $tempHtml .= '<a href="#">'.$this->escapeHtml($blockTitle) . '</a>';
                            $tempHtml .= '<div id="popup-c'.$i.'"class="mega-block">';
                            $tempHtml .= $content;
                            $tempHtml .= '</div>';
                            
                        }
                        else{
                            $tempHtml .= '<li class="level-0 customitem-'.$customItem.' '.(($blockUrl1 == Mage::getSingleton('cms/page')->getIdentifier())? ' active': '').'"  onmouseover="showMegamenu(this,\'popup-c'.$i.'\')">';
                            $tempHtml .= '<a href="#">'.$this->escapeHtml($blockTitle) . '</a>';
                        }
                    }
                    else{
                        $tempHtml .= '<li class="level-0 customitem-'.$customItem.' '.(($blockUrl1 == Mage::getSingleton('cms/page')->getIdentifier())? ' active': '').'"  onmouseover="showMegamenu(this,\'popup-c'.$i.'\')">';
                        $tempHtml .= '<a href="' . $blockUrl . '/">'.$this->escapeHtml($blockTitle) . '</a>';    
                    }
                    $tempHtml .= '</li>';
                    $html .= $tempHtml;
                    $i++;
                }
                else
                {
                    if(substr($linkId,0,11) == "menu_block_"){
                    } else {
                        $html .= "<li>";
                        $html .= '<a href="' . $blockUrl . '/"><span>'.$this->escapeHtml($blockTitle) . '</span></a>';
                        $html .= "</li>";
                    }
                }
                $customItem++;
            }
        }
        
        return $html;
    }
    
    protected function _getHomeLinkHtml($mobile)
    {
        $homeLinkHtml = false;
        if(Mage::getStoreConfig('peermegamenu/options/enabled_home_link',Mage::app()->getStore())){
            if(!$mobile){
                $homeLinkHtml = "<li class='level-0 item-0 ".(($this->_isHomeActive == true)? "active" : "")."'>";
                $homeLinkHtml .= "<a href='".Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_WEB)."'>".$this->__('Home')."</a>";
                $homeLinkHtml .= "</li>";
            }
            else
            {                
                $homeLinkHtml = "<li>";
                $homeLinkHtml .= "<a href='".Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_WEB)."'><span>".$this->__('Home')."</span></a>";                
                $homeLinkHtml .= '</li>';
            }
        }
        return $homeLinkHtml;
        
    }
    
    protected function _loadCustomCategoryBlock($block_id)
    {
        $content = false;
        if($block_id && $block_id != ""){            
            $content = $this->getLayout()->createBlock('cms/block')->setBlockId($block_id)->toHtml();
        }
        return $content;
    }
    
    protected function _getBlockHtml($content, $key, $width = false)
    {
        $html = "";
        $setWidth = 12;
        
        if($width != false)
        {
            $setWidth = $width;
        }
        $addMargin = '';
        //if($key == 'left' || $key == 'right'){
        //    $addMargin = ' no-'.$key.'-margin';
        //}
        if($content[$key]){
            $html .= '<div class="custom-block-'.$key. $addMargin.' grid_'.$setWidth.'">';
            $html .= $content[$key];
            $html .= '</div>';
        }
        return $html;
    }
    
    protected function _getSize($width)
    {
        $_width = 0;
        if($width != false)
        {            
            if(strpos($width,"%") !== false) {
                $_width = str_replace("%","",$width);
            }            
            elseif($width != "")
            {
                $_width = $width;
            }            
        }
        return floatval($_width);
    }
    
    
    protected function _getThumbnailImage($category,$position = false)
    {        
        $thumnailImage = false;
        $addClass = '';
        if($position !=false){
            $addClass = ' class="subLevel_thumnail_'.$position.'"';
        }
        if ($image = $category->getThumbnail()) {
            $catName = $category->getName();
            $url = '';
            $url = Mage::getBaseUrl('media').'catalog/category/'.$image;
            $thumnailImage =  '<img src="'.$url.'" alt="'.$catName.'"'.$addClass.'/>';
        }
        return $thumnailImage;
    }
}

?>