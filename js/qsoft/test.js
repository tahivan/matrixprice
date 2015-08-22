var _alertColor = "#FF3300";
var _noAlertColor = "";
function trim(data) {
    return data.replace(/^\s*/, "").replace(/\s*jQuery/, "");
}
function isBlank(mid) {
    var data = jQuery(mid).val().toString();
    if (data == '') return true;
    return false;
}
function isNotBlank(mid, msg) {
    var data = jQuery(mid).val().toString();
    if (trim(data) == '') {
        alert(msg);
        jQuery(mid).trigger('focus');
        return false;
    }
    return true;
}
function limitLength(mid, minlength, maxlength, msg) {
    var txt = jQuery(mid).val().toString();
    if (!(txt.length > minlength && txt.length < maxlength)) {
        alert(msg);
        jQuery(mid).trigger('focus');
        return false;
    }
    return true;
}
function rangeValidate(mid, lower, higher, msg) {
    if (!(jQuery(mid).val() > lower && jQuery(mid).val() < higher)) {
        alert(msg);
        jQuery(mid).trigger('focus');
        return false;
    }
    return true;
}
function isVisible(obj) {
    var bool = true;
    var ob = '#' + (jQuery(obj).attr('id').toString());
    jQuery(ob).parents().each(function () {
        var visible = trim(jQuery(this).css('display')).toUpperCase();
        if (visible == 'NONE') bool = false;
    });
    return bool;
}
function process_mandatoryonvalue(row, val, msg) {
    var myArr = row.split(':');
    var fieldsArr = myArr[0].split('#');
    var vval = myArr[1];
    val = trim(val);
    for (var i = 0; i < fieldsArr.length; i++) {
        fieldsArr[i] = trim(fieldsArr[i]);
        if (fieldsArr[i] != '') {
            var fieldid = '#' + fieldsArr[i];
            var fieldVal = jQuery(fieldid).val();
            if (isVisible(jQuery(fieldid)) != false && ( fieldVal == vval || (fieldVal == '' && vval == '_BLANK') || (fieldVal != '' && vval == '_NOTBLANK')
                )) {
                if (val == '') {
                    alert(msg);
                    return false;
                }
            }
        }
    }
    return true;
}
function checkAllMandatoryFields() {
    var bool = true;
    jQuery('*[mandatory]').each(function () {
        var val = trim(jQuery(this).val());
        if (val == '' && isVisible(this) != false) {
            var str = jQuery(this).attr('mandatory');
            alert(str + " is mandatory.");
            jQuery(this).trigger('focus');
            bool = false;
            return bool;
        }
    });
    if (bool == false) return bool;
    jQuery(':checkbox[mandatory]').each(function () {
        var val = jQuery(this).attr('checked');
        if (val == false && isVisible(this) != false) {
            var str = jQuery(this).attr('mandatory');
            alert(str + " is mandatory.");
            jQuery(this).trigger('focus');
            bool = false;
            return bool;
        }
    });
    if (bool == false) return bool;
    jQuery('*[mandatoryon]').each(function () {
        var val = trim(jQuery(this).val());
        var masterfield = jQuery(this).attr('mandatoryon').toString();
        var master = trim(jQuery(masterfield).val().toString());
        if (isVisible(this) == true) {
            if (master != '' && val == '') {
                var str = jQuery(this).attr('mandatoryonmsg');
                alert(str + " ");
                jQuery(this).trigger('focus');
                bool = false;
                return bool;
            }
            else {
                if (master == '' && val != '') {
                    jQuery(this).val('');
                }
            }
        }
    });
    if (bool == false) return bool;
    jQuery('*[mandatoryonvalue]').each(function () {
        var val = trim(jQuery(this).val().toString());
        var mandatoryString = trim(jQuery(this).attr('mandatoryonvalue').toString());
        var msg = trim(jQuery(this).attr('mandatoryonvaluemsg').toString());
        var mandatoryArray = mandatoryString.split(',');
        msg += " is mandatory.";
        for (var i = 0; i < mandatoryArray.length; i++) {
            if (process_mandatoryonvalue(trim(mandatoryArray[i]), val, msg) == false) {
                if (isVisible(this) == true)
                    jQuery(this).trigger('focus');
                bool = false;
                return bool;
            }
        }
    });
    if (bool == false) return bool;
    jQuery('*[onlyRegular]').each(function () {
        var val = trim(jQuery(this).val()).toUpperCase();
        var re = trim(jQuery(this).attr('onlyRegular').toString()).toUpperCase();
        if (isVisible(this) == true) {
            if (val.search(re) == -1 && val != '') {
                alert("Not a Valid Input!!");
                jQuery(this).trigger('focus');
                bool = false;
                return bool;
            }
        }
    });
    if (bool == false) return bool;
    jQuery('*[iscopyof]').each(function () {
        var verify = jQuery(this).val().toString();
        var masterfield = jQuery(this).attr('iscopyof').toString();
        var master = jQuery(masterfield).val().toString();
        if (isVisible(this) == true) {
            if (master != verify) {
                var str = jQuery(this).attr('iscopyofmsg');
                alert(str + " ");
                jQuery(this).trigger('focus');
                bool = false;
                return bool;
            }
        }
    });
    return bool;
}
function clearAndHide(mid) {
    var midArr = mid.split('#');
    for (var i = 0; i < midArr.length; i++) {
        if ((midArr[i])) {
            if (trim(midArr[i]) != '') {
                mid = '#' + trim(midArr[i]);
                jQuery(mid).find('input').each(function () {
                    jQuery(this).val('');
                    jQuery(this).trigger('change');
                });
                jQuery(mid).find('textarea').each(function () {
                    jQuery(this).val('');
                    jQuery(this).trigger('change');
                });
                jQuery(mid).find('select').each(function () {
                    jQuery(this).val('');
                    jQuery(this).trigger('change');
                });
                jQuery(mid).hide();
            }
        }
    }
}
jQuery(document).ready(function () {
    jQuery(':checkbox[showhide]').click(function () {
        jQuery(this).trigger('change');
    });
    jQuery(':checkbox[showhide]').change(function () {
        if (!(jQuery(this).attr('showhide'))) return true;
        var val = jQuery(this).attr('checked');
        var tmp = jQuery(this).attr('showhide').toString();
        var inputArr = tmp.split(',');
        var matched = 0;
        var defaultEntry = -1;
        for (var tx = 0; tx < inputArr.length; tx++) {
            var inputRow = inputArr[tx];
            var ret = shoHideEntryCheckBox(val, inputRow);
            if (ret == 1) matched += 1;
            if (ret == -1) defaultEntry = tx;
        }
        if (matched == 0 && defaultEntry > -1) {
            var inputRow = inputArr[defaultEntry];
            var ret = shoHideEntryCheckBox('_DEFAULT', inputRow);
        }
        return true;
    }).trigger('change');
    function shoHideEntryCheckBox(val, inputRow) {
        var matched = 0;
        var dataArr = inputRow.split(':');
        if (dataArr.length == 3) {
            var dataVal = trim(dataArr[0]);
            var data;
            var sho_hide = trim(dataArr[1]).toUpperCase();
            var mid = trim(dataArr[2]);
            if (dataVal == "_CHECKED") data = true;
            if (dataVal == "_UNCHECKED") data = false;
            if (val == data) {
                matched++;
                if (sho_hide == 'HIDE') {
                    clearAndHide(mid);
                }
                else {
                    if (sho_hide == 'SHOW') {
                        mid = mid.substring(1);
                        var mymidArr = mid.split('#');
                        var str = '#' + mymidArr.join(',#');
                        jQuery(str).show();
                    }
                }
            }
            else {
                if (data == '_DEFAULT') return -1;
            }
        }
        return matched;
    }

    jQuery('select[showhide]').change(function () {
        if (!(jQuery(this).attr('showhide'))) return true;
        var val = trim(jQuery(this).val().toString());
        var tmp = jQuery(this).attr('showhide').toString();
        var inputArr = tmp.split(',');
        var matched = 0;
        var defaultEntry = -1;
        for (var tx = 0; tx < inputArr.length; tx++) {
            var inputRow = inputArr[tx];
            var ret = shoHideEntry(val, inputRow);
            if (ret == 1) matched += 1;
            if (ret == -1) defaultEntry = tx;
        }
        if (matched == 0 && defaultEntry > -1) {
            var inputRow = inputArr[defaultEntry];
            var ret = shoHideEntry('_DEFAULT', inputRow);
        }
        return true;
    }).trigger('change');
    function shoHideEntry(val, inputRow) {
        var matched = 0;
        var dataArr = inputRow.split(':');
        if (dataArr.length == 3) {
            var data = trim(dataArr[0]);
            var sho_hide = trim(dataArr[1]).toUpperCase();
            var mid = trim(dataArr[2]);
            if (val == data || ( data == '_BLANK' && val == '')) {
                matched++;
                if (sho_hide == 'HIDE') {
                    clearAndHide(mid);
                }
                else {
                    if (sho_hide == 'SHOW') {
                        mid = mid.substring(1);
                        var mymidArr = mid.split('#');
                        var str = '#' + mymidArr.join(',#');
                        jQuery(str).show();
                    }
                }
            }
            else {
                if (data == '_DEFAULT') return -1;
            }
        }
        return matched;
    }

    jQuery('textarea[maxlength]').keyup(function () {
        var max = parseInt(jQuery(this).attr('maxlength'));
        var msgID = '';
        if (max == '') return true;
        if (jQuery(this).val().length > max) {
            jQuery(this).val(jQuery(this).val().substr(0, jQuery(this).attr('maxlength')));
        }
        if (jQuery(this).attr('msgID'))
            msgID = jQuery(this).attr('msgID').toString();
        if (msgID != '') {
            msgID = '#' + msgID;
            jQuery(msgID).html('(No more than <b>' + max + '</b> characters - <b>' + (max - jQuery(this).val().length) + '</b> left )');
            jQuery(msgID).css('color', _alertColor);
        }
    });
    jQuery('input[onlyNumeric]').keyup(function () {
        jQuery(this).css('background', _noAlertColor);
        var decimal = jQuery(this).attr('onlyNumeric');
        var msg = "Only Integer Values allowed (decimal point or any other characters not allowed).";
        var val = jQuery(this).val();
        var old_val = val;
        val = val.replace(/[0-9]*/g, "");
        if (decimal == 'd') {
            val = val.replace(/\./, "");
            msg = "Only Numeric Values allowed.";
        }
        if (val != '') {
            old_val = old_val.replace(/([^0-9].*)/g, "")
            jQuery(this).val(old_val);
            alert(msg);
        }
    });
    jQuery('input[onlyNumeric]').change(function () {
        var tval = trim(jQuery(this).val());
        if (tval == '') return true;
        reg = /^0*/;
        tval = tval.replace(reg, '')
        if (tval != '')
            val = parseInt(tval); else
            val = 0;
        var min = parseInt(jQuery(this).attr('min'));
        var max = parseInt(jQuery(this).attr('max'));
        var msg = "";
        if (min != '' && max != '') {
            msg = 'Input value should be in range of ' + min + ' to ' + max + '.';
        }
        else {
            if (min != '') {
                msg = 'Input value should be greter than or equal to' + min + '.';
            }
            else {
                if (max != '') {
                    msg = 'Input value should be less than or equal to ' + max + '.';
                }
            }
        }
        if (min != '') {
            if (min > val) {
                alert(msg);
                jQuery(this).val('');
                jQuery(this).css('background', _alertColor);
            }
        }
        if (max != '') {
            if (val > max) {
                alert(msg);
                jQuery(this).val('');
                jQuery(this).css('background', _alertColor);
            }
        }
    });
    jQuery('input[onlyEmail]').keyup(function () {
        jQuery(this).css('background', _noAlertColor);
    });
    jQuery('input[onlyEmail]').change(function () {
        str = (jQuery(this).val());
        var err = false;
        if (trim(str) == '') return true;
        var filter = /^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)jQuery)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?jQuery)/i;
        if (filter.test(str)) {
            err = false;
        }
        else {
            err = true;
        }
        if (err) {
            alert(str + ' is not a valid email address.');
            jQuery(this).val('');
            jQuery(this).css('background', _alertColor);
        }
    });
});