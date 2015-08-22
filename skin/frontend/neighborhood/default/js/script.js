var isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};



/* back to top */
j$(document).ready(function(){ 
 
        j$(window).scroll(function(){
            if (j$(this).scrollTop() > 100) {
                j$('.scrollup').fadeIn();
            } else {
                j$('.scrollup').fadeOut();
            }
        }); 
 
        j$('.scrollup').click(function(){
            j$("html, body").animate({ scrollTop: 0 }, 600);
            return false;
        });
 
    });
/* end back to top */

/* menu responsive */
var ww = j$(window).width();

j$(document).ready(function() {
  j$("#nav li a").each(function() {
    if (j$(this).next().length > 0) {
    	j$(this).addClass("parent");
		};
	})
	
	j$(".toggleMenu").click(function(e) {
		e.preventDefault();
		j$(this).toggleClass("active");
		j$("#nav").toggle();
	});
	adjustMenu();
})

j$(window).bind('resize orientationchange', function() {
	ww = j$(window).width();
	adjustMenu();
});

var adjustMenu = function() {
	if (ww <= 1041) {
    // if "more" link not in DOM, add it
    if (!j$(".more")[0]) {
    j$('<div class="more">&nbsp;</div>').insertBefore(j$('li a.parent')); 
    }
		j$(".toggleMenu").css("display", "inline-block");
		j$("#nav").addClass("color");
		if (!j$(".toggleMenu").hasClass("active")) {
			j$("#nav").hide();
		} else {
			j$("#nav").show();
		}
		j$("#nav li").unbind('mouseenter mouseleave');
		j$("#nav li a.parent").unbind('click');
    j$("#nav li .more").unbind('click').bind('click', function() {
			
			j$(this).parent("li").toggleClass("hover");
		});
	} 
	else if (ww >= 1042) {
    // remove .more link in desktop view
    j$('.more').remove(); 
		j$(".toggleMenu").css("display", "none");
		j$("#nav").removeClass("color");
		j$("#nav").show();
		j$("#nav li").removeClass("hover");
		j$("#nav li a").unbind('click');
		j$("#nav li").unbind('mouseenter mouseleave').bind('mouseenter mouseleave', function() {
		 	// must be attached to li so that mouseleave is not triggered when hover over submenu
		 	j$(this).toggleClass('hover');
		});
	}
}
/* end menu responsive */

jQuery(function(j$) {
    
function equalizeHeights(selector) {
	var heights = new Array();

	// Loop to get all element heights
	j$(selector).each(function() {

		// Need to let sizes be whatever they want so no overflow on resize
		j$(this).css('min-height', '0');
		j$(this).css('max-height', 'none');
		j$(this).css('height', 'auto');

		// Then add size (no units) to array
		heights.push(j$(this).height());
	});

	// Find max height of all elements
	var max = Math.max.apply( Math, heights );

	// Set all heights to max height
	j$(selector).each(function() {
		j$(this).css('height', max + 'px');
	});	
}

j$(window).load(function() {
	// Fix heights on page load
	equalizeHeights('.equal-height .item');

	// Fix heights on window resize
	j$(window).resize(function() {

		// Needs to be a timeout function so it doesn't fire every ms of resize
		setTimeout(function() {
		equalizeHeights('.equal-height .item');
		}, 120);
	});
});

j$(document).on('click', ".opener", function () {    
     
    var ele = j$(this).parent('.accordion');   
    
    if (j$(ele).hasClass("active")) {
	j$(ele).removeClass('active');
	j$(ele).find(".block-content").slideUp(400);
    }
    else {
	j$(ele).addClass('active');	
	j$(ele).find(".block-content").slideDown(400);
    }
});

j$(document).on('click', ".quantity", function () {    
     
    var ele = j$(this).data('qty');    
    var eleChild = j$(this).parent('.quantity_counter').find(".qty-value");
    var currentVal = parseInt(j$(eleChild).val());
    
    if (ele == "prev") { if (currentVal > 0) { currentVal = currentVal - 1; } else { currentVal = 0; } }    
    if (ele == "next") { if (currentVal < 0) { currentVal = 0; } else { currentVal = currentVal + 1; } }
    j$(eleChild).val(currentVal);
});

//j$(document).ready(function(){
//   j$(".products-grid").mouseover(function(){
//    var listItems = j$(".products-grid").children();
//    listItems.each(function(){
//	    j$(this).mouseover(function(){
//		var marginBottom = 0;
//		var targetClass = j$(this).children().find('.product-content-wrapper');
//		
//		j$(".actions.display-onhover",this).map(function () {
//		    marginBottom = marginBottom + parseInt(j$(this).outerHeight());
//		});
//		
//		if (marginBottom > 0) {
//		    j$(this).css('margin-bottom','-'+marginBottom+'px');
//		}    
//	    });
//	    j$(this).mouseout(function(){
//		j$(this).removeAttr('style');
//	    });
//	});    
//    }); 
//});

if (isMobile.any()){
	j$(".shopping_cart.dropdown").click(function () {
	   //j$('.shopping_cart.dropdown').toggleClass('active');
	   j$('.shopping_cart .dropdown-menu').slideToggle();
	});
	j$(".quick-search.dropdown").click(function () {
	   //j$('.limiter .dropdown').toggleClass('active');
	   j$('.quick-search .dropdown-menu').slideToggle();
	});
	j$(".wishlist.dropdown").click(function () {
	   //j$('.limiter .dropdown').toggleClass('active');
	   j$('.wishlist .dropdown-menu').slideToggle();
	});
	j$(".currency.dropdown").click(function () {
	   //j$('.limiter .dropdown').toggleClass('active');
	   j$('.currency .dropdown-menu').slideToggle();
	});
	j$(".language.dropdown").click(function () {
	   //j$('.limiter .dropdown').toggleClass('active');
	   j$('.language .dropdown-menu').slideToggle();
	});
}

});


var ie = (function(){
  
    var undef,
        v = 3,
        div = document.createElement('div'),
        all = div.getElementsByTagName('i');
  
    do {
        div.innerHTML = '<!--[if gt IE ' + (++v) 
        + ']><i></i><![endif]-->'; 
    } while(all[0]);
    /*@cc_on;if(v<5)v=10;@*/
    return v > 4 ? v : undef ;
  
}());


/* Mega Mobile Menu Script */
j$(document).ready(function(){   
    j$('#cssmenu ul ul li:odd').addClass('odd');
    j$('#cssmenu ul ul li:even').addClass('even');
    
    j$('#cssmenu > ul > li > a').click(function() {
    var checkElement = j$(this).next();
  
    j$('#cssmenu li').removeClass('active');
    j$(this).closest('li').addClass('active'); 
  
    if((checkElement.is('ul')) && (checkElement.is(':visible'))) {
      j$(this).closest('li').removeClass('active');
      checkElement.slideToggle(400);
    }
    if((checkElement.is('ul')) && (!checkElement.is(':visible'))) {
      j$('#cssmenu ul ul:visible').slideToggle(400);
      checkElement.slideToggle(400);
    }
  });
});

function mobileMenu(obj,id){
    if (j$(obj).hasClass('active')) {
        j$(obj).removeClass('active')
    }
    else{
        j$(obj).addClass('active')
    }
    j$('#'+id).slideToggle(400);
}

