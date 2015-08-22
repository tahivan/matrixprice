function preview(id) {
    var ele = document.getElementById(id).value;
    var url = location.href;
    var pathname = location.pathname;
    var index1 = url.indexOf(pathname);
    var index2 = url.indexOf("index.php", index1 + 1);    
    var baseLocalUrl = url.substr(0, index2);
    var previewUrl = baseLocalUrl+'media/preview/'+ele+'.png';
    window.open(previewUrl, '_blank');
}