<?php 
class Peerforest_ExtraConfig_Helper_Data extends Mage_Core_Helper_Abstract
{
    
    function is_mobile()
    {
	$ua = strtolower($_SERVER['HTTP_USER_AGENT']);
	$mobiles = array("android", "iphone", "ipod", "ipad",
		"blackberry", "palm", "mobile", "mini", "kindle");
	foreach($mobiles as $mobile)
	{
		if(strpos($ua,$mobile)) return true;
	}
	return false;
    }
    
    public function responsivewidth()
	{
		return array(
			"1920" => 1760,
			"1680" => 1520,
			"1440" => 1380,
			"1360" => 1300,
			"1280" => 1200,
			"960" => 960,
		);
	}
	
    public function maxwidth($store)
	{
		$maxwidth = Mage::getStoreConfig('themelayout/layout/layout_width',$store);
		if ($maxwidth == 'custom')
		{
			return intval(Mage::getStoreConfig('themelayout/layout/custom_width', $store));
		}
		else
		{
			return intval($maxwidth);
		}
	}
	
    public function breakpoint($width, $store)
	{
		if ($width < 1280)
			$maxBreak = 960;
		elseif ($width < 1360)
			$maxBreak = 1280;
		elseif ($width < 1440)
			$maxBreak = 1360;
		elseif ($width < 1680)
			$maxBreak = 1440;
		elseif ($width < 1920)
			$maxBreak = 1680;
		else
			$maxBreak = 1920;
		
		return $maxBreak;
	}
	
    function jsString($str='')
    { 
        return trim(preg_replace("/('|\"|\r?\n)/", '', $str)); 
    }
    
    function html2rgb($rgb)
	 {
		  if ($rgb[0] == '#')
				$rgb = substr($rgb, 1);
	 
		  if (strlen($rgb) == 6)
				list($r, $g, $b) = array($rgb[0].$rgb[1],
												 $rgb[2].$rgb[3],
												 $rgb[4].$rgb[5]);
		  elseif (strlen($rgb) == 3)
				list($r, $g, $b) = array($rgb[0].$rgb[0], $rgb[1].$rgb[1], $rgb[2].$rgb[2]);
		  else
				return false;
	 
		  $r = hexdec($r); $g = hexdec($g); $b = hexdec($b);
	  
		  return array($r, $g, $b);
	 }
	 
    public function getGridCss()
	{
		return 'css/override/peer_grid_' . Mage::app()->getStore()->getCode() . '.css';
	}
	
    public function getLayoutCss()
	{
		return 'css/override/peer_layout_' . Mage::app()->getStore()->getCode() . '.css';
	}
	 
    public function getAltImgHtml($product, $w, $h, $imgClass='small_image')
    {		  
       $enable = Mage::getStoreConfig('mygeneral/product_list/enable_alter');
	    $column = Mage::getStoreConfig('mygeneral/product_list/alter_image');
	    $value = Mage::getStoreConfig('mygeneral/product_list/alter_image_value');
	    $image_aspect_ratio = Mage::getStoreConfig('mygeneral/product_list/image_aspect_ratio');
	    $product->load('media_gallery');
	    
	    if($enable == 1)
	    {
			   foreach ($product->getMediaGalleryImages() as $image)
			   {		 
				     if($image->getLabel() == $value && $column == 'label')
				     {
					    if($image_aspect_ratio == '1'){
						$var= Mage::helper('catalog/image')->init($product, 'image', $image->getFile())->constrainOnly(true)->keepAspectRatio(true)->keepFrame(false)->resize($w);
					    } else {
						 $var= Mage::helper('catalog/image')->init($product, 'image', $image->getFile())->resize($w,$h);
					    }
					    return '<img class="'.$imgClass.'" src="' .$var. '" alt="' . $product->getName() . '" />';
				     }					  
				     elseif($image->getPosition() == $value && $column == 'sortorder')
				     {
					    if($image_aspect_ratio == '1'){
						$var= Mage::helper('catalog/image')->init($product, 'image', $image->getFile())->constrainOnly(true)->keepAspectRatio(true)->keepFrame(false)->resize($w);
					    } else {
						 $var= Mage::helper('catalog/image')->init($product, 'image', $image->getFile())->resize($w,$h);
					    }
					   return '<img class="'.$imgClass.'" src="' .$var. '" alt="' . $product->getName() . '" />';
				     }
			    }
	     }
	     return false;
    }	 

