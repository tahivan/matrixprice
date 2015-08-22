<?php
define('MAGENTO_ROOT', (dirname(__FILE__).'/../../../../..'));
$mageFilename = MAGENTO_ROOT . '/app/Mage.php';
require_once $mageFilename;

umask(0);
if ( empty($_GET['store']) ) {
    $_GET['store'] = '';
}
Mage::app( $_GET['store'] );

header("Content-type: text/css; charset: UTF-8");

$instance = Mage::helper("ExtraConfig");

$cssValueArray = array();
$cssColorValueArray = Mage::getStoreConfig('themecolor' , $_GET['store']);
$cssSettingValueArray = Mage::getStoreConfig('mygeneral' , $_GET['store']);
$cssLayoutValueArray = Mage::getStoreConfig('themelayout' , $_GET['store']);

$cssValueArray = $cssColorValueArray;

foreach($cssValueArray as $cssFieldKey => $cssFieldValue)
{
  foreach($cssFieldValue as $cssKey => $cssValue)
  {    
    if(($cssValue == "" || $cssValue == null || $cssValue == '--select--' ))
    {
      unset($cssValueArray[$cssFieldKey][$cssKey]);
    }   
  }
}


foreach($cssSettingValueArray as $cssFieldKey => $cssFieldValue)
{
  foreach($cssFieldValue as $cssKey => $cssValue)
  {    
    if(($cssValue == "" || $cssValue == null || $cssValue == '--select--' ))
    {
      unset($cssSettingValueArray[$cssFieldKey][$cssKey]);
    }   
  }
}


foreach($cssLayoutValueArray as $cssFieldKey => $cssFieldValue)
{
  foreach($cssFieldValue as $cssKey => $cssValue)
  {    
    if(($cssValue == "" || $cssValue == null || $cssValue == '--select--' ))
    {
      unset($cssLayoutValueArray[$cssFieldKey][$cssKey]);
    }   
  }
}

?>

/* start Colors */
        <?php if(isset($cssValueArray['colors']['primary_color'])){ ?>
            
            .postDetails a,
            .postContent a.aw-blog-read-more,
            #mega-nav > li:hover > a,
            #mega-nav li.active > a,
            #mega-nav ul.subs > li > a:hover,
            #mega-nav ul.subs li li a:hover,
            #mega-nav .mega-block .header-mega-dropdown-wrapper a:hover,
            #mega-nav .mega-block .show-separators .links a:hover,
            #mega-nav .megamenu-vertical ul.subs li:hover > a,
            .tparrows.default:hover,
            .owl-theme .owl-controls .owl-buttons div:hover,
            .accordion .opener:hover,
            .language .dropdown-menu a:hover,
            .currency .dropdown-menu a:hover,
            .links > li > a:hover,
            .resp-tabs-list li:hover,
            .resp-tab-active,
            .nav-container #nav li a.over,
            .nav-container #nav li.hover > a,
            .nav-container #nav a:hover,
            .nav-container #nav li.active a.level-top,            
            .nav-container #nav li ul li a.over,
            .nav-container #nav li ul li a:hover,
            .nav-container #nav li ul li.hover > a,
            .toggleMenu.active,
            .toggleMenu:hover,
            a:hover,
            .limiter a:hover,
            .limiter a.selected,
            .btn-remove:hover,
            .btn-remove2:hover,
            .btn-edit:hover,
            .tool-tip .btn-close a:hover,
            .cart-table .link-wishlist:hover,
            .compare-table .link-wishlist:hover,
            .peer-cancel-img:hover,
            .shopping_cart .subtotal .price,
            .form-search:hover .button span,
            .block-account li strong,
            #sidenav li.active > a,
            #sidenav li a.show-cat.active,
            .block-subscribe button.button:hover span,
            .products-list .link-learn,
            .addto-links-icons span.icon:hover,
            .product-view .product-shop .social-link a:hover,
            .block-progress dd.complete .changelink a,
            .multiple-checkout .col2-set h3.legend,
            .info-set h3.legend,
            .checkout-progress li.active,
            .addresses-list ol li a,
            .order-date,
            .footer a:hover,
            .footer-bottom address a:hover,
            a.scrollup:hover,
            .page-not-found1 .above-heading,
            .page-not-found1 .bottom-below-heading,
            .page-not-found2 .bottom-below-heading,
            .banner .owl-theme .owl-controls .owl-buttons div:hover,
            #side-nav > li:hover > a, #side-nav > li.active > a,
            #side-nav ul.subs li a:hover
            { color: <?php echo $cssValueArray['colors']['primary_color'];?>; }
            
            .products-grid button.button:hover span,
            .products-list button.button:hover span,
            .add-to-cart .button.button:hover span
            { color: <?php echo $cssValueArray['colors']['primary_color'];?> !important; }
            
            #cssmenu ul li a:hover,
            #cssmenu #mobile-menu li:hover > .open,
            #cssmenu #mobile-menu .open:hover,
            #cssmenu #mobile-menu .open.active,
            .tp-caption.Flexform_BigCentre,
            #nav.color a:hover,
            #nav.color li.active a.level-top:hover,
            #nav.color li:hover > .more,
            #nav.color li .more:hover,
            #nav.color li.hover > .more
            { color: <?php echo $cssValueArray['colors']['primary_color'];?> !important; }
            
            .peer-icon-hover:hover .icon,
            .highlighted,
            .quantity_counter a:hover,
            .pager .pages li a:hover,
            .pager .pages li.current
            .pager .pages li a:hover,
            .pager .pages li.current,
            .pager .view-mode .grid:hover,
            .pager .view-mode .grid.grid-mode-active,
            .pager .view-mode .list:hover,
            .pager .view-mode .list.list-mode-active,
            .tags-list a:hover,
            .data-table .btn-edit:hover,
            .data-table .btn-remove:hover,
            .data-table .btn-remove2:hover,
            .data-table .link-wishlist:hover,
            .ui-rangeSlider-bar
            { background-color: <?php echo $cssValueArray['colors']['primary_color'];?>; }
            
            /*Primary Button*/
            button.button:hover span,
            div.alert-inner a.continue:hover,
            .buttons-set .back-link a:hover
            { background-color: <?php echo $cssValueArray['colors']['primary_color'];?>; }
            
            button.btn-checkout:hover span,
            button.btn-cart:hover span,
            div.alert-inner a.cart:hover,
            .account-login .buttons-set button:hover span,
            #opc-login .buttons-set button:hover span
            { background-color: <?php echo $cssValueArray['colors']['primary_color'];?> !important; }
            
            .radial .label,
            .arc,
            .component
            { fill: <?php echo $cssValueArray['colors']['primary_color'];?>; }
            
            .ui-rangeSlider-handle
            { border-color: <?php echo $cssValueArray['colors']['primary_color'];?>; }
            
        <?php } ?>
        
        <?php if(isset($cssValueArray['colors']['secondary_color'])){ ?>
                   
            #mega-nav .megamenu-vertical ul.subs li:hover > a,
            .owl-theme .owl-controls .owl-buttons div,
            .language .dropdown-menu a:hover,
            .currency .dropdown-menu a:hover,
            .language .dropdown-menu a.selected,
            .currency .dropdown-menu a.selected,
            .nav-container #nav li ul li a.over,
            .nav-container #nav li ul li a:hover,
            .nav-container #nav li ul li.hover > a,
            .header-top-container,
            .addto-links-icons span.icon,
            .opc .active .step-title,
            .dashboard .box-reviews .number,
            .dashboard .box-tags .number,
            .order-info li a:hover,
            .order-info li.current,
            .footer-container,
            .footer .section-line > *,
            .footer .accordion .opener,
            .footer .accordion .opener:hover            
            { background-color: <?php echo $cssValueArray['colors']['secondary_color'];?>; }
            
            .arc2
            { fill: <?php echo $cssValueArray['colors']['secondary_color'];?>; }
            
            #cssmenu ul li a:hover,
            #nav.color a:hover,
            #nav.color li.active a.level-top:hover,
            .products-grid button.button span,
            .products-list button.button span,
            .add-to-cart .button.button span,
            .products-grid button.button:hover span,
            .products-list button.button:hover span,
            .add-to-cart .button.button:hover span
            { background-color: <?php echo $cssValueArray['colors']['secondary_color'];?> !important; }            
            
            input.input-text:hover, select:hover, textarea:hover, 
            input.input-text:focus, select:focus, textarea:focus,
            .ui-editRangeSlider-inputValue:hover, .ui-editRangeSlider-inputValue:focus
            { border-color: <?php echo $cssValueArray['colors']['secondary_color'];?>; }
            
            /*Secondary Button*/
            button.btn-checkout span,
            button.btn-cart span,
            div.alert-inner a.cart,
            .account-login .buttons-set button span,
            #opc-login .buttons-set button span
            { background-color: <?php echo $cssValueArray['colors']['secondary_color'];?> !important; }
            
        <?php } ?>
        
        <?php if(isset($cssValueArray['colors']['third_color'])){ ?>
            
            div.alert-inner p,
            .peer-icon .icon,
            input.input-text, select, textarea,
            input.product-custom-option,
            .ui-editRangeSlider-inputValue,
            .quantity_counter a,
            .pager .pages li a,
            .pager .view-mode .grid,
            .pager .view-mode .list,
            .data-table .btn-edit,
            .data-table .btn-remove,
            .data-table .btn-remove2,
            .data-table .link-wishlist,
            .opc .step-title,
            .account-login .registered-users,
            .opc .registered-users,
            .account-login .registered-users .section-line > *,
            .opc .registered-users .section-line > *,
            .account-login .peer-cancel-img               
            { background-color: <?php echo $cssValueArray['colors']['third_color'];?>; }
            
            /*Third Button*/
            button.button span,
            div.alert-inner a.continue,
            .buttons-set .back-link a         
            { background-color: <?php echo $cssValueArray['colors']['third_color'];?>; }
                
        <?php } ?>

        <?php if(isset($cssValueArray['colors']['border_color'])){ ?>
            
            .cloud-zoom-big,
            .dropdown,
            .resp-tabs-list li,
            .resp-tab-content,
            input.input-text, select, textarea,
            input.product-custom-option,
            .ui-editRangeSlider-inputValue,
            .quantity_counter,
            .quantity_counter input.qty,
            .pager .pages li,
            .data-table th,
            .data-table td,
            .info-box,
            .navmain-container,
            .tags-list a,
            .centinel .authentication,
            .checkout-multishipping-shipping .box-sp-methods,
            .products-list .item,
            .products-grid .item
            {  border-color:  <?php echo $cssValueArray['colors']['border_color'];?>; }

            h2.resp-accordion,
            .form-list li.additional-row,
            .toolbar .pager,
            .block .actions,
            .block-related .block-subtitle,
            .cart-empty p,
            .block-progress,
            .multiple-checkout .buttons-set,
            .dashboard .box .box-title,
            .dashboard .box-account.box-tags,
            .addresses-list h2,
            .order-info-box .box .box-title,
            .page-print h2
            {  border-top-color:  <?php echo $cssValueArray['colors']['border_color'];?>; }
            
            div.alert-inner p,
            .postWrapper,
            #mega-nav .megamenu-vertical ul.subs:before,
            #mega-nav .megamenu-vertical ul.subs li a,
            .dropdown .dropdown-menu:before,
            .language .dropdown-menu a,
            .currency .dropdown-menu a,
            .section-hr,
            .page-title,
            .product-view .product-essential .product-name,
            .nav-container #nav > li > ul.shown-sub:before,
            #mega-nav > li.parent > a:before,
            .nav-container #nav li ul li a,
            select.multiselect option,
            button.button span span,
            .buttons-set .back-link a,
            div.alert a,
            ul .separator,
            .shopping_cart .dropdown-menu .bag-header,
            .shopping_cart .dropdown-menu .mini-products-list li,
            .wishlist .dropdown-menu .bag-header,
            .wishlist .dropdown-menu .mini-products-list li,
            .navmain-container.fixed,
            .block .block-content li,
            #sidenav li a,
            .block-related .block-subtitle,
            .product-view .price-stock,
            .product-view .product-shop .product-meta,
            .product-view .short-description,
            .product-view .product-shop .social-link,
            .product-view .container1-wrapper,
            .product-view .container2-wrapper,
            .product-view .add-to-box,
            .product-shop .product-options-bottom,
            .product-view .box-reviews dd,
            .data-table .btn-edit,
            .data-table .btn-remove,
            .data-table .btn-remove2,
            .data-table .link-wishlist,
            .opc .step-title,
            .dashboard .box .box-title,
            .addresses-list h2,
            .order-info-box .box .box-title,
            .page-print h2,
            .remember-me-popup h3,
            .map-popup-heading
            {  border-bottom-color:  <?php echo $cssValueArray['colors']['border_color'];?>; }

            #nav li a,
            #cssmenu ul li a
            {  border-bottom-color:  <?php echo $cssValueArray['colors']['border_color'];?> !important; }
            
            .links-separators .links > li > a,
            .product-view .box-tags .product-tags li
            {  border-right-color:  <?php echo $cssValueArray['colors']['border_color'];?>; }
   
            .links-separators-left .links > li > a,
            blockquote.pullquote
            {  border-left-color:  <?php echo $cssValueArray['colors']['border_color'];?>; }
            
            .separator,
            .order-details h2 .separator
            {  color:  <?php echo $cssValueArray['colors']['border_color'];?>; }
            
            .divider,
            .horizontal-break
            {  background-color:  <?php echo $cssValueArray['colors']['border_color'];?>; }
            
        <?php } ?>
                
