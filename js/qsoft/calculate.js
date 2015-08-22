/**
 * Created by thainv on 8/20/2015.
 */
var calculatePrice = Class.create({
    initialize: function (id) {
        this.url = $(id).readAttribute('data_url');
        this.addMeasureOdd(0);
    },

    /**
     * Add odd number for drop and width
     *
     * @param unitType
     */
    addMeasureOdd: function (unitType) {
        var targetOpt = '';
        switch (unitType) {
            case 0:/*cm*/
                for (var i = 0; i <= 9; i++) {
                    if (i == 0) {
                        targetOpt += "<option selected='selected' value='0'>0</option>";

                    } else {
                        var cm = "0." + i;
                        targetOpt += '<option value="' + cm + '">' + cm + '</option>';
                    }
                }
                break;
            case 1:/*inch*/
                for (var j = 0; j <= 7; j++) {
                    if (j == 0) {
                        targetOpt += '<option selected="selected" value="0"></option>';
                    } else {
                        var inch = j / 8 * j;
                        targetOpt += '<option value="' + inch + '">' + inch + '</option>';
                    }
                }
                break;
        }
        $('measure_unit').value = unitType;
        $('drop_odd').update(targetOpt);
        $('width_odd').update(targetOpt);
    },

    validateMeasure: function () {
        if ($('measure_drop').value === '') {
            var mess = 'Drop cannot empty!';
            alert(mess);
            return false;
        }
        if ($('measure_width').value === '') {
            var mess = 'Width cannot empty!';
            alert(mess);
            return false;
        }
        return true;
    },

    calculatePrice: function () {
        this.collectData();
        if (this.validateMeasure()) {
            new Ajax.Request(this.url, {
                method: 'get',
                parameters: this.collectData(),
                onSuccess: function (transport) {
                    var obj = transport.responseText.evalJSON();
                    $('price_result').update(obj.price);
                }
            });
        }
    },

    collectData: function () {
        var params = {
            unit: $('measure_unit').value,
            drop: $('measure_drop').value,
            width: $('measure_width').value,
            drop_odd: $('drop_odd').value,
            width_odd: $('width_odd').value,
            qty: $('qty').value,
            productId: $('prd_id').value
        };
        return params;
    },
    checkInteger: function (obj) {
        var number = obj.value;
        number = number.replace(/\./g, '');
        number = number.replace(/-/g, '');
        number = number.replace(/\+/g, '');
        var additionExp = '101';
        if (parseInt(number + additionExp) != number + additionExp) {
            obj.value = number.substr(0, number.length - 1);
            if (number.length <= 1) {
                obj.value = "";
            }
            return false;
        }
        obj.value = number;
        return true;
    }
});