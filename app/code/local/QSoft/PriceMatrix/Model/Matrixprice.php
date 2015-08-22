<?php

/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/21/2015
 * Time: 10:44 AM
 */
class QSoft_PriceMatrix_Model_Matrixprice extends Mage_Core_Model_Abstract
{
    protected function _construct()
    {
        $this->_init('qsoft_pricematrix/matrixprice');
    }

    public function getAvailableMeasure($prdId)
    {
        $measures = $drops = $widths = array();
        $collection = $this->getCollection()
            ->addFieldToFilter('`entity_id`', array('eq' => $prdId));
        foreach ($collection->getData() as $measure) {
            $drops[] = $measure['drop'];
            $widths[] = $measure['width'];
        }
        $measures['drop'] = array_unique($drops);
        $measures['width'] = array_unique($widths);
        return $measures;
    }
}