<?php
/**
 * Created by PhpStorm.
 * User: thainv
 * Date: 8/10/2015
 * Time: 3:18 PM
 */
/* @var $installer Mage_Catalog_Model_Resource_Setup */
$installer = $this;
$installer->startSetup();


/**
 * Create table 'qsoft_pricematrix/product_attribute_matrix_price'
 */
$matrixPriceTable = $installer->getTable('qsoft_pricematrix/product_attribute_matrix_price');
if ($installer->getConnection()->isTableExists($matrixPriceTable)) {
    $installer->getConnection()->dropTable($matrixPriceTable);
}

$table = $installer->getConnection()
    ->newTable($matrixPriceTable)
    ->addColumn('value_id', Varien_Db_Ddl_Table::TYPE_INTEGER, null, array(
        'identity' => true,
        'nullable' => false,
        'primary' => true,
    ), 'Value ID')
    ->addColumn('entity_id', Varien_Db_Ddl_Table::TYPE_INTEGER, null, array(
        'unsigned' => true,
        'nullable' => false,
        'default' => '0',
    ), 'Entity ID')
    ->addColumn('all_groups', Varien_Db_Ddl_Table::TYPE_SMALLINT, null, array(
        'unsigned' => true,
        'nullable' => false,
        'default' => '1',
    ), 'Is Applicable To All Customer Groups')
    ->addColumn('customer_group_id', Varien_Db_Ddl_Table::TYPE_SMALLINT, null, array(
        'unsigned' => true,
        'nullable' => false,
        'default' => '0',
    ), 'Customer Group ID')
    ->addColumn('drop', Varien_Db_Ddl_Table::TYPE_DECIMAL, '12,4', array(
        'nullable' => false,
        'default' => '0',
    ), 'DROP')
    ->addColumn('width', Varien_Db_Ddl_Table::TYPE_DECIMAL, '12,4', array(
        'nullable' => false,
        'default' => '0',
    ), 'WIDTH')
    ->addColumn('value', Varien_Db_Ddl_Table::TYPE_DECIMAL, '12,4', array(
        'nullable' => false,
        'default' => '0.0000',
    ), 'Value')
    ->addColumn('website_id', Varien_Db_Ddl_Table::TYPE_SMALLINT, null, array(
        'unsigned' => true,
        'nullable' => false,
    ), 'Website ID')
    ->addIndex(
        $installer->getIdxName(
            'qsoft_pricematrix/product_attribute_matrix_price',
            array('entity_id', 'all_groups', 'customer_group_id', 'drop', 'width', 'website_id'),
            Varien_Db_Adapter_Interface::INDEX_TYPE_UNIQUE
        ),
        array('entity_id', 'all_groups', 'customer_group_id', 'drop', 'width', 'website_id'),
        array('type' => Varien_Db_Adapter_Interface::INDEX_TYPE_UNIQUE))
    ->addIndex($installer->getIdxName('qsoft_pricematrix/product_attribute_matrix_price', array('entity_id')),
        array('entity_id'))
    ->addIndex($installer->getIdxName('qsoft_pricematrix/product_attribute_matrix_price', array('customer_group_id')),
        array('customer_group_id'))
    ->addIndex($installer->getIdxName('qsoft_pricematrix/product_attribute_matrix_price', array('website_id')),
        array('website_id'))
    ->addForeignKey(
        $installer->getFkName(
            'qsoft_pricematrix/product_attribute_matrix_price',
            'customer_group_id',
            'customer/customer_group',
            'customer_group_id'
        ),
        'customer_group_id', $installer->getTable('customer/customer_group'), 'customer_group_id',
        Varien_Db_Ddl_Table::ACTION_CASCADE, Varien_Db_Ddl_Table::ACTION_CASCADE)
    ->addForeignKey(
        $installer->getFkName(
            'qsoft_pricematrix/product_attribute_matrix_price',
            'entity_id',
            'catalog/product',
            'entity_id'
        ),
        'entity_id', $installer->getTable('catalog/product'), 'entity_id',
        Varien_Db_Ddl_Table::ACTION_CASCADE, Varien_Db_Ddl_Table::ACTION_CASCADE)
    ->addForeignKey(
        $installer->getFkName(
            'qsoft_pricematrix/product_attribute_matrix_price',
            'website_id',
            'core/website',
            'website_id'
        ),
        'website_id', $installer->getTable('core/website'), 'website_id',
        Varien_Db_Ddl_Table::ACTION_CASCADE, Varien_Db_Ddl_Table::ACTION_CASCADE)
    ->setComment('Catalog Product Matrix Price Attribute Backend Table');