    public function getImage($product, $w, $h, $imgType='image', $file=NULL)
    {
	    $url = '';
	    if ($h <= 0)
	    {
		    $url = Mage::helper('catalog/image')
			    ->init($product, $imgType, $file)
			    ->constrainOnly(true)
			    ->keepAspectRatio(true)
			    ->keepFrame(false)
			    ->resize($w);
	    }
	    else
	    {
		    $url = Mage::helper('catalog/image')
			    ->init($product, $imgType, $file)
			    ->resize($w, $h);
	    }
	    return $url;
    }
    
    public function categoryThemeSidebarMenu($category, $insObj, $level = 0)
    { 
	$isactive 	 = $insObj->isCategoryActive($category);
	$hasmoreChildren = $category->hasChildren();
	$active = "";
	if ($isactive) {
	    $active = "active";
	}
	
	$html  = "<li class='level".$level." ".$active."'>";
	$html .= "<a href='".$insObj->getCategoryUrl($category)."'>";
	$html .= "<span class='errow'></span>";
	$html .= "<span>".$category->getName()."</span>";
	$categoryLabel = Mage::getModel('catalog/category')->load(str_replace("category-node-","",$category->getId()));
	if($categoryLabel->getData('category_label')){
	    $html .= "<span class='category-label'>".$categoryLabel->getData('category_label')."</span>";
	}
	$html .= "</a>";
	
	if ($hasmoreChildren) {
	   if ($isactive) {
		$html .= "<a class='full right show-cat active' href='javascript://'><span class='plus fa fa-plus'></span><span class='minus fa fa-minus'></span></a>";
	    } else {
		$html .= "<a class='full right show-cat' href='javascript://'><span class='plus fa fa fa-plus'></span><span class='minus fa fa-minus'></span></a>";
	    }
	    
	    $html .= "<ul class='level".$level."'>";
	    
	    if (Mage::helper('catalog/category_flat')->isEnabled()) {
		$subCategory = $category->getChildrenCategories();
	    }
	    else {
		$subCategory = $category->getChildren();
	    }
	    $level++;
	    foreach ($subCategory as $subSubCategory) {
		$html .= $this->categoryThemeSidebarMenu($subSubCategory,$insObj,$level);
	    }	    
	    $html .= "</ul>";
	}
	$html .= "</li>";
	return $html;
    }
    
    public function sliderSetting()
    {
	$configData = Mage::getStoreConfig('mygeneral/product_slider');	
	return $this->sliderCustomSetting($configData);
    }
    
    public function bannerSliderSetting()
    {
	$configData = Mage::getStoreConfig('bannerslider/settings');	
	return $this->bannersliderCustomSetting($configData);
    }
    
    public function revolutionbannerSliderSetting()
    {
	$configData = Mage::getStoreConfig('revolutionslider/setting');	
	return $this->revolutionsliderCustomSetting($configData);
    }
    
