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
 * @category   Mage
 * @package    Mage_Catalog
 * @copyright  Copyright (c) 2008 Irubin Consulting Inc. DBA Varien (http://www.varien.com)
 * @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */

/**
 * Product gallery
 *
 * @category   Mage
 * @package    Mage_Catalog
 * @author      Josh Klina
 */
class Peerforest_ExtraConfig_Block_Product_Manufacturer extends Mage_Core_Block_Template
{
	public function getAllManu()     {
	$product = Mage::getModel('catalog/product');       
	$attributes = Mage::getResourceModel('eav/entity_attribute_collection')
	    ->setEntityTypeFilter($product->getResource()->getTypeId())
	    ->addFieldToFilter('attribute_code', 'manufacturer');
	$attribute = $attributes->getFirstItem()->setEntity($product->getResource());       
	$manufacturers = $attribute->getSource()->getAllOptions(false);
	$limit = Mage::getStoreConfig('mygeneral/home/brandlogolimit');
	 return array_slice($manufacturers, 0, $limit);
	 }
}