$installer->getConnection()->createTable($table);

/**
 * Create attribute matrix_price for product
 */
$targetAttrCode = 'matrix_price';
$entityTypeId = 'catalog_product';
$matrixPriceAttribute = Mage::getResourceModel('catalog/eav_attribute')->loadByCode($entityTypeId, $targetAttrCode);

if ($matrixPriceAttribute->getId()) {
    $installer->removeAttribute($entityTypeId, $targetAttrCode);
}
$installer->addAttribute($entityTypeId, $targetAttrCode, array(
    'type' => 'decimal',
    'label' => 'Matrix Price',
    'input' => 'text',
    'backend' => 'qsoft_pricematrix/product_attribute_backend_matrixprice',
    'required' => false,
    'sort_order' => 100,
    'global' => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_WEBSITE,
    'apply_to' => 'simple',
    'group' => 'Prices',
));

/**
 * Create table qsoft_pricematrix/product_index_matrix_price
 */
$matrixPriceIndexTable = $installer->getTable('qsoft_pricematrix/product_index_matrix_price');
if ($installer->getConnection()->isTableExists($matrixPriceIndexTable)) {
    $installer->getConnection()->dropTable($matrixPriceIndexTable);
}
$table = $installer->getConnection()
    ->newTable($matrixPriceIndexTable)
    ->addColumn('entity_id', Varien_Db_Ddl_Table::TYPE_INTEGER, null, array(
        'unsigned' => true,
        'nullable' => false,
        'primary' => true,
    ), 'Entity ID')
    ->addColumn('customer_group_id', Varien_Db_Ddl_Table::TYPE_SMALLINT, null, array(
        'unsigned' => true,
        'nullable' => false,
        'primary' => true,
    ), 'Customer Group ID')
    ->addColumn('website_id', Varien_Db_Ddl_Table::TYPE_SMALLINT, null, array(
        'unsigned' => true,
        'nullable' => false,
        'primary' => true,
    ), 'Website ID')
    ->addColumn('min_price', Varien_Db_Ddl_Table::TYPE_DECIMAL, '12,4', array(), 'Min Price')
    ->addIndex($installer->getIdxName('qsoft_pricematrix/product_index_matrix_price', array('customer_group_id')),
        array('customer_group_id'))
    ->addIndex($installer->getIdxName('qsoft_pricematrix/product_index_matrix_price', array('website_id')),
        array('website_id'))
    ->addForeignKey(
        $installer->getFkName(
            'qsoft_pricematrix/product_index_matrix_price',
            'customer_group_id',
            'customer/customer_group',
            'customer_group_id'
        ),
        'customer_group_id', $installer->getTable('customer/customer_group'), 'customer_group_id',
        Varien_Db_Ddl_Table::ACTION_CASCADE, Varien_Db_Ddl_Table::ACTION_CASCADE)
    ->addForeignKey(
        $installer->getFkName(
            'qsoft_pricematrix/product_index_matrix_price',
            'entity_id',
            'catalog/product',
            'entity_id'
        ),
        'entity_id', $installer->getTable('catalog/product'), 'entity_id',
        Varien_Db_Ddl_Table::ACTION_CASCADE, Varien_Db_Ddl_Table::ACTION_CASCADE)
    ->addForeignKey(
        $installer->getFkName(
            'qsoft_pricematrix/product_index_matrix_price',
            'website_id',
            'core/website',
            'website_id'
        ),
        'website_id', $installer->getTable('core/website'), 'website_id',
        Varien_Db_Ddl_Table::ACTION_CASCADE, Varien_Db_Ddl_Table::ACTION_CASCADE)
    ->setComment('Catalog Product Matrix Price Index Table');
$installer->getConnection()->createTable($table);

$installer->endSetup();