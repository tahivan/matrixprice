<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/11/2015
 * Time: 2:35 PM
 */

define('UND', '_');
define('DOT', '.');

class QSoft_PriceMatrix_Block_Adminhtml_Catalog_Product_Edit_Tab_Price_Matrix extends
    Mage_Adminhtml_Block_Catalog_Product_Edit_Tab_Price_Group_Abstract
{
    protected $_buttons = array();
    protected $_configValues = array();

    /**
     * Initialize block
     */
    public function __construct()
    {
        $this->setTemplate('catalog/product/edit/price/matrix.phtml');
        $this->_buttons = array(
            'add_row' => 'addRow',
            'add_column' => 'addCol',
            'delete_row' => 'delRow',
            'delete_column' => 'delCol',
        );

    }

    /**
     * Prepare global layout
     * Add "Add matrix rows" button to layout
     *
     * @return QSoft_PriceMatrix_Block_Adminhtml_Catalog_Product_Edit_Tab_Price_Matrix
     */
    protected function _prepareLayout()
    {
        $this->prepareButton();
        return parent::_prepareLayout();
    }

    protected function prepareButton()
    {
        foreach ($this->_buttons as $als => $act) {
            $button = $this->getLayout()->createBlock('adminhtml/widget_button')
                ->setData(array(
                    'label' => Mage::helper('catalog')->__(ucfirst(str_replace('_', ' ', $als))),
                    'onclick' => "return matrixPrice." . $act . "();",
                    'class' => substr($als, 0, strpos($als, '_')) . ' matrix_action'
                ));
            $this->setChild($als, $button);
        }
    }

    protected function getButtonsHtml()
    {
        foreach ($this->_buttons as $k => $v) {
            echo $this->getChildHtml($k);
        }
    }

    public function getConfigValues()
    {
        if (empty($this->_configValues)) {
            $this->_configValues = $this->getValues();
        }
        return $this->_configValues;
    }

    public function getConfig($type, &$prices = '')
    {
        $result = $arrPrice = array();
        foreach ($this->getConfigValues() as $v) {
            $result[] = (int)$v[$type];
            $arrPrice[] = (int)$v['drop'] . UND . (int)$v['width'] . DOT . (int)$v['price'];
        }
        $prices = implode(',', array_unique($arrPrice));
        return implode(',', array_unique($result));
    }
}