/* end Colors */

/* Start Custom Icons */

        <?php if(isset($cssValueArray['colors']['custom_icon_color'])){ ?>
                .peer-icon .icon
                {  color: <?php echo $cssValueArray['colors']['custom_icon_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['colors']['custom_icon_hovercolor'])){ ?>
                peer-icon-hover:hover .icon
                {  color: <?php echo $cssValueArray['colors']['custom_icon_hovercolor'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['colors']['custom_icon_bg'])){ ?>
                .peer-icon .icon
                {  background-color: <?php echo $cssValueArray['colors']['custom_icon_bg'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['colors']['custom_icon_hoverbg'])){ ?>
                peer-icon-hover:hover .icon
                {  background-color: <?php echo $cssValueArray['colors']['custom_icon_hoverbg'];?>; }
        <?php } ?>                    

/* end Custom Icons */

/* start Button */
        <?php if(isset($cssValueArray['button']['button_color'])){ ?>
                button.button span, div.alert-inner a.continue, .buttons-set .back-link a
                {  color: <?php echo $cssValueArray['button']['button_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['buttonhover_color'])){ ?>
                button.button:hover span, div.alert-inner a.continue:hover, .buttons-set .back-link a:hover
                { color: <?php echo $cssValueArray['button']['buttonhover_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['button_bg_color'])){ ?>
                button.button span, div.alert-inner a.continue, .buttons-set .back-link a
                {  background-color: <?php echo $cssValueArray['button']['button_bg_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['buttonhover_bg_color'])){ ?>
                button.button:hover span, div.alert-inner a.continue:hover, .buttons-set .back-link a:hover
                {  background-color: <?php echo $cssValueArray['button']['buttonhover_bg_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['blackbutton_color'])){ ?>
                button.btn-checkout span, button.btn-cart span, div.alert-inner a.cart, .account-login .buttons-set button span, #opc-login .buttons-set button span
                { color: <?php echo $cssValueArray['button']['blackbutton_color'];?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['blackbutton_hover_color'])){ ?>
                button.btn-checkout:hover span, button.btn-cart:hover span, div.alert-inner a.cart:hover, .account-login .buttons-set button:hover span, #opc-login .buttons-set button:hover span
                { color: <?php echo $cssValueArray['button']['blackbutton_hover_color'];?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['blackbutton_bg_color'])){ ?>
                button.btn-checkout span, button.btn-cart span, div.alert-inner a.cart, .account-login .buttons-set button span, #opc-login .buttons-set button span
                {  background-color: <?php echo $cssValueArray['button']['blackbutton_bg_color'];?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['button']['blackbutton_hover_bg_color'])){ ?>
                button.btn-checkout:hover span, button.btn-cart:hover span, div.alert-inner a.cart:hover, .account-login .buttons-set button:hover span, #opc-login .buttons-set button:hover span
                {  background-color: <?php echo $cssValueArray['button']['blackbutton_hover_bg_color'];?> !important; }
        <?php } ?>
        
        
/* end Button */

/* start Background Option */
        <?php if(isset($cssValueArray['background']['background_color'])) { ?>		
                body,
                .section-line > *, .block .block-title strong span, .peercheckout-title h2
                    {
                        background-color: <?php echo $cssValueArray['background']['background_color']; ?>;
                    }
        <?php   } ?>
        
        <?php if(isset($cssValueArray['background']['background_pattern'])){ ?>
             body,
                .section-line > *, .block .block-title strong span, .peercheckout-title h2
                {
                background-image:url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'pattern/'.$cssValueArray['background']['background_pattern'];?>);
                }
        <?php } elseif(isset($cssValueArray['background']['background_image'])){ ?>
                body,
                .section-line > *, .block .block-title strong span, .peercheckout-title h2
                {
                        background-image: url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'custom/image/'.$cssValueArray['background']['background_image'];?>);
                        background-attachment: <?php echo $cssValueArray['background']['bg_attachment'];?>;
                        background-position: <?php echo $cssValueArray['background']['bg_position_y'];?> <?php echo $cssValueArray['background']['bg_position_x'];?>;
                        background-repeat: <?php echo $cssValueArray['background']['bg_repeat'];?>;
         
                    <?php if ($cssValueArray['background']['bg_attachment'] == 'fixed') { ?>
                        background-size: cover;
                    <?php } ?> 
                }            
        <?php } ?>
        
/* End Background Option */


/* Theme Fonts Settings */

        <?php if(isset($cssValueArray['themefont']['title_background_color'])) {?>		
                .page-title, .product-view .product-essential .product-name
                    {
                        background-color: <?php echo $cssValueArray['themefont']['title_background_color']; ?>;
                        
                    }
        <?php } ?>
        <?php
        
        if(isset($cssValueArray['themefont']['title_background_pattern'])) { ?>
            .page-title, .product-view .product-essential .product-name
            {
                background-image:url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'pattern/'.$cssValueArray['themefont']['title_background_pattern']; ?>);
            }
            
        <?php    
        } elseif(isset($cssValueArray['themefont']['title_background_image'])) { ?>    
        
        .page-title, .product-view .product-essential .product-name
            {
                    background-image: url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'custom/image/'.$cssValueArray['themefont']['title_background_image']; ?>);
                    background-attachment: <?php echo $cssValueArray['themefont']['title_bg_attachment'];?>;
                    background-position: <?php echo $cssValueArray['themefont']['title_bg_position_y'];?> <?php echo $cssValueArray['themefont']['title_bg_position_x'];?>;
                    background-repeat: <?php echo $cssValueArray['themefont']['title_bg_repeat'];?>;
                    
                    <?php if ($cssValueArray['themefont']['title_bg_attachment']) { ?>
                            background-size: cover;
                    <?php	} ?>
            }        
        <?php }?>   

        <?php if(isset($cssValueArray['themefont']['titlefont'])) {  ?>
                .page-title h1,
                .page-title h2,
                .page-print h1,
                .product-view .product-essential .product-name h1
                {font-family: '<?php echo $cssValueArray['themefont']['titlefont']; ?>';} 
        <?php } ?>  
        
        <?php if(isset($cssValueArray['themefont']['titlefont_color'])) {  ?>             
                .page-title h1,
                .page-title h2,
                .page-print h1,
                .product-view .product-essential .product-name h1
                {  color: <?php echo $cssValueArray['themefont']['titlefont_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['themefont']['titleborder_color'])) {  ?>             
                .page-title, .product-view .product-essential .product-name
                {  border-color: <?php echo $cssValueArray['themefont']['titleborder_color'];?>;}
        <?php } ?>          
            
        <?php if(isset($cssValueArray['themefont']['bodyfont'])) {  ?>
                body,
                input, select, textarea, button
                {font-family: '<?php echo $cssValueArray['themefont']['bodyfont']; ?>';}
        <?php } ?>	
         
        <?php if(isset($cssValueArray['themefont']['bodyfont_color'])) {  ?>
                body,
                a,
                input.input-text, select, textarea,
                input.product-custom-option,
                .form-search button.button span,
                .ui-editRangeSlider-inputValue
                
                {  color: <?php echo $cssValueArray['themefont']['bodyfont_color'];?>;}
        <?php } ?>
        <?php if(isset($cssValueArray['themefont']['sectiontitle_font'])) {  ?>
                .section-line > *, .block .block-title strong span, .peercheckout-title h2 
                {font-family: '<?php echo $cssValueArray['themefont']['sectiontitle_font']; ?>';}
        <?php } ?>	
         
        <?php if(isset($cssValueArray['themefont']['sectiontitle_color'])) {  ?>
                .section-line > *, .block .block-title strong span, .peercheckout-title h2 
                {  color: <?php echo $cssValueArray['themefont']['sectiontitle_color'];?>;}
        <?php } ?>
        <?php if(isset($cssValueArray['themefont']['sectiontitle_bordercolor'])) {  ?>
                .section-line:before, .block .block-title:before, .peercheckout-title:before
                {  border-color: <?php echo $cssValueArray['themefont']['sectiontitle_bordercolor'];?>;}
        <?php } ?>         
/* End Theme Fonts Settings */


/* Start Header */
        <?php if(isset($cssValueArray['header']['headerbg_color'])) {
            
            $header_opacity = $cssSettingValueArray['header']['header_opacity'];
            $hex2 =  $cssValueArray['header']['headerbg_color']; 
            $val2 = $instance->html2rgb($hex2);
        
            $color = 'rgba('.$val2[0].','. $val2[1].','. $val2[2].','. $header_opacity.')';
            $shadowcolor22 = $color;
        ?>	   
            .header-container
                    {
                        background-color: <?php echo $shadowcolor22; ?>;
                    }   
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['headerbg_pattern'])) { ?>
            .header-container{
            background-image:url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'pattern/'.$cssValueArray['header']['headerbg_pattern']; ?>);
            }
        <?php } elseif(isset($cssValueArray['header']['headerbg_image'])) { ?>    
                .header-container
                {
                        background-image: url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'custom/image/'.$cssValueArray['header']['headerbg_image'];?>);
                        background-attachment: <?php echo $cssValueArray['header']['headerbg_attachment'];?>;
                         background-position: <?php echo $cssValueArray['header']['headerbg_position_y'];?> <?php echo $cssValueArray['header']['headerbg_position_x'];?>;
                        background-repeat: <?php echo $cssValueArray['header']['headerbg_repeat'];?>;
                        
                        <?php if ($cssValueArray['header']['headerbg_attachment']== 'fixed') { ?>
                            background-size: cover;
                        <?php	} ?>
                }                  
        <?php }?>
        
        
        <?php if(isset($cssValueArray['header']['inner_bg_color'])){ ?>
                .header             
                {  background-color: <?php echo $cssValueArray['header']['inner_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['topheader_bg_color'])){ ?>
                .header-top-container    
                {  background-color: <?php echo $cssValueArray['header']['topheader_bg_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['header']['inner_topheader_bg_color'])){ ?>
                .header-top             
                {  background-color: <?php echo $cssValueArray['header']['inner_topheader_bg_color'];?>;}
        <?php } ?>              
        
        <?php if(isset($cssValueArray['header']['language_currency_titlecolor'])){ ?>
               .language .dropdown-toggle.cover > div,
               .currency .dropdown-toggle.cover > div
                { color: <?php echo $cssValueArray['header']['language_currency_titlecolor'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['language_currency_fontcolor'])){ ?>
                .language .dropdown-menu a, .currency .dropdown-menu a
                { color: <?php echo $cssValueArray['header']['language_currency_fontcolor'];?>;}
        <?php } ?>
                
        <?php if(isset($cssValueArray['header']['language_currency_font_hovercolor'])){ ?>
                .language .dropdown-menu a:hover, .currency .dropdown-menu a:hover
                { color: <?php echo $cssValueArray['header']['language_currency_font_hovercolor'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['language_currency_font_selectedcolor'])){ ?>
                .language .dropdown-menu a.selected, .currency .dropdown-menu a.selected
                { color: <?php echo $cssValueArray['header']['language_currency_font_selectedcolor'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['language_currency_dropdown_bg_color'])){ ?>
                .language .dropdown-menu, .currency .dropdown-menu
                { background-color: <?php echo $cssValueArray['header']['language_currency_dropdown_bg_color'];?>;}
                
                .language.dropdown .dropdown-toggle .drop-active, .currency.dropdown .dropdown-toggle .drop-active
                { border-bottom-color: <?php echo $cssValueArray['header']['language_currency_dropdown_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['language_currency_dropdown_arrow_color'])){ ?>
                .language .dropdown-toggle .value::after, .currency .dropdown-toggle .value::after
                { border-top-color: <?php echo $cssValueArray['header']['language_currency_dropdown_arrow_color'];?>;}
                
                .language.dropdown:hover .dropdown-toggle .value:after,.currency.dropdown:hover .dropdown-toggle .value:after
                { border-bottom-color: <?php echo $cssValueArray['header']['language_currency_dropdown_arrow_color'];?>;}
        <?php } ?>

        <?php if(isset($cssValueArray['header']['header_border_color'])){ ?>
                .header .links > li > a
                {  border-color: <?php echo $cssValueArray['header']['header_border_color'];?>;}
        <?php } ?>

        <?php if(isset($cssValueArray['header']['header_text_color'])){ ?>
                .header
                {  color: <?php echo $cssValueArray['header']['header_text_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_link_color'])){ ?>
                .header a,
                .header .links > li > a
                {  color: <?php echo $cssValueArray['header']['header_link_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_linkhover_color'])){ ?>
                .header a:hover,
                .header .links > li > a:hover
                {  color: <?php echo $cssValueArray['header']['header_linkhover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['dropdown_bg_color'])){ ?>
                .dropdown-toggle
                {  background-color: <?php echo $cssValueArray['header']['dropdown_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['dropdown_hoverbg_color'])){ ?>
                .dropdown:hover .dropdown-toggle
                {  background-color: <?php echo $cssValueArray['header']['dropdown_hoverbg_color'];?>;}
        <?php } ?>        
    
        <?php if(isset($cssValueArray['header']['dropdown_text_color'])){ ?>
                .dropdown-toggle,
                .form-search button.button span
                {  color: <?php echo $cssValueArray['header']['dropdown_text_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['dropdown_hovertext_color'])){ ?>
                .dropdown:hover .dropdown-toggle,
                .form-search:hover .button span
                {  color: <?php echo $cssValueArray['header']['dropdown_hovertext_color'];?>;}
        <?php } ?>                
        
        <?php if(isset($cssValueArray['header']['dropdown_link_color'])){ ?>
                .dropdown-menu a,
                .language .dropdown-menu a,
                .currency .dropdown-menu a
                {  color: <?php echo $cssValueArray['header']['dropdown_link_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['dropdown_linkhover_color'])){ ?>
                .dropdown-menu a:hover,
                .language .dropdown-menu a:hover, .currency .dropdown-menu a:hover,
                .language .dropdown-menu a.selected, .currency .dropdown-menu a.selected
                {  color: <?php echo $cssValueArray['header']['dropdown_linkhover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['dropdownmenu_bg_color'])){ ?>
                .dropdown-menu
                {  background-color: <?php echo $cssValueArray['header']['dropdownmenu_bg_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['header']['dropdownmenu_text_color'])){ ?>
                .dropdown-menu
                {  color: <?php echo $cssValueArray['header']['dropdownmenu_text_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['dropdown_linkhover_bgcolor'])){ ?>
                .language .dropdown-menu a:hover, .currency .dropdown-menu a:hover,
                .language .dropdown-menu a.selected, .currency .dropdown-menu a.selected
                {  background-color: <?php echo $cssValueArray['header']['dropdown_linkhover_bgcolor'];?>;}
        <?php } ?>                
        
        <?php if(isset($cssValueArray['header']['dropdown_arrow_color'])){ ?>
                .dropdown .dropdown-menu:before
                {  border-bottom-color: <?php echo $cssValueArray['header']['dropdown_arrow_color'];?>;}
        <?php } ?>                
        
        <?php if(isset($cssValueArray['header']['header_search_button_color'])){ ?>
                .form-search button.button span
                {  color: <?php echo $cssValueArray['header']['header_search_button_color'];?>;}
        <?php } ?>
                
        <?php if(isset($cssValueArray['header']['header_search_buttonhover_color'])){ ?>
                .form-search button.button:hover span
                { color: <?php echo $cssValueArray['header']['header_search_buttonhover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_search_button_bg_color'])){ ?>
                .form-search button.button
                {  background-color: <?php echo $cssValueArray['header']['header_search_button_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_search_buttonhover_bg_color'])){ ?>
                .form-search button.button:hover
                {  background-color: <?php echo $cssValueArray['header']['header_search_buttonhover_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_searchbox_input_color'])){ ?>
                .form-search .input-text
                {  color: <?php echo $cssValueArray['header']['header_searchbox_input_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_searchbox_inputfocus_color'])){ ?>
                .form-search .input-text:focus,
                .form-search .input-text:hover
                {  color: <?php echo $cssValueArray['header']['header_searchbox_inputfocus_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_searchbox_input_bg_color'])){ ?>
                .form-search .dropdown-menu
                {  background-color: <?php echo $cssValueArray['header']['header_searchbox_input_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['header_searchbox_arrow_color'])){ ?>
                .quick-search .dropdown-menu:before
                {  border-bottom-color: <?php echo $cssValueArray['header']['header_searchbox_arrow_color'];?>;}
        <?php } ?>        
        
        <?php if($cssSettingValueArray['header']['header_breakpoint'] == '1') {  ?>
            <?php if(isset($cssSettingValueArray['header']['header_breakpoint_value'])) {  ?>
                body.cms-index-index .header-container, body.cms-index-defaultindex .header-container,body.cms-home .header-container
                {margin-top: <?php echo $cssSettingValueArray['header']['header_breakpoint_value'] ?>px;}
            <?php } ?>
        <?php } ?>
        
        <?php if($cssSettingValueArray['header']['displayheader_wishlistbox'] == '0') {  ?>
                .header-container .wishlist
                {display:none;}
        <?php } ?>
        
/* End Header */


/* Start Menu */
        <?php if(isset($cssValueArray['menu']['topmenu_background'])){ ?>
                .navmain-container
                {  background-color: <?php echo $cssValueArray['menu']['topmenu_background'];?>; }
                .navmain-container.fixed
                {  background-color: <?php echo $cssValueArray['menu']['topmenu_background'];?> !important; }
        <?php } ?>  
            
        <?php if(isset($cssValueArray['menu']['topmenu_fonts'])){ ?>
                .nav-container #nav > li > a,
                #mega-nav > li > a
                {font-family: '<?php echo $cssValueArray['menu']['topmenu_fonts']; ?>';}                    
        <?php } ?>
                
        <?php if(isset($cssValueArray['menu']['topmenu_fonts_color'])){ ?>
                .nav-container #nav > li > a,
                #mega-nav > li > a
                { color: <?php echo $cssValueArray['menu']['topmenu_fonts_color'];?>; }
        <?php } ?>   
            
        <?php if(isset($cssValueArray['menu']['topmenu_fontshover_color'])){ ?>
                .nav-container #nav > li > a:hover,
                .nav-container #nav > li > a.over,
                .nav-container #nav > li.hover > a,
                #mega-nav > li:hover > a
                { color: <?php echo $cssValueArray['menu']['topmenu_fontshover_color'];?>; }
        <?php } ?>                
            
        <?php if(isset($cssValueArray['menu']['topmenu_fontshover_bg_color'])){ ?>
                #mega-nav > li:hover > a,
                .nav-container #nav > li > a:hover,
                .nav-container #nav > li > a.over,
                .nav-container #nav > li.hover > a
                { background: <?php echo $cssValueArray['menu']['topmenu_fontshover_bg_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['menu']['topmenu_selected_fonts_color'])){ ?>
                .nav-container #nav li.active a.level-top,
                #mega-nav li.active > a
                { color: <?php echo $cssValueArray['menu']['topmenu_selected_fonts_color'];?>; }
        <?php } ?>        
        
        <?php if(isset($cssValueArray['menu']['topmenu_selected_background'])){ ?>
                .nav-container #nav li.active a.level-top,
                #mega-nav li.active > a
                { background: <?php echo $cssValueArray['menu']['topmenu_selected_background'];?>; }
        <?php } ?>        
        
        
        <?php if(isset($cssValueArray['menu']['menu_border_color'])){ ?>
                #mega-nav .mega-block .section-line,
                #mega-nav .megamenu-vertical ul.subs li a,
                .navmain-container,
                #mega-nav .mega-block .section-hr,
                #mega-nav .links-separators .links > li > a
                { border-color: <?php echo $cssValueArray['menu']['menu_border_color'];?>; }
                
                .nav-container #nav li ul li a
                { border-color: <?php echo $cssValueArray['menu']['menu_border_color'];?> !important; }
                
                .nav-container #nav > li > ul.shown-sub:before,
                #mega-nav > li.parent > a:before
                { border-bottom-color: <?php echo $cssValueArray['menu']['menu_border_color'];?>; }
        <?php } ?>        
            
        <?php if(isset($cssValueArray['menu']['menu_background'])){ ?>
               .nav-container #nav ul,
                #mega-nav div.mega-block,
                #mega-nav .megamenu-vertical ul,
                #side-nav .sidemenu-block
                {  background-color: <?php echo $cssValueArray['menu']['menu_background'];?>; }
        <?php } ?>        
            
        <?php if(isset($cssValueArray['menu']['submenu_fonts'])){ ?>
                #mega-nav .megamenu-horizontal ul.subs > li > a,
                #mega-nav .mega-block .header-mega-dropdown-wrapper .heading,
                #side-nav ul.subs > li > a
                {font-family: '<?php echo $cssValueArray['menu']['submenu_fonts']; ?>';}                    
        <?php } ?>
            
        <?php if(isset($cssValueArray['menu']['submenu_fonts_color'])){ ?>
                #mega-nav ul.subs > li > a,
                #mega-nav .mega-block .header-mega-dropdown-wrapper .heading,
                #side-nav ul.subs > li > a
                { color: <?php echo $cssValueArray['menu']['submenu_fonts_color'];?>; }
        <?php } ?>
            
        <?php if(isset($cssValueArray['menu']['submenu_fontshover_color'])){ ?>
                #mega-nav ul.subs > li > a:hover,
                #side-nav ul.subs > li > a:hover
                { color: <?php echo $cssValueArray['menu']['submenu_fontshover_color'];?>; }
        <?php } ?>           
            
        <?php if(isset($cssValueArray['menu']['menu_fonts'])){ ?>
                .nav-container #nav li ul li a,
                #mega-nav ul.subs li li a, #mega-nav .mega-block .header-mega-dropdown-wrapper p, #mega-nav .mega-block .header-mega-dropdown-wrapper a, #mega-nav .mega-block .show-separators .links a, #mega-nav .mega-block .show-separators .label,
                #mega-nav .megamenu-vertical ul.subs li a,
                #side-nav ul.subs li li a
                {font-family: '<?php echo $cssValueArray['menu']['menu_fonts']; ?>';}
        <?php } ?>                
            
        <?php if(isset($cssValueArray['menu']['menu_fonts_color'])){ ?>
                .nav-container #nav li ul li a,
                #mega-nav ul.subs li li a, #mega-nav .mega-block .header-mega-dropdown-wrapper p, #mega-nav .mega-block .header-mega-dropdown-wrapper a, #mega-nav .mega-block .show-separators .links a, #mega-nav .mega-block .show-separators .label,
                #mega-nav .megamenu-vertical ul.subs li a,
                #side-nav ul.subs li li a
                { color: <?php echo $cssValueArray['menu']['menu_fonts_color'];?>; }
        <?php } ?>
            
        <?php if(isset($cssValueArray['menu']['menu_fontshover_color'])){ ?>
                .nav-container #nav li ul li a:hover,
                .nav-container #nav li ul li a.over,
                .nav-container #nav li ul li.hover > a,
                .nav-container #nav > li.hover > a,
                #mega-nav ul.subs li li a:hover, #mega-nav .mega-block .header-mega-dropdown-wrapper a:hover, #mega-nav .mega-block .show-separators .links a:hover,
                #mega-nav .megamenu-vertical ul.subs li:hover > a,
                #side-nav ul.subs li li a:hover
                { color: <?php echo $cssValueArray['menu']['menu_fontshover_color'];?>; }
        <?php } ?>        
        
        <?php if(isset($cssValueArray['menu']['menu_hoverbg_color'])){ ?>
               .nav-container #nav li ul li a.over, .nav-container #nav li ul li a:hover, .nav-container #nav li ul li.hover > a,
               #mega-nav .megamenu-vertical ul.subs li:hover > a
                {  background-color: <?php echo $cssValueArray['menu']['menu_hoverbg_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['menu']['menu_arrow_color'])){ ?>
               .nav-container #nav > li > ul.shown-sub:before,
               #mega-nav > li.parent > a:before
                {  border-bottom-color: <?php echo $cssValueArray['menu']['menu_arrow_color'];?>; }
                
                #side-nav .sidemenu-block:before
                {  border-right-color: <?php echo $cssValueArray['menu']['menu_arrow_color'];?>; }
                
        <?php } ?>        
        
        <?php if(isset($cssValueArray['menu']['label_font_color'])){ ?>
                .nav-container #nav > li > a span.category-label,
                span.category-label,
                #mega-nav > li > a span.category-label                
                { color: <?php echo $cssValueArray['menu']['label_font_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['menu']['label_hoverfont_color'])){ ?>
                .nav-container #nav li a.over span.category-label,
                .nav-container #nav li.hover > a span.category-label,
                a:hover span.category-label,
                #mega-nav > li > a:hover span.category-label
                { color: <?php echo $cssValueArray['menu']['label_hoverfont_color'];?>; }
        <?php } ?>        
        
        <?php if(isset($cssValueArray['menu']['label_bg_color'])){ ?>
                span.category-label
                { background-color: <?php echo $cssValueArray['menu']['label_bg_color'];?>; }
                
                span.category-label:before
                { border-top-color: <?php echo $cssValueArray['menu']['label_bg_color'];?>; }
                
        <?php } ?>
        
        <?php if(isset($cssValueArray['menu']['label_hoverbg_color'])){ ?>
                .nav-container #nav li a.over span.category-label, a:hover span.category-label, #mega-nav > li:hover > a span.category-label
                { background-color: <?php echo $cssValueArray['menu']['label_hoverbg_color'];?>; }
                
                a:hover span.category-label:before, .nav-container #nav li a.over span.category-label:before, #mega-nav > li:hover > a span.category-label:before               
                { border-top-color: <?php echo $cssValueArray['menu']['label_hoverbg_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['header']['stickyheader_bg_color'])){ ?>
                .navmain-container.fixed
                { background-color: <?php echo $cssValueArray['header']['stickyheader_bg_color'];?> !important;}
        <?php } ?>
            
        <?php if(isset($cssValueArray['header']['header_border_bottom_color'])){ ?>
                .navmain-container.fixed
                { border-bottom-color: <?php echo $cssValueArray['header']['header_border_bottom_color'];?>;}
        <?php } ?>            
        
        <?php if(Mage::helper("ExtraConfig")->is_mobile() == true){ ?>
                .navmain-container.fixed{position: inherit;}
        <?php } ?>        
   
/* End Menu */


/* Responsive Menu Starts */
        <?php if(isset($cssValueArray['responsivemenu']['button_color'])) {  ?>
            .toggleMenu
               {   color: <?php echo $cssValueArray['responsivemenu']['button_color']; ?>;  }               
        <?php } ?>        
        
        <?php if(isset($cssValueArray['responsivemenu']['button_hover_color'])) {  ?>
            .toggleMenu:hover
                {   color: <?php echo $cssValueArray['responsivemenu']['button_hover_color']; ?> !important;   } 
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['button_selected_color'])) {  ?>
            .toggleMenu.active
                {   color: <?php echo $cssValueArray['responsivemenu']['button_selected_color']; ?> !important;  }                
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['responsive_topmenu_font_family'])) {  ?>
            .nav-container #nav.color > li > a,
            .toggleMenu,
            #cssmenu #mobile-menu > li > a
                {   font-family: '<?php echo $cssValueArray['responsivemenu']['responsive_topmenu_font_family']; ?>' !important;} 
        <?php } ?>
        
         <?php if(isset($cssValueArray['responsivemenu']['responsive_submenu_font_family'])) {  ?>
            #nav.color li li a  ,
            #cssmenu ul li li a
                {   font-family: '<?php echo $cssValueArray['responsivemenu']['responsive_submenu_font_family']; ?>' !important;} 
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['menu_font_color'])) {  ?>
            #nav.color a,
            #cssmenu ul li a
                {   color: <?php echo $cssValueArray['responsivemenu']['menu_font_color']; ?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['menu_hoverfont_color'])) {  ?>
            #nav.color a:hover,
            #cssmenu ul li a:hover
                {   color: <?php echo $cssValueArray['responsivemenu']['menu_hoverfont_color']; ?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['menu_bg_color'])) {  ?>
            #nav.color a,
            #nav.color a.over,
            #nav.color li.active a.level-top,
            #cssmenu ul li a
                {   background-color: <?php echo $cssValueArray['responsivemenu']['menu_bg_color']; ?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['menu_hoverbg_color'])) {  ?>
            #nav.color a:hover,
            #nav.color li.active a.level-top:hover,
            #cssmenu ul li a:hover
                {   background-color: <?php echo $cssValueArray['responsivemenu']['menu_hoverbg_color']; ?> !important; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['menu_seperator_color'])) {  ?>
            #nav.color li a,
            #cssmenu ul li a
                {   border-color: <?php echo $cssValueArray['responsivemenu']['menu_seperator_color']; ?>!important;   }                
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['arrow_color'])) {  ?>
            #nav.color li .more,
            #cssmenu #mobile-menu .open
                {   color: <?php echo $cssValueArray['responsivemenu']['arrow_color']; ?> !important;   }                
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['arrow_hover_color'])) {  ?>
            #nav.color li:hover > .more,
            #nav.color li .more:hover,
            #nav.color li.hover > .more,
            #cssmenu #mobile-menu .open:hover,
            #cssmenu #mobile-menu li:hover > .open,
            #cssmenu #mobile-menu .open:hover,
            #cssmenu #mobile-menu .open.active
                {  color: <?php echo $cssValueArray['responsivemenu']['arrow_hover_color']; ?> !important;   }                
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['arrow_background_color'])) {  ?>
            #nav.color li .more,
            #cssmenu #mobile-menu .open
                {   background-color: <?php echo $cssValueArray['responsivemenu']['arrow_background_color']; ?> !important;   }                
        <?php } ?>
        
        <?php if(isset($cssValueArray['responsivemenu']['arrow_hover_background_color'])) {  ?>
            #nav.color li:hover > .more,
            #nav.color li .more:hover,
            #nav.color li.hover > .more,
            #cssmenu #mobile-menu .open:hover,
            #cssmenu #mobile-menu li:hover > .open,
            #cssmenu #mobile-menu .open:hover,
            #cssmenu #mobile-menu .open.active
                {   background-color: <?php echo $cssValueArray['responsivemenu']['arrow_hover_background_color']; ?> !important;   }                
        <?php } ?>
/* Responsive Menu Ends */

/* Banner Starts*/
        
        <?php if(isset($cssValueArray['banner']['banner_title_color'])){ ?>
               .banner-slider .caption .heading
                {color: <?php echo $cssValueArray['banner']['banner_title_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_title_bg_color'])){ ?>
               .banner-slider .caption .heading
                {background-color: <?php echo $cssValueArray['banner']['banner_title_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_title_size'])){ ?>
               .banner-slider .caption .heading
                {font-size: <?php echo $cssValueArray['banner']['banner_title_size'];?>px;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_content_color'])){ ?>
               .banner-slider .caption p
                {color: <?php echo $cssValueArray['banner']['banner_content_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_content_bg_color'])){ ?>
               .banner-slider .caption p
                {background-color: <?php echo $cssValueArray['banner']['banner_content_bg_color'];?>;}
        <?php } ?>
        
         <?php if(isset($cssValueArray['banner']['banner_arrow_color'])){ ?>
               .banner-slider .owl-theme .owl-controls .owl-buttons div,
               .tp-leftarrow.default, .tp-rightarrow.default
                {color: <?php echo $cssValueArray['banner']['banner_arrow_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_arrow_hover_color'])){ ?>
               .banner .owl-theme .owl-controls .owl-buttons div:hover,
               .tp-leftarrow:hover, .tp-rightarrow:hover
                {color: <?php echo $cssValueArray['banner']['banner_arrow_hover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_arrow_bg_color'])){ ?>
               .banner .owl-theme .owl-controls .owl-buttons div,
               .tp-leftarrow.default, .tp-rightarrow.default
                {background-color: <?php echo $cssValueArray['banner']['banner_arrow_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_arrow_hover_bg_color'])){ ?>
               .banner .owl-theme .owl-controls .owl-buttons div:hover,
               .tp-leftarrow:hover, .tp-rightarrow:hover
                {background-color: <?php echo $cssValueArray['banner']['banner_arrow_hover_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_button_color'])){ ?>
               .banner-slider .caption button.button span
                {color: <?php echo $cssValueArray['banner']['banner_button_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_button_hover_color'])){ ?>
               .banner-slider .caption button.button:hover span
                {color: <?php echo $cssValueArray['banner']['banner_button_hover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_button_bg_color'])){ ?>
               .banner-slider .caption button.button span
                {background-color: <?php echo $cssValueArray['banner']['banner_button_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_button_hover_bg_color'])){ ?>
               .banner-slider .caption button.button:hover span
                {background-color: <?php echo $cssValueArray['banner']['banner_button_hover_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_p_bg'])){ ?>
               .owl-theme .owl-controls .owl-page
                {background-color: <?php echo $cssValueArray['banner']['banner_p_bg'];?>;}
        <?php } ?>                
        
        <?php if(isset($cssValueArray['banner']['banner_phover_bg'])){ ?>
               .owl-theme .owl-controls.clickable .owl-page:hover
                {background-color: <?php echo $cssValueArray['banner']['banner_phover_bg'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['banner']['banner_pselected_bg'])){ ?>
               .owl-theme .owl-controls .owl-page.active
                {background-color: <?php echo $cssValueArray['banner']['banner_pselected_bg'];?>;}
        <?php } ?>   
        
        <?php if($cssSettingValueArray['banner']['breakpoint'] == '1') {  ?>
            <?php if(isset($cssSettingValueArray['banner']['banner_breakpoint_value'])) {  ?>
                .bannerslider, .bannercontainer{margin-top: <?php echo $cssSettingValueArray['banner']['banner_breakpoint_value'] ?>px;}
            <?php } ?>
        <?php } ?>
        
        <?php if($cssSettingValueArray['banner']['bannerpossition'] == '1') {  ?>
                body.cms-index-index .header-container, body.cms-index-defaultindex .header-container,body.cms-home .header-container{position: absolute;}
        <?php } ?>          
            
/* End Banner */

/* Tab */

        <?php if(isset($cssValueArray['tab']['tab_border_color'])){ ?>
                .resp-tab-content,
                .resp-tabs-list li,
                h2.resp-accordion
                {border-color: <?php echo $cssValueArray['tab']['tab_border_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['tab']['tab_font_color'])){ ?>
                .resp-tabs-list li,
                h2.resp-accordion
                {color: <?php echo $cssValueArray['tab']['tab_font_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['tab']['tab_font_hover_color'])){ ?>
                .resp-tabs-list li:hover,
                h2.resp-accordion:hover
                {color: <?php echo $cssValueArray['tab']['tab_font_hover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['tab']['tab_font_selected_color'])){ ?>
                .resp-tabs-list .resp-tab-active, .resp-tabs-list li.resp-tab-active:hover
                {color: <?php echo $cssValueArray['tab']['tab_font_selected_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['tab']['tab_hover_bg_color'])){ ?>
                .resp-tabs-list li:hover
                {background-color: <?php echo $cssValueArray['tab']['tab_hover_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['tab']['tab_selected_bg_color'])){ ?>
                .resp-tab-active, .resp-tabs-list li.resp-tab-active:hover
                {background-color: <?php echo $cssValueArray['tab']['tab_selected_bg_color'];?>;}
        <?php } ?>

/* End Tab */

/* Sidebar Starts */       
            
        <?php if(isset($cssValueArray['sidebar']['sidebar_title_fonts'])){ ?>
            .sidebar .block .block-title strong span
               {font-family: '<?php echo $cssValueArray['sidebar']['sidebar_title_fonts']; ?>';}            
        <?php } ?>    
            
        <?php if(isset($cssValueArray['sidebar']['sidebar_title_fonts_color'])){ ?>
                .sidebar .block .block-title strong span,
                .category-full .col-left .block.block-layered-nav .block-content .view .opener
                {  color: <?php echo $cssValueArray['sidebar']['sidebar_title_fonts_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['sidebar']['sidebar_title_fonts_border_color'])){ ?>
                .block .block-title:before
                {  border-top-color: <?php echo $cssValueArray['sidebar']['sidebar_title_fonts_border_color'];?>; }
        <?php } ?>
        
        <?php if(isset($cssValueArray['sidebar']['sidebar_fonts_color'])){ ?>
                .sidebar .block-content,
                .sidebar .block li a,
                .sidebar .block .actions a
                {  color: <?php echo $cssValueArray['sidebar']['sidebar_fonts_color'];?>; }
        <?php } ?>   
            
        <?php if(isset($cssValueArray['sidebar']['sidebar_linkhover_color'])){ ?>
                .sidebar .block li a:hover,
                .sidebar .block .actions a:hover,
                #sidenav li.active > a, #sidenav li a.show-cat.active,
                .sidebar .block-account .block-content li.current strong,
                .category-full .col-left .block.block-layered-nav .block-content .view .opener:hover
                { color: <?php echo $cssValueArray['sidebar']['sidebar_linkhover_color'];?>; }
        <?php } ?>
        <?php if(isset($cssValueArray['sidebar']['sidebar_seperator_color'])){ ?>
                .block .block-content li,
                #sidenav li a,
                .block .actions
                {  border-color: <?php echo $cssValueArray['sidebar']['sidebar_seperator_color'];?>; }
        <?php } ?>
               
        
/* Sidebar Ends */

/* product Starts */
        <?php if($cssSettingValueArray['product_list']['ajaxpopup'] == '0') {  ?>
                .alert{display: none !important;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['addtocart_color'])) {  ?>
                .products-grid button.button span, .products-list button.button span, .add-to-cart .button.button span
                {  color: <?php echo $cssValueArray['product_list']['addtocart_color'];?> !important;}
        <?php } ?>    
            
        <?php if(isset($cssValueArray['product_list']['addtocart_hover_color'])) {  ?>
                .products-grid button.button:hover span, .products-list button.button:hover span, .add-to-cart .button.button:hover span
                {  color: <?php echo $cssValueArray['product_list']['addtocart_hover_color'];?> !important;}
        <?php } ?>    
            
        <?php if(isset($cssValueArray['product_list']['addtocart_bg_color'])) {  ?>
                .products-grid button.button span, .products-list button.button span, .add-to-cart .button.button span
                {  background-color: <?php echo $cssValueArray['product_list']['addtocart_bg_color'];?> !important;}
        <?php } ?>    
            
        <?php if(isset($cssValueArray['product_list']['addtocart_hoverbg_color'])) {  ?>
                .products-grid button.button:hover span, .products-list button.button:hover span, .add-to-cart .button.button:hover span
                {  background-color: <?php echo $cssValueArray['product_list']['addtocart_hoverbg_color'];?> !important;}
        <?php } ?>    
            
        <?php if(isset($cssValueArray['product_list']['button_fonts'])) {  ?>
                .products-grid button.button span, .products-list button.button span, .add-to-cart .button.button span
                {font-family: '<?php echo $cssValueArray['product_list']['button_fonts']; ?>';}
        <?php } ?>     
        
        <?php if(isset($cssValueArray['product_list']['product_bg'])) {  ?>
                .products-grid .item,
                .products-list .item
                {  background-color: <?php echo $cssValueArray['product_list']['product_bg'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['product_hover_BG_color'])) {  ?>
                .products-grid .item:hover,
                .products-list .item:hover
                {  background-color: <?php echo $cssValueArray['product_list']['product_hover_BG_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['product_list']['product_border_color'])) {  ?>
                .products-grid .item,
                .products-list .item
                {  border-color: <?php echo $cssValueArray['product_list']['product_border_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['product_hoverborder_color'])) {  ?>
                .products-grid .item:hover,
                .products-list .item:hover
                {  border-color: <?php echo $cssValueArray['product_list']['product_hoverborder_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['product_list']['productname_color'])) {  ?>
                .products-grid .product-name a,
                .products-list .product-name a
                {  color: <?php echo $cssValueArray['product_list']['productname_color'];?>;}
        <?php } ?>
            
        <?php if(isset($cssValueArray['product_list']['productname_hover_color'])) {  ?>
               .products-grid .product-name a:hover,
               .products-list .product-name a:hover
                {  color: <?php echo $cssValueArray['product_list']['productname_hover_color'];?>;}
        <?php } ?>
            
        <?php if(isset($cssValueArray['product_list']['productname_fonts'])) {  ?>
                .products-grid .product-name a,
                .products-list .product-name a
                {font-family: '<?php echo $cssValueArray['product_list']['productname_fonts']; ?>';}
        <?php } ?>
             
        <?php if(isset($cssValueArray['product_list']['product_price_color'])) {  ?>
                .products-grid .price-box .price,
                .products-list .price-box .price,
                .product-view .product-shop .price-box .price,
                .products-grid .price-box .price-label,
                .products-list .price-box .price-label,
                .product-view .product-shop .price-box .price-label
                {  color: <?php echo $cssValueArray['product_list']['product_price_color'];?>;}
        <?php } ?>
            
        <?php if(isset($cssValueArray['product_list']['product_price_fonts'])) {  ?>
                .products-grid .price-box .price,
                .products-list .price-box .price,
                .product-view .product-shop .price-box .price,
                .products-grid .price-box .price-label,
                .products-list .price-box .price-label,
                .product-view .product-shop .price-box .price-label                    
                {font-family: '<?php echo $cssValueArray['product_list']['product_price_fonts']; ?>';}
        <?php } ?>
         
        <?php if(isset($cssValueArray['product_list']['addto_color'])) {  ?>
                .addto-links-icons span.icon
                {  color: <?php echo $cssValueArray['product_list']['addto_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['addto_hover_color'])) {  ?>
                .addto-links-icons span.icon:hover
                {  color: <?php echo $cssValueArray['product_list']['addto_hover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['addto_bg_color'])) {  ?>
                .addto-links-icons span.icon
                {  background-color: <?php echo $cssValueArray['product_list']['addto_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['addto_hover_bg_color'])) {  ?>
                .addto-links-icons span.icon:hover
                {  background-color: <?php echo $cssValueArray['product_list']['addto_hover_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['addto_left_border_color'])) {  ?>
                .addto-links-icons li    
                {  border-left-color: <?php echo $cssValueArray['product_list']['addto_left_border_color'];?>;}
        <?php } ?>        
        
        <?php if($cssSettingValueArray['product_list']['product_border_onoff'] == '1'){ ?>
                .products-grid .item,
                .products-list .item
                {  border-width: 1px; padding: 10px;}
        <?php } ?>
        
        <?php if(!$cssSettingValueArray['product_list']['addtocart_button']){ ?>
                .products-grid div.btn-cart,
                .products-list .btn-cart,
                .product-view .product-shop .btn-cart{display: none;}
        <?php } ?>
        
        <?php if(!$cssSettingValueArray['product_list']['compare_link']){ ?>
                .products-grid .add-to-links li a.link-compare,
                .products-list .add-to-links li a.link-compare,
                .product-view .product-shop .add-to-links li a.link-compare{display: none;}
        <?php } ?>
        
        <?php if(!$cssSettingValueArray['product_list']['wishlist_link']){ ?>
                .products-grid .add-to-links li a.link-wishlist,
                .products-list .add-to-links li a.link-wishlist,
                .product-view .product-shop .add-to-links li a.link-wishlist{display: none;}
        <?php } ?>
        
        <?php if(!$cssSettingValueArray['product_list']['quick_view']){ ?>
                .products-grid .add-to-links li a.fancybox,
                .products-list .add-to-links li a.fancybox{display: none;}
        <?php } ?>        
        
        <?php if(!$cssSettingValueArray['product_list']['addtocart_button'] && !$cssSettingValueArray['product_list']['compare_link'] && !$cssSettingValueArray['product_list']['wishlist_link'] && !$cssSettingValueArray['product_list']['quick_view']){ ?>
                .products-grid .actions,
                .products-list .actions{display: none;}
        <?php } ?>
        
        
        <?php if(isset($cssValueArray['product_list']['new_label_color'])) {  ?>
                .new
                {   color: <?php echo $cssValueArray['product_list']['new_label_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['new_label_bg_color'])) {  ?>
                .new
                {   background-color: <?php echo $cssValueArray['product_list']['new_label_bg_color'];?>;}
                
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['sale_label_color'])) {  ?>
                .sale
                {   color: <?php echo $cssValueArray['product_list']['sale_label_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['product_list']['sale_label_bg_color'])) {  ?>
                .sale
                {   background-color: <?php echo $cssValueArray['product_list']['sale_label_bg_color'];?>;}
        <?php } ?>        
        
/* product Ends */


/* Category Page Starts */
        <?php if(isset($cssValueArray['category']['selectbox_bg_color'])) {  ?>
                .sort-by select
                {  background-color: <?php echo $cssValueArray['category']['selectbox_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['selectbox_hoverbg_color'])) {  ?>
                .sort-by select:focus,
                .sort-by select:hover
                {  background-color: <?php echo $cssValueArray['category']['selectbox_hoverbg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['selectbox_color'])) {  ?>
                .sort-by select
                {  color: <?php echo $cssValueArray['category']['selectbox_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['selectbox_hover_color'])) {  ?>
                .sort-by select:focus,
                .sort-by select:hover
                {  color: <?php echo $cssValueArray['category']['selectbox_hover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['toolbar_link_color'])) {  ?>
                .limiter a, .limiter span.sep, .sort-by a
                {  color: <?php echo $cssValueArray['category']['toolbar_link_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['toolbar_linkhover_color'])) {  ?>
                .limiter a:hover, .limiter a.selected, .sort-by a:hover
                {  color: <?php echo $cssValueArray['category']['toolbar_linkhover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['toolbar_text_color'])) {  ?>
                .sorter, .pager
                {  color: <?php echo $cssValueArray['category']['toolbar_text_color'];?>;}
        <?php } ?>                
        
        <?php if(isset($cssValueArray['category']['view_bg_color'])) {  ?>
                    .pager .view-mode .grid, .pager .view-mode .list
                    { background-color: <?php echo $cssValueArray['category']['view_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['view_bghover_color'])) {  ?>
                    .pager .view-mode .grid:hover, .pager .view-mode .grid.grid-mode-active, .pager .view-mode .list:hover, .pager .view-mode .list.list-mode-active
                    { background-color: <?php echo $cssValueArray['category']['view_bghover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['view_font_color'])) {  ?>
                    .pager .view-mode .grid, .pager .view-mode .list
                    { color: <?php echo $cssValueArray['category']['view_font_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['view_fonthover_color'])) {  ?>
                    .pager .view-mode .grid:hover, .pager .view-mode .grid.grid-mode-active, .pager .view-mode .list:hover, .pager .view-mode .list.list-mode-active
                    { color: <?php echo $cssValueArray['category']['view_fonthover_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['category']['pagination_color'])) {  ?>
                    .pager .pages li, .pager .pages li a
                    { color: <?php echo $cssValueArray['category']['pagination_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['pagination_hover_color'])) {  ?>
                    .pager .pages li a:hover, .pager .pages li.current
                    { color: <?php echo $cssValueArray['category']['pagination_hover_color'];?>;}
        <?php } ?>                
        
        <?php if(isset($cssValueArray['category']['pagination_bg_color'])) {  ?>
                    .pager .pages li a
                    { background-color: <?php echo $cssValueArray['category']['pagination_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['pagination_hover_bg_color'])) {  ?>
                    .pager .pages li a:hover, .pager .pages li.current
                    { background-color: <?php echo $cssValueArray['category']['pagination_hover_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['category']['pagination_border_color'])) {  ?>
                    .pager .pages li,
                    .toolbar .pager
                    { border-color: <?php echo $cssValueArray['category']['pagination_border_color'];?>;}
        <?php } ?>                 
        
/* Category Page Ends */


/* Footer Starts */
        <?php if(isset($cssValueArray['footer']['footer_background_color']) || isset($cssValueArray['footer']['footer_background_pattern'])) { ?>		
                .footer-container, .footer .section-line > *, .footer .accordion .opener, .footer .accordion .opener:hover
                    {
                        background-color: <?php echo $cssValueArray['footer']['footer_background_color']; ?>;
                    }
        <?php } ?>
        <?php if(isset($cssValueArray['footer']['footer_background_pattern'])) { ?>
            .footer-container, .footer .section-line > *, .footer .accordion .opener, .footer .accordion .opener:hover{
                background-image:url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'pattern/'.$cssValueArray['footer']['footer_background_pattern']; ?>);
            }
        <?php } elseif(isset($cssValueArray['footer']['footer_background_image'])) { ?>    
            .footer-container, .footer .section-line > *, .footer .accordion .opener, .footer .accordion .opener:hover
            {
                    background-image: url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'custom/image/'.$cssValueArray['footer']['footer_background_image']; ?>);
                    background-attachment: <?php echo $cssValueArray['footer']['footer_background_attachment'];?>;
                    background-position: <?php echo $cssValueArray['footer']['footer_background_position_y'];?> <?php echo $cssValueArray['footer']['footer_background_position_x'];?>;
                    background-repeat: <?php echo $cssValueArray['footer']['footer_background_repeat'];?>;
                    
                    <?php if ($cssValueArray['footer']['footer_background_attachment']) { ?>
                            background-size: cover;
                    <?php } ?>
            }        
        <?php } ?>    
        
        <?php if(isset($cssValueArray['footer']['footer_Inner_bg_color'])) {  ?>
                .footer, .footer .section-line > *, .footer .accordion .opener, .footer .accordion .opener:hover
                {  background-color: <?php echo $cssValueArray['footer']['footer_Inner_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['footer_bottom_bg_color'])) {  ?>
                .footer-bottom-container
                {  background-color: <?php echo $cssValueArray['footer']['footer_bottom_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['footer_bottom_inner_bg_color'])) {  ?>
                .footer-bottom
                {  background-color: <?php echo $cssValueArray['footer']['footer_bottom_inner_bg_color'];?>;}
        <?php } ?>        
        
        
        <?php if(isset($cssValueArray['footer']['footer_link_title_color'])) {  ?>
               .footer .accordion .block-title > *
                {  color: <?php echo $cssValueArray['footer']['footer_link_title_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['footer_font_color'])) {  ?>
                .footer
                {  color: <?php echo $cssValueArray['footer']['footer_font_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['footer_link_color'])) {  ?>
                .footer a,
                .footer-bottom address a,
                .footer .links > li > a,
                .footer .accordion .opener
                {  color: <?php echo $cssValueArray['footer']['footer_link_color'];?>;}
        <?php } ?>
            
        <?php if(isset($cssValueArray['footer']['footer_linkhover_color'])) {  ?>
                .footer a:hover,
                .footer-bottom address a:hover,
                .footer .links > li > a:hover,
                .footer .accordion .opener:hover
                {  color: <?php echo $cssValueArray['footer']['footer_linkhover_color'];?>;}
        <?php } ?>
            
        <?php if(isset($cssValueArray['footer']['footer_border_color'])) {  ?>
                .footer-container ul.separator li a,
                .footer-top-border,
                .footer-bottom-border,
                .footer .section-line:before
                {  border-color: <?php echo $cssValueArray['footer']['footer_border_color'];?>;}

        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['footer_topbutton_color'])) {  ?>
                a.scrollup
                {  color: <?php echo $cssValueArray['footer']['footer_topbutton_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['footer_topbutton_hover_color'])) {  ?>
                a.scrollup:hover
                { color: <?php echo $cssValueArray['footer']['footer_topbutton_hover_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['footer']['social_bg_color'])) {  ?>
                .social-link a .icon
                {  background-color: <?php echo $cssValueArray['footer']['social_bg_color'];?>!important;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['social_hoverbg_color'])) {  ?>
                .social-link a .icon:hover
                {  background-color: <?php echo $cssValueArray['footer']['social_hoverbg_color'];?>!important;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['footer']['social_font_color'])) {  ?>
                .social-link a .icon
                {  color: <?php echo $cssValueArray['footer']['social_font_color'];?>!important;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['social_hoverfont_color'])) {  ?>
                .social-link a .icon:hover
                {  color: <?php echo $cssValueArray['footer']['social_hoverfont_color'];?>!important;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['newsletter_button_bg_color'])) {  ?>
                .footer .block-subscribe button.button span
                {  background-color: <?php echo $cssValueArray['footer']['newsletter_button_bg_color'];?> !important;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['newsletter_buttonhover_bg_color'])) {  ?>
                .footer .block-subscribe button.button:hover span
                {  background-color: <?php echo $cssValueArray['footer']['newsletter_buttonhover_bg_color'];?> !important;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['newsletter_button_color'])) {  ?>
                .footer .block-subscribe button.button span
                {  color: <?php echo $cssValueArray['footer']['newsletter_button_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['newsletter_buttonhover_color'])) {  ?>
                .footer .block-subscribe button.button:hover span
                {  color: <?php echo $cssValueArray['footer']['newsletter_buttonhover_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['newsletter_input_text_color'])) {  ?>
                .footer .block-subscribe input
                {  color: <?php echo $cssValueArray['footer']['newsletter_input_text_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['footer']['newsletter_input_bg_color'])) {  ?>
                .footer .block-subscribe input
                {  background-color: <?php echo $cssValueArray['footer']['newsletter_input_bg_color'];?>;}
        <?php } ?>        
/* End Footer */

/* Fixed Bg Image Color Settings */
        
        <?php if(isset($cssValueArray['staticblock']['fixed_background_color']) || isset($cssValueArray['staticblock']['fixed_background_pattern'])) { ?>		
                .fixed-bgimg
                    {
                        background-image: none;
                        background-color: <?php echo $cssValueArray['staticblock']['fixed_background_color']; ?>;
                    }
        <?php } ?>
        <?php if(isset($cssValueArray['staticblock']['fixed_background_pattern'])){ ?>
                .fixed-bgimg
                {
                    background-image:url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'pattern/'.$cssValueArray['staticblock']['fixed_background_pattern']; ?>);
                }
        <?php } elseif(isset($cssValueArray['staticblock']['fixed_background_image'])){ ?>
                .fixed-bgimg
                {
                        background-image: url(<?php echo Mage::getBaseUrl(Mage_Core_Model_Store::URL_TYPE_MEDIA).'custom/image/'.$cssValueArray['staticblock']['fixed_background_image'];?>);
                        background-attachment: <?php echo $cssValueArray['staticblock']['fixed_bg_attachment'];?>;
                        background-position: <?php echo $cssValueArray['staticblock']['fixed_bg_position_y'];?> <?php echo $cssValueArray['staticblock']['fixed_bg_position_x'];?>;
                        background-repeat: <?php echo $cssValueArray['staticblock']['fixed_bg_repeat'];?>;
         
                    <?php if ($cssValueArray['staticblock']['fixed_bg_attachment'] == 'fixed') { ?>
                        background-size: cover;
                    <?php } ?> 
                }            
        <?php } ?>
        
        <?php if(isset($cssValueArray['staticblock']['fixed_border_color'])) {  ?>             
                .fixed-bgimg
                {  border-color: <?php echo $cssValueArray['staticblock']['fixed_border_color'];?>;}
        <?php } ?>
        
       
        <?php if(isset($cssSettingValueArray['staticblock']['fixed_custom_bg_paddingtop'])) {  ?>
            .fixed-bgimg
            {padding-top: <?php echo $cssSettingValueArray['staticblock']['fixed_custom_bg_paddingtop'] ?>px;}
        <?php } ?>
       
        <?php if(isset($cssSettingValueArray['staticblock']['fixed_custom_bg_paddingbottom'])) {  ?>
            .fixed-bgimg
            {padding-bottom: <?php echo $cssSettingValueArray['staticblock']['fixed_custom_bg_paddingbottom'] ?>px;}
        <?php } ?>        

/* End Fixed Bg Image Color Settings */

/* Extra Settings Starts */

        <?php $boxlayout = $cssSettingValueArray['extra_settings']['boxlayout']; ?>
        <?php $responsivewidth = $instance->responsivewidth(); ?>
        <?php $layoutwidth = $cssLayoutValueArray['layout']['layout_width']; ?>
        <?php $customwidth = $cssLayoutValueArray['layout']['custom_width']; ?>
        <?php if( $boxlayout == '1') { ?>
            <?php if($layoutwidth == 'custom'){ ?>
                .page,
                .navmain-container.fixed{max-width:<?php echo $customwidth;?>px;}
            <?php } else { ?>
                .page,
                .navmain-container.fixed{max-width:<?php echo $responsivewidth[$layoutwidth];?>px;}
            <?php } ?>
            
            .page { margin: 0 auto; width: 96%;
                box-shadow: 0 0 5px -1px rgba(0,0,0,0.2);
                -moz-box-shadow: 0 0 5px -1px rgba(0,0,0,0.2);
                -webkit-box-shadow: 0 0 5px -1px rgba(0,0,0,0.2);
                -ms-box-shadow: 0 0 5px -1px rgba(0,0,0,0.2);
                -o-box-shadow: 0 0 5px -1px rgba(0,0,0,0.2);
            }
            
            .container_12 {width: 100%;padding-left:0%; padding-right:0%;}
            
            <?php if(isset($cssValueArray['extra_settings']['boxlayout_bg'])) {  ?>
                .page,
                .section-line > *, .block .block-title strong span, .peercheckout-title h2{  background: <?php echo $cssValueArray['extra_settings']['boxlayout_bg'];?>;}
            <?php } ?>
            
            <?php
                if(isset($cssValueArray['extra_settings']['boxlayout_shadow_color'])) {
                    $shadowcolor4 = $cssValueArray['extra_settings']['boxlayout_shadow_color'];
                }
                if (isset($shadowcolor4) && $shadowcolor4 != null){
                    $hex4 =  $cssValueArray['extra_settings']['boxlayout_shadow_color']; 
                    $val4 = $instance->html2rgb($hex4);
                
                    $color = 'rgba('.$val4[0].','. $val4[1].','. $val4[2].',0.2)';
                    $shadowcolor44 = $color;  
                ?>
                 
                    .page{
                        box-shadow: 0 0 5px -1px <?php echo $shadowcolor44 ?>;
                        -webkit-box-shadow: 0 0 5px -1px <?php echo $shadowcolor44 ?>;
                        -moz-box-shadow: 0 0 5px -1px <?php echo $shadowcolor44 ?>;
                        -ms-box-shadow: 0 0 5px -1px <?php echo $shadowcolor44 ?>;
                        -o-box-shadow: 0 0 5px -1px <?php echo $shadowcolor44 ?>;
                    }
                <?php } ?>              
            
        <?php } ?>
            
        <?php if($boxlayout == '2') { ?>
            <?php if($layoutwidth == 'custom'){ ?>
                .page,
                .navmain-container.fixed{max-width:<?php echo $customwidth;?>px;}
            <?php } else { ?>
                .page,
                .navmain-container.fixed{max-width:<?php echo $responsivewidth[$layoutwidth];?>px;}
            <?php } ?>
            
            .page {margin: 0 auto; width: 96%;}
            .container_12 {width: 100%;padding-left:0%; padding-right:0%;}
            
            <?php if(isset($cssValueArray['extra_settings']['boxlayout_bg'])) {  ?>
                .page,
                .section-line > *, .block .block-title strong span, .peercheckout-title h2{  background: <?php echo $cssValueArray['extra_settings']['boxlayout_bg'];?>;}
            <?php } ?>
        <?php } ?>
        
        
        <?php if(isset($cssValueArray['extra_settings']['input_color'])) {  ?>
                input.input-text, select, textarea, input.product-custom-option,
                .ui-editRangeSlider-inputValue
                {  color: <?php echo $cssValueArray['extra_settings']['input_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['extra_settings']['input_bg_color'])) {  ?>
                input.input-text, select, textarea, input.product-custom-option,
                .ui-editRangeSlider-inputValue
                {  background-color: <?php echo $cssValueArray['extra_settings']['input_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['extra_settings']['input_border_color'])) {  ?>
                input.input-text, select, textarea, input.product-custom-option,
                .ui-editRangeSlider-inputValue
                {  border-color: <?php echo $cssValueArray['extra_settings']['input_border_color'];?>;}
        <?php } ?>

        <?php if(isset($cssValueArray['extra_settings']['input_hoverfocus_color'])) {  ?>
                input.input-text:hover, select:hover, textarea:hover, input.input-text:focus, select:focus, textarea:focus,
                .ui-editRangeSlider-inputValue:hover, .ui-editRangeSlider-inputValue:focus
                {  color: <?php echo $cssValueArray['extra_settings']['input_hoverfocus_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['extra_settings']['input_hoverfocus_bg_color'])) {  ?>
                input.input-text:hover, select:hover, textarea:hover, input.input-text:focus, select:focus, textarea:focus,
                .ui-editRangeSlider-inputValue:hover, .ui-editRangeSlider-inputValue:focus
                {  background-color: <?php echo $cssValueArray['extra_settings']['input_hoverfocus_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['extra_settings']['input_hoverfocus_border_color'])) {  ?>
                input.input-text:hover, select:hover, textarea:hover, input.input-text:focus, select:focus, textarea:focus,
                .ui-editRangeSlider-inputValue:hover, .ui-editRangeSlider-inputValue:focus
                {  border-color: <?php echo $cssValueArray['extra_settings']['input_hoverfocus_border_color'];?>;}
        <?php } ?>        
        
        <?php if(isset($cssValueArray['extra_settings']['tooltip_bg_color'])) {  ?>
                .tooltip
                {  background-color: <?php echo $cssValueArray['extra_settings']['tooltip_bg_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['extra_settings']['tooltip_text_color'])) {  ?>
                .tooltip
                {  color: <?php echo $cssValueArray['extra_settings']['tooltip_text_color'];?>;}
        <?php } ?>
        
        <?php if(isset($cssValueArray['extra_settings']['tooltip_arrow_color'])) {  ?>
                .tooltip:after
                {  border-top-color: <?php echo $cssValueArray['extra_settings']['tooltip_arrow_color'];?>;}
        <?php } ?>        
        
        <?php if($cssSettingValueArray['extra_settings']['tooltip'] == '0'){ ?>
                .tooltip{display: none;}
        <?php } ?>        
        
/* Extra Settings Ends */



<?php if(Mage::helper("ExtraConfig")->is_mobile() == true) { ?>
        .cloud-zoom-lens,
        .cloud-zoom-big{display: none !important;}
        
        .shopping_cart .dropdown-menu,
        .quick-search .dropdown-menu,
        .wishlist .dropdown-menu,
        .currency .dropdown-menu,
        .language .dropdown-menu
        {visibility: inherit; opacity: 1;-moz-opacity: 1;
	filter: alpha(opacity=100);display:none;
	-webkit-transition: 		all 0s ease-in-out;
	-moz-transition: 		all 0s ease-in-out;
	-o-transition: 			all 0s ease-in-out;
	transition: 			all 0s ease-in-out;        
	-webkit-transform: 		translateY(0px);
	-moz-transform: 		translateY(0px);
	-o-transform: 			translateY(0px);
	-ms-transform: 			translateY(0px);
	transform: 			translateY(0px);        
        }
<?php } ?>
