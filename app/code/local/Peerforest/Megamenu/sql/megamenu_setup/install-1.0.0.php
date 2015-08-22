<?php
$this->startSetup();
$this->addAttribute('catalog_category', 'menutype', array(
    'group'             => 'Mega Menu',
    'note'	        => '(Works only for mega menu.)',
    'type'              => 'varchar',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Menu Type',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/menutype',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'topblock', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Top Block',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/blocklist',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'leftblock', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Left Block',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/blocklist',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'rightblock', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Right Block',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/blocklist',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'bottomblock', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Bottom Block',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/blocklist',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'leftblockWidth', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only.<br><b>example : 3 or 8</b><br>NOTE : Total of "Left Block", "Category Block Width" and "Right Block Width" must be equal to 12, not more or less than 12. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Left Block Width',
    'input'             => 'select',
    'class'             => '', 
    'source'            => 'megamenu/blockwidth',
    'global'            => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'    => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'rightblockWidth', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only.<br><b>example : 3 or 8</b><br>NOTE : Total of "Left Block", "Category Block Width" and "Right Block Width" must be equal to 12, not more or less than 12. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Right Block Width',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/blockwidth',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'centerBlockWidth', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only.<br><b>example : 3 or 8</b><br>NOTE : Total of "Left Block", "Category Block Width" and "Right Block Width" must be equal to 12, not more or less than 12. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Category Block Width',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/categoryblockwidth',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'totalColumnCategory', array(
    'group'             => 'Mega Menu',
    'type'              => 'varchar',
    'note'	        => 'This field is applicable for top-level categories only.<br><b>example : 3 or 8</b><br>NOTE : It should be between 1 and 12 only. (Works only for mega menu.)',
    'backend'           => '',
    'frontend_input'    => '',
    'frontend'          => '',
    'label'             => 'Total Column For Sub Category',
    'input'             => 'select',
    'class'             => '',
    'source'            => 'megamenu/categorycolumn',
    'global'             => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
    'visible'           => true,
    'frontend_class'     => '',
    'required'          => false,
    'user_defined'      => true,
    'default'           => '',
    'position'            => 100,//any number will do
));

$this->addAttribute('catalog_category', 'category_label', array(
    'group'         => 'Mega Menu',
    'input'         => 'text',
    'type'          => 'varchar',
    'label'         => 'Category Label',
    'backend'       => '',
    'visible'       => true,
    'required'      => false,
    'visible_on_front' => true,
    'note'	        => 'Add label for category. Example "New", "Hot", "Sale"',
    'global'        => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
));

$this->addAttribute('catalog_category', 'custom_block_position', array(
    'group'         => 'Mega Menu',
    'input'         => 'select',
    'source'        => 'megamenu/Customblockposition',
    'type'          => 'varchar',
    'label'         => 'Custom Block Position:',
    'backend'       => '',
    'visible'       => true,
    'required'      => false,
    'visible_on_front' => true,
    'note'	        => 'Set block position for category page.',
    'global'        => Mage_Catalog_Model_Resource_Eav_Attribute::SCOPE_STORE,
));

$this->endSetup();