    private function sliderCustomSetting($configData)
    {
	$html = "";
	
	if(isset($configData['slide_speed']) && $configData['slide_speed'] != "") {
	    $html .= ",slideSpeed: ". $configData['slide_speed'];
	}
	
	if(isset($configData['rewind_speed']) && $configData['rewind_speed'] != "") {	    
	    $html .= ",rewindSpeed: ". $configData['rewind_speed'];
	}
	
	if(isset($configData['auto_play']) && $configData['auto_play'] == "") {	    
	    $html .= ",autoPlay: false";
	}
	else if(isset($configData['auto_play']) && $configData['auto_play'] != "") {	    
	    $html .= ",autoPlay: ". $configData['auto_play'];
	}
	
	if(isset($configData['stop_on_hover']) && $configData['stop_on_hover'] == 0) {	    
	    $html .= ",stopOnHover: false";
	}
	else if(isset($configData['stop_on_hover']) && $configData['stop_on_hover'] == 1) {	    
	    $html .= ",stopOnHover: true";
	}
	
	if(isset($configData['rewind_nav']) && $configData['rewind_nav'] == 0) {	    
	    $html .= ",rewindNav: false";
	}
	else if(isset($configData['rewind_nav']) && $configData['rewind_nav'] == 1) {	    
	    $html .= ",rewindNav: true";
	}
	
	if(isset($configData['scroll_per_page']) && $configData['scroll_per_page'] == 0) {	    
	    $html .= ",scrollPerPage: false";
	}
	else if(isset($configData['scroll_per_page']) && $configData['scroll_per_page'] == 1) {	    
	    $html .= ",scrollPerPage: true";
	}
	
	if(isset($configData['lazyload']) && $configData['lazyload'] == 0) {	    
	    $html .= ",lazyLoad: false";
	}
	else if(isset($configData['lazyload']) && $configData['lazyload'] == 1) {	    
	    $html .= ",lazyLoad: true";
	}
	
	$html .= ",navigation: true";
	$html .= ",pagination: false";
	$html .= ",navigationText: ['', '']";
	return $html;
    }
    
    
    private function bannersliderCustomSetting($configData)
    {
	$html = "";
	
	if(isset($configData['slide_speed']) && $configData['slide_speed'] != "") {
	    $html .= ",slideSpeed: ". $configData['slide_speed'];
	}
	
	if(isset($configData['rewind_speed']) && $configData['rewind_speed'] != "") {	    
	    $html .= ",rewindSpeed: ". $configData['rewind_speed'];
	}
	
	if(isset($configData['auto_play']) && $configData['auto_play'] == "") {	    
	    $html .= ",autoPlay: false";
	}
	else if(isset($configData['auto_play']) && $configData['auto_play'] != "") {	    
	    $html .= ",autoPlay: ". $configData['auto_play'];
	}
	
	if(isset($configData['stop_on_hover']) && $configData['stop_on_hover'] == 0) {	    
	    $html .= ",stopOnHover: false";
	}
	else if(isset($configData['stop_on_hover']) && $configData['stop_on_hover'] == 1) {	    
	    $html .= ",stopOnHover: true";
	}
	
	if(isset($configData['rewind_nav']) && $configData['rewind_nav'] == 0) {	    
	    $html .= ",rewindNav: false";
	}
	else if(isset($configData['rewind_nav']) && $configData['rewind_nav'] == 1) {	    
	    $html .= ",rewindNav: true";
	}
	
	if(isset($configData['lazyload']) && $configData['lazyload'] == 0) {	    
	    $html .= ",lazyLoad: false";
	}
	else if(isset($configData['lazyload']) && $configData['lazyload'] == 1) {	    
	    $html .= ",lazyLoad: true";
	}
	
	if(isset($configData['navigation']) && $configData['navigation'] == 0) {	    
	    $html .= ",navigation: false";
	}
	else if(isset($configData['navigation']) && $configData['navigation'] == 1) {	    
	    $html .= ",navigation: true";
	}
	
	if(isset($configData['transition_style']) && $configData['transition_style'] == "default") {
	    $html .= ',transitionStyle: false';
	}
	else if(isset($configData['transition_style']) && $configData['transition_style'] != "default") {
	    $html .= ',transitionStyle: "'. $configData['transition_style'].'"';
	}
	
	if(isset($configData['pagination']) && $configData['pagination'] == 0) {	    
	    $html .= ",pagination: false";
	}
	else if(isset($configData['pagination']) && $configData['pagination'] == 1) {	    
	    $html .= ",pagination: true";
	}
	
	if(isset($configData['pagination_speed']) && $configData['pagination_speed'] != "") {
	    $html .= ",paginationSpeed: ". $configData['pagination_speed'];
	}
	
	if(isset($configData['pagination_numbers']) && $configData['pagination_numbers'] == 0) {	    
	    $html .= ",paginationNumbers: false";
	}
	else if(isset($configData['pagination_numbers']) && $configData['pagination_numbers'] == 1) {	    
	    $html .= ",paginationNumbers: true";
	}
	
	$html .= ",navigationText: ['', '']";
	
	return $html;
    }
    
    
    private function revolutionsliderCustomSetting($configData)
    {
	$html = "";
	
	if(isset($configData['delay']) && $configData['delay'] != "") {
	    $html .= ",delay: ". $configData['delay'];
	}
	
	if(isset($configData['startheight']) && $configData['startheight'] != "") {	    
	    $html .= ",startheight: ". $configData['startheight'];
	}
	
	if(isset($configData['startwidth']) && $configData['startwidth'] != "") {	    
	    $html .= ",startwidth: ". $configData['startwidth'];
	}
	
	//if(isset($configData['fullScreenAlignForce']) && $configData['fullScreenAlignForce'] == 'off') {	    
	//    $html .= ",fullScreenAlignForce: 'off'";
	//}
	//else if(isset($configData['fullScreenAlignForce']) && $configData['fullScreenAlignForce'] == 'on') {	    
	//    $html .= ",fullScreenAlignForce: 'on'";
	//}
	
	//if(isset($configData['autoHeight']) && $configData['autoHeight'] == 'off') {	    
	//    $html .= ",autoHeight: 'off'";
	//}
	//else if(isset($configData['autoHeight']) && $configData['autoHeight'] == 'on') {	    
	//    $html .= ",autoHeight: 'on'";
	//}
	
	if(isset($configData['hideTimerBar']) && $configData['hideTimerBar'] == 'off') {	    
	    $html .= ",hideTimerBar: 'off'";
	}
	else if(isset($configData['hideTimerBar']) && $configData['hideTimerBar'] == 'on') {	    
	    $html .= ",hideTimerBar: 'on'";
	}
	
	if(isset($configData['hideThumbs']) && $configData['hideThumbs'] != "") {	    
	    $html .= ",hideThumbs: ". $configData['hideThumbs'];
	}
	
	if(isset($configData['hideNavDelayOnMobile']) && $configData['hideNavDelayOnMobile'] != "") {	    
	    $html .= ",hideNavDelayOnMobile: ". $configData['hideNavDelayOnMobile'];
	}
	
	if(isset($configData['thumbWidth']) && $configData['thumbWidth'] != "") {	    
	    $html .= ",thumbWidth: ". $configData['thumbWidth'];
	}
	
	if(isset($configData['thumbHeight']) && $configData['thumbHeight'] != "") {	    
	    $html .= ",thumbHeight: ". $configData['thumbHeight'];
	}
	
	if(isset($configData['thumbAmount']) && $configData['thumbAmount'] != "") {	    
	    $html .= ",thumbAmount: ". $configData['thumbAmount'];
	}
	
	if(isset($configData['navigationType']) && $configData['navigationType'] != "") {	    
	    $html .= ",navigationType: '{$configData['navigationType']}'";
	}
	
	if(isset($configData['navigationArrows']) && $configData['navigationArrows'] != "") {	    
	    $html .= ",navigationArrows: '{$configData['navigationArrows']}'";
	}
	
	if(isset($configData['hideThumbsOnMobile']) && $configData['hideThumbsOnMobile'] == 'off') {	    
	    $html .= ",hideThumbsOnMobile: 'off'";
	}
	else if(isset($configData['hideThumbsOnMobile']) && $configData['hideThumbsOnMobile'] == 'on') {	    
	    $html .= ",hideThumbsOnMobile: 'on'";
	}
	
	if(isset($configData['hideBulletsOnMobile']) && $configData['hideBulletsOnMobile'] == 'off') {	    
	    $html .= ",hideBulletsOnMobile: 'off'";
	}
	else if(isset($configData['hideBulletsOnMobile']) && $configData['hideBulletsOnMobile'] == 'on') {	    
	    $html .= ",hideBulletsOnMobile: 'on'";
	}
	
	if(isset($configData['hideArrowsOnMobile']) && $configData['hideArrowsOnMobile'] == 'off') {	    
	    $html .= ",hideArrowsOnMobile: 'off'";
	}
	else if(isset($configData['hideArrowsOnMobile']) && $configData['hideArrowsOnMobile'] == 'on') {	    
	    $html .= ",hideArrowsOnMobile: 'on'";
	}
	
	if(isset($configData['hideThumbsUnderResoluition']) && $configData['hideThumbsUnderResoluition'] != "") {	    
	    $html .= ",hideThumbsUnderResoluition: ". $configData['hideThumbsUnderResoluition'];
	}
	
	//if(isset($configData['navigationStyle']) && $configData['navigationStyle'] != "") {	    
	//    $html .= ",navigationStyle: '{$configData['navigationStyle']}'";
	//}
	
	if(isset($configData['navigationHAlign']) && $configData['navigationHAlign'] != "") {	    
	    $html .= ",navigationHAlign: '{$configData['navigationHAlign']}'";
	}
	
	if(isset($configData['navigationVAlign']) && $configData['navigationVAlign'] != "") {	    
	    $html .= ",navigationVAlign: '{$configData['navigationVAlign']}'";
	}
	
	if(isset($configData['navigationHOffset']) && $configData['navigationHOffset'] != "") {	    
	    $html .= ",navigationHOffset: ". $configData['navigationHOffset'];
	}
	
	if(isset($configData['navigationVOffset']) && $configData['navigationVOffset'] != "") {	    
	    $html .= ",navigationVOffset: ". $configData['navigationVOffset'];
	}
	
	if(isset($configData['soloArrowLeftHalign']) && $configData['soloArrowLeftHalign'] != "") {	    
	    $html .= ",soloArrowLeftHalign: '{$configData['soloArrowLeftHalign']}'";
	}
	
	if(isset($configData['soloArrowLeftValign']) && $configData['soloArrowLeftValign'] != "") {	    
	    $html .= ",soloArrowLeftValign: '{$configData['soloArrowLeftValign']}'";
	}
	
	if(isset($configData['soloArrowLeftHOffset']) && $configData['soloArrowLeftHOffset'] != "") {	    
	    $html .= ",soloArrowLeftHOffset: ". $configData['soloArrowLeftHOffset'];
	}
	
	if(isset($configData['soloArrowLeftVOffset']) && $configData['soloArrowLeftVOffset'] != "") {	    
	    $html .= ",soloArrowLeftVOffset: ". $configData['soloArrowLeftVOffset'];
	}
	
	if(isset($configData['soloArrowRightHalign']) && $configData['soloArrowRightHalign'] != "") {	    
	    $html .= ",soloArrowRightHalign: '{$configData['soloArrowRightHalign']}'";
	}
	
	if(isset($configData['soloArrowRightValign']) && $configData['soloArrowRightValign'] != "") {	    
	    $html .= ",soloArrowRightValign: '{$configData['soloArrowRightValign']}'";
	}
	
	if(isset($configData['soloArrowRightHOffset']) && $configData['soloArrowRightHOffset'] != "") {	    
	    $html .= ",soloArrowRightHOffset: ". $configData['soloArrowRightHOffset'];
	}
	
	if(isset($configData['soloArrowRightVOffset']) && $configData['soloArrowRightVOffset'] != "") {	    
	    $html .= ",soloArrowRightVOffset: ". $configData['soloArrowRightVOffset'];
	}
	
	if(isset($configData['keyboardNavigation']) && $configData['keyboardNavigation'] == 'off') {	    
	    $html .= ",keyboardNavigation: 'off'";
	}
	else if(isset($configData['keyboardNavigation']) && $configData['keyboardNavigation'] == 'on') {	    
	    $html .= ",keyboardNavigation: 'on'";
	}
	
	if(isset($configData['touchenabled']) && $configData['touchenabled'] == 'off') {	    
	    $html .= ",touchenabled: 'off'";
	}
	else if(isset($configData['touchenabled']) && $configData['touchenabled'] == 'on') {	    
	    $html .= ",touchenabled: 'on'";
	}
	
	if(isset($configData['onHoverStop']) && $configData['onHoverStop'] == 'off') {	    
	    $html .= ",onHoverStop: 'off'";
	}
	else if(isset($configData['onHoverStop']) && $configData['onHoverStop'] == 'on') {	    
	    $html .= ",onHoverStop: 'on'";
	}
	
	if(isset($configData['stopAtSlide']) && $configData['stopAtSlide'] != "") {	    
	    $html .= ",stopAtSlide: ". $configData['stopAtSlide'];
	}
	
	if(isset($configData['stopAfterLoops']) && $configData['stopAfterLoops'] != "") {	    
	    $html .= ",stopAfterLoops: ". $configData['stopAfterLoops'];
	}
	
	if(isset($configData['hideCaptionAtLimit']) && $configData['hideCaptionAtLimit'] != "") {	    
	    $html .= ",hideCaptionAtLimit: ". $configData['hideCaptionAtLimit'];
	}
	
	if(isset($configData['hideAllCaptionAtLimit']) && $configData['hideAllCaptionAtLimit'] != "") {	    
	    $html .= ",hideAllCaptionAtLimit: ". $configData['hideAllCaptionAtLimit'];
	}
	
	if(isset($configData['hideSliderAtLimit']) && $configData['hideSliderAtLimit'] != "") {	    
	    $html .= ",hideSliderAtLimit: ". $configData['hideSliderAtLimit'];
	}
	
	if(isset($configData['shadow']) && $configData['shadow'] != "") {	    
	    $html .= ",shadow: ". $configData['shadow'];
	}
	
	//if(isset($configData['fullWidth']) && $configData['fullWidth'] == 'off') {	    
	//    $html .= ",fullWidth: 'off'";
	//}
	//else if(isset($configData['fullWidth']) && $configData['fullWidth'] == 'on') {	    
	//    $html .= ",fullWidth: 'on'";
	//}
	//
	//if(isset($configData['fullScreen']) && $configData['fullScreen'] == 'off') {	    
	//    $html .= ",fullScreen: 'off'";
	//}
	//else if(isset($configData['fullScreen']) && $configData['fullScreen'] == 'on') {	    
	//    $html .= ",fullScreen: 'on'";
	//}
	//
	//if(isset($configData['minFullScreenHeight']) && $configData['minFullScreenHeight'] != "") {	    
	//    $html .= ",minFullScreenHeight: ". $configData['minFullScreenHeight'];
	//}
	//
	//if(isset($configData['fullScreenOffsetContainer']) && $configData['fullScreenOffsetContainer'] != "") {	    
	//    $html .= ",fullScreenOffsetContainer: ". $configData['fullScreenOffsetContainer'];
	//}
	
	if(isset($configData['dottedOverlay']) && $configData['dottedOverlay'] != "") {	    
	    $html .= ",dottedOverlay: '{$configData['dottedOverlay']}'";
	}
	
	//if(isset($configData['forceFullWidth']) && $configData['forceFullWidth'] == 'off') {	    
	//    $html .= ",forceFullWidth: 'off'";
	//}
	//else if(isset($configData['forceFullWidth']) && $configData['forceFullWidth'] == 'on') {	    
	//    $html .= ",forceFullWidth: 'on'";
	//}
	
	if(isset($configData['swipe_velocity']) && $configData['swipe_velocity'] != "") {	    
	    $html .= ",swipe_velocity: ". $configData['swipe_velocity'];
	}
	
	if(isset($configData['swipe_max_touches']) && $configData['swipe_max_touches'] != "") {	    
	    $html .= ",swipe_max_touches: ". $configData['swipe_max_touches'];
	}
	
	if(isset($configData['swipe_min_touches']) && $configData['swipe_min_touches'] != "") {	    
	    $html .= ",swipe_min_touches: ". $configData['swipe_min_touches'];
	}
	
	if(isset($configData['drag_block_vertical']) && $configData['drag_block_vertical'] == 'off') {	    
	    $html .= ",drag_block_vertical: false";
	}
	else if(isset($configData['drag_block_vertical']) && $configData['drag_block_vertical'] == 'on') {	    
	    $html .= ",drag_block_vertical: true";
	}
	
	return $html;
    }
    
