<?php

class Peerforest_Revolutionslider_Block_Adminhtml_Revolutionslider_Grid extends Mage_Adminhtml_Block_Widget_Grid
{
  public function __construct()
  {
      parent::__construct();
      $this->setId('revolutionsliderGrid');
      $this->setDefaultSort('revolutionslider_id');
      $this->setDefaultDir('ASC');
      $this->setSaveParametersInSession(true);
  }

  protected function _prepareCollection()
  {
      $collection = Mage::getModel('revolutionslider/revolutionslider')->getCollection();
      $this->setCollection($collection);
      return parent::_prepareCollection();
  }

  protected function _prepareColumns()
  {
      $this->addColumn('revolutionslider_id', array(
          'header'    => Mage::helper('revolutionslider')->__('ID'),
          'align'     =>'right',
          'width'     => '50px',
          'index'     => 'revolutionslider_id',
      ));
	 $this->addColumn('filename',
	 array(
		'header'=> Mage::helper('revolutionslider')->__('Banner Image'),
		'type' => 'image',
		'width'     => '50px',
		'index' => 'filename',
		)); 

		
	  $this->addColumn('title', array(
          'header'    => Mage::helper('revolutionslider')->__('Title'),
          'align'     =>'left',
          'index'     => 'title',
      ));

	
	  
      $this->addColumn('content', array(
			'header'    => Mage::helper('revolutionslider')->__('Item Content'),
			'width'     => '150px',
			'index'     => 'content',
      ));
	  
	  $this->addColumn('sorting_order', array(
			'header'    => Mage::helper('revolutionslider')->__('Sorting Order'),
			'align'     =>'center',
			'width'     => '50px',
			'index'     => 'sorting_order',
      ));
	  
      $this->addColumn('status', array(
          'header'    => Mage::helper('revolutionslider')->__('Status'),
          'align'     => 'left',
          'width'     => '80px',
          'index'     => 'status',
          'type'      => 'options',
          'options'   => array(
              1 => 'Enabled',
              2 => 'Disabled',
          ),
      ));
	  
        $this->addColumn('action',
            array(
                'header'    =>  Mage::helper('revolutionslider')->__('Action'),
                'width'     => '100',
                'type'      => 'action',
                'getter'    => 'getId',
                'actions'   => array(
                    array(
                        'caption'   => Mage::helper('revolutionslider')->__('Edit'),
                        'url'       => array('base'=> '*/*/edit'),
                        'field'     => 'id'
                    )
                ),
                'filter'    => false,
                'sortable'  => false,
                'index'     => 'stores',
                'is_system' => true,
        ));
		
		$this->addExportType('*/*/exportCsv', Mage::helper('revolutionslider')->__('CSV'));
		$this->addExportType('*/*/exportXml', Mage::helper('revolutionslider')->__('XML'));
	  
      return parent::_prepareColumns();
  }

    protected function _prepareMassaction()
    {
        $this->setMassactionIdField('revolutionslider_id');
        $this->getMassactionBlock()->setFormFieldName('revolutionslider');

        $this->getMassactionBlock()->addItem('delete', array(
             'label'    => Mage::helper('revolutionslider')->__('Delete'),
             'url'      => $this->getUrl('*/*/massDelete'),
             'confirm'  => Mage::helper('revolutionslider')->__('Are you sure?')
        ));

        $statuses = Mage::getSingleton('revolutionslider/status')->getOptionArray();

        array_unshift($statuses, array('label'=>'', 'value'=>''));
        $this->getMassactionBlock()->addItem('status', array(
             'label'=> Mage::helper('revolutionslider')->__('Change status'),
             'url'  => $this->getUrl('*/*/massStatus', array('_current'=>true)),
             'additional' => array(
                    'visibility' => array(
                         'name' => 'status',
                         'type' => 'select',
                         'class' => 'required-entry',
                         'label' => Mage::helper('revolutionslider')->__('Status'),
                         'values' => $statuses
                     )
             )
        ));
        return $this;
    }

  public function getRowUrl($row)
  {
      return $this->getUrl('*/*/edit', array('id' => $row->getId()));
  }

}