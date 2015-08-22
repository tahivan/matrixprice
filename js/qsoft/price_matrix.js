/**
 * Created by thainv on 8/13/2015.
 */
var matrixPrice = Class.create({
    /**
     * @desc    initialize
     *
     * @param   tblId
     */
    initialize: function (tblId) {
        this.tbl = $(tblId);
        this.instan = 'matrixPrice';
        this.widthClass = 'mtx_width_val';
        this.dropClass = 'mtx_drop_val';
        this.validateMess = 'Only allow positive integer number!';
    },

    /**
     * @desc    Add new row into matrix table
     *
     * @param   val
     */
    addRow: function (val) {
        var row = this.tbl.insertRow(this.tbl.rows.length), i;
        for (i = 0; i < this.tbl.rows[0].cells.length; i++) {
            this.createCell(row.insertCell(i), val);
        }
        this.updateTableInfo();
    },

    /**
     * @desc    Add new column into table
     *
     * @param   val
     */
    addCol: function (val) {
        for (var i = 0; i < this.tbl.rows.length; i++) {
            this.createCell(this.tbl.rows[i].insertCell(this.tbl.rows[i].cells.length), val);
        }
        this.updateTableInfo();
    },

    /**
     * @desc    Add DROP value if have into table
     *
     * @param   data
     */
    addDropValue: function (data) {
        var drops = data.split(",");
        if (drops.length > 0) {
            for (var i = 0; i < drops.length; i++) {
                this.addRow(drops[i]);
            }
        }
    },

    /**
     * @desc    Add WIDTH value if have into table
     *
     * @param   data
     */
    addWidthValue: function (data) {
        var widths = data.split(",");
        if (widths.length > 0) {
            for (var i = 0; i < widths.length; i++) {
                this.addCol(widths[i]);
            }
        }
    },

    /**
     * @desc    Add PRICE value if have into table
     *
     * @param   prices
     */
    addPriceValue: function (prices) {
        var arrPrices = prices.split(',');
        if (arrPrices.length > 0) {
            for (var i = 0; i < arrPrices.length; i++) {
                var val = arrPrices[i].split('.')[1];
                var pos = arrPrices[i].split('.')[0];
                if ($("mtx_price" + pos) != undefined)
                    $("mtx_price" + pos).setAttribute('value', val);
            }
        }
    },

    /**
     * @desc    Delete one row from table
     */
    delRow: function () {
        var lastRow = this.tbl.rows.length - 1;
        if (lastRow > 0)
            this.tbl.deleteRow(lastRow);
        this.updateTableInfo();
    },

    /**
     * @desc    Delete onde column from table
     */
    delCol: function () {
        var lastCol = this.tbl.rows[0].cells.length - 1, i;
        if (lastCol > 0)
            for (i = 0; i < this.tbl.rows.length; i++) {
                this.tbl.rows[i].deleteCell(lastCol);
            }
        this.updateTableInfo();
    },

    /**
     * @desc    Create table cell
     *
     * @param   cell
     * @param   val
     */
    createCell: function (cell, val) {
        var targetName = this.tbl.readAttribute('cellprefix') + '[' + cell.cellIndex + cell.parentNode.rowIndex + ']';
        var value = (val != undefined) ? val : '';
        if (cell.parentNode.rowIndex == '0') {
            this.createInputElm({
                data_class: 'width' + cell.cellIndex,
                class: this.widthClass,
                onkeyUp: this.instan + ".updateDWValue(event)",
                value: value
            }, cell);
        } else if (cell.cellIndex == '0') {
            this.createInputElm({
                data_class: 'drop' + cell.parentNode.rowIndex,
                class: this.dropClass,
                onkeyUp: this.instan + ".updateDWValue(event)",
                value: value
            }, cell);
        } else {
            this.createInputElm({
                type: 'hidden',
                name: targetName + '[width]',
                class: 'width' + cell.cellIndex + ' content_width'
            }, cell);

            this.createInputElm({
                type: 'hidden',
                name: targetName + '[drop]',
                class: 'drop' + cell.parentNode.rowIndex + ' content_drop'
            }, cell);

            this.createInputElm({
                name: targetName + '[price]',
                class: 'mtx_price_val',
                onkeypress: this.instan + ".isNumberKey(event)"
            }, cell);
            this.createInputElm({
                type: 'hidden',
                name: targetName + '[website_id]',
                value: '0'
            }, cell);
            this.createInputElm({
                type: 'hidden',
                name: targetName + '[cust_group]',
                value: '32000'
            }, cell);
        }
        this.updateDWValue();
    },

    /**
     * @desc    Validate value
     */
    validateValue: function () {
        var mp = this;
        $$("[onlynumber]").each(function (i) {
            Event.observe(i, 'keypress', mp.isNumberKey.bind(this));
        });
    },

    /**
     * @desc    Check char is a number when get from event
     *
     * @param   evt
     * @returns {boolean}
     */
    isNumberKey: function (evt) {
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            alert(this.validateMess);
            evt.stop();
            return false;
        }
        return true;
    },

    /**
     * @desc    Show information of table
     */
    updateTableInfo: function () {
        $('matrix_rows_info').update(this.tbl.rows.length - 1);
        $('matrix_columns_info').update(this.tbl.rows[0].cells.length - 1);
    },

    /**
     * @desc    Update drop and width value for cells of table follow drop column and width row
     *
     * @param   evt
     */
    updateDWValue: function (evt) {
        if (evt !== undefined) {
            if (isNaN(evt.target.value)) {
                alert(this.validateMess);
                evt.target.value = '';
            }
            var cla = evt.target.readAttribute('data_class');
            $$("." + cla).each(function (i) {
                i.setAttribute('value', evt.target.value);
            });
        } else {
            this.setElmValue(this.widthClass);
            this.setElmValue(this.dropClass);
        }
        this.createPriceId();
    },

    /**
     * @desc    Create id for price matrix input field
     */
    createPriceId: function () {
        $$('.mtx_price_val').each(function (i) {
            var drop = i.up('td').select('.content_drop')[0].value;
            var width = i.up('td').select('.content_width')[0].value;
            var targetId = "mtx_price" + drop + '_' + width;
            i.setAttribute('id', targetId);
        });
    },

    /**
     * @desc    Set attribute for element
     *
     * @param   clas
     */
    setElmValue: function (clas) {
        $$("." + clas).each(function (i) {
            if (i.value !== '') {
                var dataClass = i.readAttribute('data_class');
                if (dataClass !== undefined && dataClass !== '') {
                    $$("." + dataClass).each(function (j) {
                        j.setAttribute('value', i.value);
                    });
                }
            }
        });
    },

    /**
     * @desc    Create an input field
     *
     * @param   attribute
     * @param   cell
     * @returns {HTMLElement}
     */
    createInputElm: function (attribute, cell) {
        var elm = document.createElement('input');
        if (Object.getOwnPropertyNames(attribute).length !== 0) {
            for (var k in attribute) {
                elm.setAttribute(k, attribute[k]);
            }
        }
        if (cell !== undefined) {
            cell.appendChild(elm);
        }
        return elm;
    }
});


