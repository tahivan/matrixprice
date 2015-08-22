<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/20/2015
 * Time: 4:50 PM
 */
class QSoft_PriceMatrix_IndexController extends Mage_Core_Controller_Front_Action
{
    protected $_qty = '';
    protected $_unit = '';
    protected $_drop = 0;
    protected $_width = 0;
    protected $_dropOdd = 0;
    protected $_widthOdd = 0;
    protected $_productId = '';
    protected $_productOptions = '';

    protected $_model = null;
    protected $_availableMeasure = array();

    protected $_price;

    protected function _construct()
    {
        $this->_model = Mage::getModel('qsoft_pricematrix/matrixprice');

        parent::_construct();
    }

    public function calculateAction()
    {
        $this->_prepareParams();
        $this->getConfigPrice();
        $this->getResponse()->clearHeaders()->setHeader('Content-type', 'application/json', true);
        $this->getResponse()->setBody(Mage::helper('core')->jsonEncode(array('price' => $this->_price)));


    }

    /**
     * @desc Prepare parameters
     *
     * @return QSoft_PriceMatrix_IndexController
     */
    protected function _prepareParams()
    {
        $arrParams = $this->getRequest()->getParams();
        if (isset($arrParams['qty']) && $arrParams['qty'] != '') {
            $this->_qty = intval($arrParams['qty']);
        }
        if (isset($arrParams['unit']) && $arrParams['unit'] != '') {
            $this->_unit = (int)$arrParams['unit'];
        }
        if (isset($arrParams['drop']) && $arrParams['drop'] != '') {
            $this->_drop = (float)$arrParams['drop'];
        }
        if (isset($arrParams['width']) && $arrParams['width'] != '') {
            $this->_width = (float)$arrParams['width'];
        }
        if (isset($arrParams['drop_odd']) && $arrParams['drop_odd'] != '') {
            $this->_dropOdd = $arrParams['drop_odd'];
        }
        if (isset($arrParams['width_odd']) && $arrParams['width_odd'] != '') {
            $this->_widthOdd = $arrParams['width_odd'];
        }
        if (isset($arrParams['productId']) && $arrParams['productId'] != '') {
            $this->_productId = $arrParams['productId'];
        }
        if (isset($arrParams['product_opts']) && $arrParams['product_opts'] != '') {
            $this->_productOptions = $arrParams['product_opts'];
        }
        return $this->_formatMeasure();
    }

    /**
     * @desc Recalculate drop and width
     *
     * @return $this
     */
    protected function _formatMeasure()
    {
        if ($this->_unit == 1) {
            $this->_drop = (float)(2.54 * ($this->_drop + $this->_dropOdd));
            $this->_width = (float)(2.54 * ($this->_width + $this->_widthOdd));
        } else {
            $this->_drop += $this->_dropOdd;
            $this->_width += $this->_widthOdd;
        }
        $availableMeasure = $this->getListAvailableMeasure();
        if (!in_array($this->_drop, $availableMeasure['drop'])) {
            foreach ($availableMeasure['drop'] as $_drop) {
                if ((int)$_drop > $this->_drop) {
                    $this->_drop = $_drop;
                    break;
                }
            }
        }
        if (!in_array($this->_width, $availableMeasure['width'])) {
            foreach ($availableMeasure['width'] as $_width) {
                if ((int)$_width > $this->_width) {
                    $this->_width = $_width;
                    break;
                }
            }
        }

        return $this;
    }


    protected function getConfigPrice()
    {
        $targetPrice = '';
        try {
            $collection = Mage::getModel('qsoft_pricematrix/matrixprice')->getCollection()
                ->addFieldToFilter('`drop`', array('eq' => (string)$this->_drop))
                ->addFieldToFilter('`width`', array('eq' => (string)$this->_width))
                ->addFieldToFilter('`entity_id`', array('eq' => $this->_productId));
            foreach ($collection->getData() as $data) {
                $targetPrice = $data['value'];
            }
        } catch (Exception $e) {
            throw new Exception($e->getMessage());
        }
        $this->_price = $targetPrice;
        return $this;
    }

    protected function getListAvailableMeasure()
    {
        if (empty($this->_availableMeasure)) {
            $this->_availableMeasure = $this->_model->getAvailableMeasure($this->_productId);
        }
        return $this->_availableMeasure;
    }

}