    public function zoomSetting()
    {
	$configData = Mage::getStoreConfig('productzoom/zoom');	
	return $this->zoomCustomSetting($configData);
    }
    
    private function zoomCustomSetting($configData)
    {
	$html = "";
	
	$html .= "zoomActivation: 'hover'";
	$html .= ",responsive: false";
	
	if(isset($configData['zoomEnabled']) && $configData['zoomEnabled'] == 0) {	    
	    $html .= ",zoomEnabled: false";
	}
	else if(isset($configData['zoomEnabled']) && $configData['zoomEnabled'] == 1) {	    
	    $html .= ",zoomEnabled: true";
	}
	
	if(isset($configData['scrollZoom']) && $configData['scrollZoom'] == 0) {	    
	    $html .= ",scrollZoom: false";
	}
	else if(isset($configData['scrollZoom']) && $configData['scrollZoom'] == 1) {	    
	    $html .= ",scrollZoom: true";
	}
	
	if(isset($configData['easing']) && $configData['easing'] == 0) {	    
	    $html .= ",easing: false";
	}
	else if(isset($configData['easing']) && $configData['easing'] == 1) {	    
	    $html .= ",easing: true";
	}
	
	if(isset($configData['lensSize']) && $configData['lensSize'] != "") {
	    $html .= ",lensSize: ". $configData['lensSize'];
	}
	
	if(isset($configData['zoomWindowWidth']) && $configData['zoomWindowWidth'] != "") {
	    $html .= ",zoomWindowWidth: ". $configData['zoomWindowWidth'];
	}
	
	if(isset($configData['zoomWindowHeight']) && $configData['zoomWindowHeight'] != "") {
	    $html .= ",zoomWindowHeight: ". $configData['zoomWindowHeight'];
	}
	
	if(isset($configData['zoomWindowOffetx']) && $configData['zoomWindowOffetx'] != "") {
	    $html .= ",zoomWindowOffetx: ". $configData['zoomWindowOffetx'];
	}
	
	if(isset($configData['zoomWindowOffety']) && $configData['zoomWindowOffety'] != "") {
	    $html .= ",zoomWindowOffety: ". $configData['zoomWindowOffety'];
	}
	
	if(isset($configData['zoomWindowPosition']) && $configData['zoomWindowPosition'] != "") {
	    $html .= ",zoomWindowPosition: ". $configData['zoomWindowPosition'];
	}
	
	if(isset($configData['lensFadeIn']) && $configData['lensFadeIn'] != "") {	    
	    $html .= ",lensFadeIn: ". $configData['lensFadeIn'];
	}
	else {	    
	    $html .= ",lensFadeIn: false";
	}
	
	if(isset($configData['lensFadeOut']) && $configData['lensFadeOut'] != "") {	    
	    $html .= ",lensFadeOut: ". $configData['lensFadeOut'];
	}
	else {	    
	    $html .= ",lensFadeOut: false";
	}
	
	if(isset($configData['zoomWindowFadeIn']) && $configData['zoomWindowFadeIn'] != "") {	    
	    $html .= ",zoomWindowFadeIn: ". $configData['zoomWindowFadeIn'];
	}
	else {	    
	    $html .= ",zoomWindowFadeIn: false";
	}
	
	if(isset($configData['zoomWindowFadeOut']) && $configData['zoomWindowFadeOut'] != "") {	    
	    $html .= ",zoomWindowFadeOut: ". $configData['zoomWindowFadeOut'];
	}
	else {	    
	    $html .= ",zoomWindowFadeOut: false";
	}
	
	if(isset($configData['zoomTintFadeIn']) && $configData['zoomTintFadeIn'] != "") {	    
	    $html .= ",zoomTintFadeIn: ". $configData['zoomTintFadeIn'];
	}
	else {	    
	    $html .= ",zoomTintFadeIn: false";
	}
	
	if(isset($configData['zoomTintFadeOut']) && $configData['zoomTintFadeOut'] != "") {	    
	    $html .= ",zoomTintFadeOut: ". $configData['zoomTintFadeOut'];
	}
	else {	    
	    $html .= ",zoomTintFadeOut: false";
	}
	
	if(isset($configData['borderSize']) && $configData['borderSize'] != "") {
	    $html .= ",borderSize: ". $configData['borderSize'];
	}
	
	if(isset($configData['borderColour']) && $configData['borderColour'] != "") {
	    $html .= ",borderColour: '{$configData['borderColour']}'";
	}
	
	if(isset($configData['lensShape']) && $configData['lensShape'] != "") {
	    $html .= ",lensShape: '{$configData['lensShape']}'";
	}
	
	if(isset($configData['zoomType']) && $configData['zoomType'] != "") {
	    $html .= ",zoomType: '{$configData['zoomType']}'";
	}
	
	if(isset($configData['lensColour']) && $configData['lensColour'] != "") {
	    $html .= ",lensColour: '{$configData['lensColour']}'";
	}
	
	if(isset($configData['lensOpacity']) && $configData['lensOpacity'] != "") {
	    $html .= ",lensOpacity: ". $configData['lensOpacity'];
	}
	
	if(isset($configData['tint']) && $configData['tint'] == 0) {	    
	    $html .= ",tint: false";
	}
	else if(isset($configData['tint']) && $configData['tint'] == 1) {	    
	    $html .= ",tint: true";
	}
	
	if(isset($configData['tintColour']) && $configData['tintColour'] != "") {
	    $html .= ",tintColour: '{$configData['tintColour']}'";
	}
	
	if(isset($configData['tintOpacity']) && $configData['tintOpacity'] != "") {
	    $html .= ",tintOpacity: ". $configData['tintOpacity'];
	}
	
	//if(isset($configData['gallery']) && $configData['gallery'] == 0) {	    
	//    $html .= ",gallery: false";
	//}
	//else if(isset($configData['gallery']) && $configData['gallery'] == 1) {	    
	//    $html .= ",gallery: true";
	//}
	//$html .= ",gallery: 'more-images-slider'";
	
	//if(isset($configData['imageCrossfade']) && $configData['imageCrossfade'] == 0) {	    
	//    $html .= ",imageCrossfade: false";
	//}
	//else if(isset($configData['imageCrossfade']) && $configData['imageCrossfade'] == 1) {	    
	//    $html .= ",imageCrossfade: true";
	//}
	
	if(isset($configData['cursor']) && $configData['cursor'] != "") {
	    $html .= ",cursor: '{$configData['cursor']}'";
	}
	
	
	return $html;
    }
    
}
?>