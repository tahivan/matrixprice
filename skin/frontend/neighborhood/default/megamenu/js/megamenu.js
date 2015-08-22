function showMegamenu(obj, popupId){
    var leftMargin = 0;        
    var popupElementWidth;
    var popupParentElementOffsetLeft;
    var popupParentElementOffWidth;
    if (document.getElementById(popupId)) {
        popupParentElementOffsetLeft = document.getElementById(popupId).parentNode.offsetLeft;
        popupParentElementOffWidth = document.getElementById(popupId).parentNode.offsetWidth;
        popupElementWidth = document.getElementById(popupId).offsetWidth;
    }
    
    var rootNodeCount = 0;
    var rootNodeTotalWidth = 0;
    var currentNodeIndex = 0;
    var nodeMargin = true;   
    if (popupElementWidth < 1024){
        for (var i = 0; i < obj.parentNode.childNodes.length; i++) {	
            if (obj.parentNode.childNodes[i].nodeName == "LI") {
                rootNodeCount++;
                rootNodeTotalWidth += obj.parentNode.childNodes[i].getWidth();
                if (nodeMargin == true) {
                    leftMargin += obj.parentNode.childNodes[i].getWidth();            
                }
                if (obj === obj.parentNode.childNodes[i]) {
                    currentNodeIndex = i;
                    nodeMargin = false;
                }
            }                
        }    
        
        if (popupElementWidth >= rootNodeTotalWidth) {
            leftMargin = 0;
        }
        else
        {
            if (rootNodeCount % 2 != 0) {
                rootNodeCount += 1;
            }
            
            if (currentNodeIndex > (rootNodeCount/2)+1) { 
                leftMargin = Math.abs(popupParentElementOffsetLeft + popupParentElementOffWidth - popupElementWidth);                           
            }
            else if (currentNodeIndex < (rootNodeCount/2)) {
                leftMargin = Math.abs(popupParentElementOffsetLeft);            
            }
            else {
                leftMargin = Math.abs(popupParentElementOffsetLeft + popupParentElementOffWidth/2 - (popupElementWidth)/2);
            }    
        }

    }
    
    if (document.getElementById(popupId)) {
        document.getElementById(popupId).style.left = leftMargin + 'px';
    }
}