<?php

/**
 * Magento
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@magentocommerce.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade Magento to newer
 * versions in the future. If you wish to customize Magento for your
 * needs please refer to http://www.magentocommerce.com for more information.
 *
 * @category    Mage
 * @package     Mage_Adminhtml
 * @copyright   Copyright (c) 2010 Magento Inc. (http://www.magentocommerce.com)
 * @license     http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */

/**
 * Used in creating options for Yes|No config value selection
 *
 */
class Peerforest_Revolutionslider_Model_System_Config_Swipevelocity
{

    /**
     * Options getter
     *
     * @return array
     */
    public function toOptionArray()
    {
        return array(
            array('value' => '0', 'label'=>Mage::helper('revolutionslider')->__('0')),
            array('value' => '0.1', 'label'=>Mage::helper('revolutionslider')->__('0.1')),
            array('value' => '0.2', 'label'=>Mage::helper('revolutionslider')->__('0.2')),
            array('value' => '0.3', 'label'=>Mage::helper('revolutionslider')->__('0.3')),
            array('value' => '0.4', 'label'=>Mage::helper('revolutionslider')->__('0.4')),
            array('value' => '0.5', 'label'=>Mage::helper('revolutionslider')->__('0.5')),
            array('value' => '0.6', 'label'=>Mage::helper('revolutionslider')->__('0.6')),
            array('value' => '0.7', 'label'=>Mage::helper('revolutionslider')->__('0.7')),
            array('value' => '0.8', 'label'=>Mage::helper('revolutionslider')->__('0.8')),
            array('value' => '0.9', 'label'=>Mage::helper('revolutionslider')->__('0.9')),
            array('value' => '1', 'label'=>Mage::helper('revolutionslider')->__('1')),
        );
    }
 
}
