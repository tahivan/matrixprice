jQuery(function(j$) {
    j$('.ajx-cart').on('click', function () {
        if ( j$(window).width() < 769 )  {
            return false;
        }
        var cart = j$('.shopping_cart');
        var imgtodrag = j$(this).parents('div.item,li.item').find('a.product-image img:not(.back_img)').eq(0);
        if (imgtodrag) {
            var imgclone = imgtodrag.clone()
                .offset({ top:imgtodrag.offset().top, left:imgtodrag.offset().left })
                .css({'opacity':'0.5', 'position':'absolute', 'height':'150px', 'width':'150px', 'z-index':'1000'})
                .appendTo(j$('body'))
                .animate({
                    'top':cart.offset().top + 10,
                    'left':cart.offset().left + 30,
                    'width':55,
                    'height':55
                }, 1000, 'easeInOutExpo');
            imgclone.animate({'width':0, 'height':0}, function(){ j$(this).detach() });
        }
        return false;
    
    });
});
	
    jQuery.noConflict();
	jQuery(document).ready(function(){
		jQuery('.fancybox').fancybox(
			{
			   hideOnContentClick : true,
			   padding: 0,
			   width: 760,
			   //autoDimensions: true,
			   type : 'iframe',
			   //showTitle: false,
			   scrolling: 'no',
			   onComplete: function(){
				jQuery.fancybox.showActivity();	
				jQuery('#fancybox-frame').load(function() { // wait for frame to load and then gets it's height
					jQuery('#fancybox-content').height(jQuery(this).contents().find('body').height()+30);
					jQuery.fancybox.hideActivity();
					jQuery.fancybox.resize();
				 });
	
			   }
			}
		);
	});
	function showOptions(id){
		jQuery('#fancybox'+id).trigger('click');
	}
	function setAjaxData(data,iframe){
		if(data.status == 'ERROR'){
			alert(data.message);
		}else{
		    successMessage(data.message);
		    if(jQuery('.block-cart')){
			jQuery('.block-cart').replaceWith(data.sidebar);
		    }
		    if(jQuery('.header .links')){
			jQuery('.header .links').replaceWith(data.toplink);
		    }
		    jQuery.fancybox.close();
		}
	}
	function setLocationAjax(url,id){
		url += 'isAjax/1';
		url = url.replace("checkout/cart","ajax/index");
		jQuery('#ajax_loader'+id).show();
		try {
			jQuery.ajax( {
				url : url,
				dataType : 'json',
				success : function(data) {
					jQuery('#ajax_loader'+id).hide();
         			setAjaxData(data,false);           
				}
			});
		} catch (e) {
		}
	}
	function setAjaxData1(data,iframe){
		if(data.status == 'ERROR'){
			alert(data.message);
		}else{
		    successMessage(data.message);
		    if(jQuery('.block-cart')){
			jQuery('.block-cart').replaceWith(data.sidebar);
		    }
		    if(jQuery('.header .links')){
			jQuery('.header .links').replaceWith(data.toplink);
		    }
		    jQuery.fancybox.close();
		}
	}
	function setLocationAjax1(url,id){
		url += 'isAjax/1';
		url = url.replace("checkout/cart","ajax/index");
		jQuery('#ajax_loader1'+id).show();
		try {
			jQuery.ajax( {
				url : url,
				dataType : 'json',
				success : function(data) {
					jQuery('#ajax_loader1'+id).hide();
         			setAjaxData1(data,false);           
				}
			});
		} catch (e) {
		}
	}
	function setLocationAjax3(url,id){
	    url += '&isAjax=1';
	    url = url.replace("checkout/cart","ajax/index");
	    jQuery('#ajax_loader'+id).show();
	    try {
		jQuery.ajax( {
		    url : url,
		    dataType : 'json',
		    success : function(data) {
			
			jQuery('#ajax_loader'+id).hide();
		    successMessage(data.message);
		if(jQuery('.block-cart')){
		    jQuery('.block-cart').replaceWith(data.sidebar);
		}
		if(jQuery('.header .links')){
		    jQuery('.header .links').replaceWith(data.toplink);
		}
		    
				   
		    }
		});
	    } catch (e) {
	    }
	}