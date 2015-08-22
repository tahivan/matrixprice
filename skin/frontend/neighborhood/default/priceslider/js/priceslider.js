function getUrlParameter(url,searchParam,value)
{
    var searchPageURL = url.split('?');
    var searchURLVariables = 0;
    if (searchPageURL[1]) {
        var searchURLVariables = searchPageURL[1].split('&');
    }
    
    for(var i = 0; i < searchURLVariables.length; i++) 
    {
        var searchParameterName = searchURLVariables[i].split('=');
        if(searchParameterName[0] == searchParam) 
        {            
            searchURLVariables[i] = searchParameterName[0]+'='+value
            searchPageURL[1] = searchURLVariables.join('&');
            return searchPageURL.join('?');            
        }
    }
    if (searchURLVariables.length > 0) {
        return searchPageURL[0]+'?'+searchParam+'='+value+'&'+searchPageURL[1];
    }
    else
    {
        return searchPageURL[0]+'?'+searchParam+'='+value;
    }    
}

var check = true;
    function loadFilteredProduct(urllocation,loadMethod,inputType,clrCheck,sideBarStyle,addPriceToUrl){
        var catalogSearch = false;
        if (check){
            check = false;            
            var catalogSearchValue = '';
            if (sideBarStyle == 0) {
                var minValue = 0;
                var maxValue = 0;
                if (inputType == 'editRangeSlider') {                
                    minValue = j$("#priceslider").editRangeSlider("min");        
                    maxValue = parseInt(j$("#priceslider").editRangeSlider("max"))+1;                    
                }else
                {
                    minValue = j$("#priceslider").rangeSlider("min");        
                    maxValue = parseInt(j$("#priceslider").rangeSlider("max"))+1;                    
                }    
            }
               
            
            var url = urllocation;
            var clrAll = false;
                
            if (url.search("clr=1") != -1) {
                clrAll = true;    
            }
            if (clrAll == false && clrCheck == 0 && sideBarStyle == 0 && addPriceToUrl == 1) {
                url = getUrlParameter(urllocation,'price',minValue+'-'+maxValue);                        
            }            
            if (url.search("q=") || clrAll == false) {
                catalogSearch = true;
                if (!clrAll) {
                    catalogSearchValue = getParameterByName('q',window.location.href);
                    url = getUrlParameter(url,'q',catalogSearchValue);
                }
                else{
                    catalogSearchValue = getParameterByName('q',url);                    
                }                
            }
            if (loadMethod == 1) {
                try {
                    j$('#priceslider-loader').show();
                    j$.ajax( {
                        url : url,
                        dataType: 'json',
                        success : function(data) {
                            check = true;
                            if (clrAll == false  && sideBarStyle == 0) {
                                url = getUrlParameter(urllocation,'price',minValue+'-'+(maxValue-1));   
                            }
                            else if(clrAll == true){
                                url = url.replace('clr=1','clr=0');
                            }
                            if (catalogSearch == true && catalogSearchValue != '') {
                               url = getUrlParameter(url,'q',catalogSearchValue);
                            }                            
                            window.history.pushState('string', 'Title', getUrlParameter(url,'ajax',0));
                            j$('#priceslider-loader').hide();
                            if (data.status == 'success') {
                                j$('.block-layered-nav').empty();
                                j$('.block-layered-nav').replaceWith(data.blockLayeredNav);
                                j$('.category-products').empty();                        
                                j$('.category-products').replaceWith(data.products);                            
                            }
                        }
                    });
                } catch (e) {
                }
            }
            else
            {
                window.location.href = url;
            }
            return false;
        }
        return false;
    }
    
function getParameterByName(name, url) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(url);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}