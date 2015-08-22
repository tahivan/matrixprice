<?php

class Peerforest_Revolutionslider_Block_Adminhtml_Revolutionslider_Edit extends Mage_Adminhtml_Block_Widget_Form_Container
{
    public function __construct()
    {
        parent::__construct();
                 
        $this->_objectId = 'id';
        $this->_blockGroup = 'revolutionslider';
        $this->_controller = 'adminhtml_revolutionslider';
        
        $this->_updateButton('save', 'label', Mage::helper('revolutionslider')->__('Save Banner'));
        $this->_updateButton('delete', 'label', Mage::helper('revolutionslider')->__('Delete Banner'));
		
        $this->_addButton('saveandcontinue', array(
            'label'     => Mage::helper('adminhtml')->__('Save And Continue Edit'),
            'onclick'   => 'saveAndContinueEdit()',
            'class'     => 'save',
        ), -100);

        $script =
<<<EOD
            function saveAndContinueEdit(){
                editForm.submit($('edit_form').action+'back/edit/');
            }

            $('text').insert({before:'<a href="#add_caption" id="add_caption_btn">Add new caption to content</a>'});
            $('content').insert({after:'
            <div style="display:none">
            <table id="add_caption" cellspacing="10" cellpadding="0" bgcolor="#ffffff">
            <tr>
                <td colspan="2"><b>Add new caption to slide content</b></td>
            </tr>
            <tr>
                <td width="150" align="right">Caption text</td>
                <td>
                    <input type="text" id="data_text" style="width:310px" />
                </td>
            </tr>
            <tr>
                <td width="150" align="right">Styleing Captions</td>
                <td width="250">
                    <select id="styleing_captions">
                        <option value="">- none -</option>
                        <option value="xx_small_text">xx_small_text</option>
                        <option value="x_small_text">x_small_text</option>
			<option value="small_text">small_text</option>
                        <option value="medium_text">medium_text</option>
                        <option value="large_text">large_text</option>
                        <option value="x_large_text">x_large_text</option>
                        <option value="xx_large_text">xx_large_text</option>
                        <option value="very_large_text">very_large_text</option>
			<option value="extra_large_text">extra_large_text</option>
                        <option value="clr_white">clr_white</option>
			<option value="clr_black">clr_black</option>
                        <option value="clr_red">clr_red</option>
                        <option value="clr_orange">clr_orange</option>
			<option value="clr_blue">clr_blue</option>
			<option value="clr_green">clr_green</option>
			<option value="clr_lightblue">clr_lightblue</option>
			<option value="bg_white">bg_white</option>
			<option value="bg_black">bg_black</option>
			<option value="bg_red">bg_red</option>
			<option value="bg_orange">bg_orange</option>
			<option value="bg_blue">bg_blue</option>
			<option value="bg_green">bg_green</option>
			<option value="bg_lightblue">bg_lightblue</option>
                    </select>
		    <br/> <small>These are Styling classes.</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">Incoming Animations</td>
                <td width="250">
                    <select id="incoming_animation">
                        <option value="randomrotate">Fade in, Rotate from a Random position and Degree</option>
                        <option value="sft">Short from Top</option>
                        <option value="sfb">Short from Bottom</option>
                        <option value="sfr">Short from Right</option>
                        <option value="sfl">Short from Left</option>
                        <option value="lft">Long from Top</option>
                        <option value="lfb">Long from Bottom</option>
                        <option value="lfr">Long from Right</option>
                        <option value="lfl">Long from Left</option>
			<option value="skewfromleft">Skew from Left</option>
			<option value="skewfromright">Skew from Right</option>
			<option value="skewfromleftshort">Skew Short from Left</option>
			<option value="skewfromrightshort">Skew Short from Right</option>
			<option value="randomrotate">Fade in, Rotate from a Random position and Degree</option>
                        <option value="fade">Fading</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">Outgoing Animations</td>
                <td width="250">
                    <select id="outgoing_animation">
                        <option value="">- none -</option>
                        <option value="stt">Short to Top</option>
                        <option value="stb">Short to Bottom</option>
                        <option value="str">Short to Right</option>
                        <option value="stl">Short to Left</option>
                        <option value="ltt">Long to Top</option>
                        <option value="ltb">Long to Bottom</option>
                        <option value="ltr">Long to Right</option>
                        <option value="ltl">Long to Left</option>
                        <option value="skewtoleft">Skew to Left</option>
                        <option value="skewtoright">Skew to Right</option>
			<option value="skewtoleftshort">Skew Short to Left</option>
			<option value="skewtorightshort">Skew Short to Right</option>
			<option value="fadeout">fading</option>
			<option value="randomrotateout">Fade in, Rotate from a Random position and Degree</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-x</td>
                <td>
                    <input type="text" id="data_x" />
                    <br/> <small>Possible Values are "left", "center", "right", or any Value between -2500  and 2500.</small>
		    <br/> <small>If left/center/right is set, the caption will be siple aligned to the position.  Any other "number" will simple set the left position in px of tha caption. </small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-y</td>
                <td>
                    <input type="text" id="data_y" />
                    <br/> <small>Possible Values are "top", "center", "bottom", or any Value between -2500  and 2500. </small>
		    <br/> <small>If top/center/bottom is set, the caption will be siple aligned to the position.  Any other "number" will simple set the top position in px of tha caption. </small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-start</td>
                <td>
                    <input type="text" id="data_start_after" />
                    <br/> <small>The timepoint in millisecond when/at the Caption should move in to the slide.</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-end</td>
                <td>
                    <input type="text" id="data_end" />
                    <br/> <small>The timepoint in millisecond when/at the Caption should move out from the slide.</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-speed</td>
                <td>
                    <input type="text" id="data_speed" />
                    <br/> <small>The speed in milliseconds of the transition to move the Caption in the Slide at the defined  timepoint.</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-endspeed</td>
                <td>
                    <input type="text" id="data_end_speed" />
                    <br/> <small>The speed in milliseconds of the transition to move the Caption out from the Slide at the defined  timepoint.</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-easing</td>
                <td>
                    <select id="easing">
                        <option value="easeOutBack">easeOutBack</option>
                        <option value="easeInQuad">easeInQuad</option>
                        <option value="easeOutQuad">easeOutQuad</option>
                        <option value="easeInOutQuad">easeInOutQuad</option>
                        <option value="easeInCubic">easeInCubic</option>
                        <option value="easeOutCubic">easeOutCubic</option>
                        <option value="easeInOutCubic">easeInOutCubic</option>
                        <option value="easeInQuart">easeInQuart</option>
                        <option value="easeOutQuart">easeOutQuart</option>
                        <option value="easeInOutQuart">easeInOutQuart</option>
                        <option value="easeInQuint">easeInQuint</option>
                        <option value="easeOutQuint">easeOutQuint</option>
                        <option value="easeInOutQuint">easeInOutQuint</option>
                        <option value="easeInSine">easeInSine</option>
                        <option value="easeOutSine">easeOutSine</option>
                        <option value="easeInOutSine">easeInOutSine</option>
                        <option value="easeInExpo">easeInExpo</option>
                        <option value="easeOutExpo">easeOutExpo</option>
                        <option value="easeInOutExpo">easeInOutExpo</option>
                        <option value="easeInCirc">easeInCirc</option>
                        <option value="easeOutCirc">easeOutCirc</option>
                        <option value="easeInOutCirc">easeInOutCirc</option>
                        <option value="easeInElastic">easeInElastic</option>
                        <option value="easeOutElastic">easeOutElastic</option>
                        <option value="easeInOutElastic">easeInOutElastic</option>
                        <option value="easeInBack">easeInBack</option>
                        <option value="easeOutBack">easeOutBack</option>
                        <option value="easeInOutBack">easeInOutBack</option>
                        <option value="easeInBounce">easeInBounce</option>
                        <option value="easeOutBounce">easeOutBounce</option>
                        <option value="easeInOutBounce">easeInOutBounce</option>
                    </select>
                    <br/> <small>The Easing Art how the caption is moved in to the slide</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right">data-endeasing </td>
                <td>
                    <select id="end_easing">
                        <option value="">- none -</option>
                        <option value="easeOutBack">easeOutBack</option>
                        <option value="easeInQuad">easeInQuad</option>
                        <option value="easeOutQuad">easeOutQuad</option>
                        <option value="easeInOutQuad">easeInOutQuad</option>
                        <option value="easeInCubic">easeInCubic</option>
                        <option value="easeOutCubic">easeOutCubic</option>
                        <option value="easeInOutCubic">easeInOutCubic</option>
                        <option value="easeInQuart">easeInQuart</option>
                        <option value="easeOutQuart">easeOutQuart</option>
                        <option value="easeInOutQuart">easeInOutQuart</option>
                        <option value="easeInQuint">easeInQuint</option>
                        <option value="easeOutQuint">easeOutQuint</option>
                        <option value="easeInOutQuint">easeInOutQuint</option>
                        <option value="easeInSine">easeInSine</option>
                        <option value="easeOutSine">easeOutSine</option>
                        <option value="easeInOutSine">easeInOutSine</option>
                        <option value="easeInExpo">easeInExpo</option>
                        <option value="easeOutExpo">easeOutExpo</option>
                        <option value="easeInOutExpo">easeInOutExpo</option>
                        <option value="easeInCirc">easeInCirc</option>
                        <option value="easeOutCirc">easeOutCirc</option>
                        <option value="easeInOutCirc">easeInOutCirc</option>
                        <option value="easeInElastic">easeInElastic</option>
                        <option value="easeOutElastic">easeOutElastic</option>
                        <option value="easeInOutElastic">easeInOutElastic</option>
                        <option value="easeInBack">easeInBack</option>
                        <option value="easeOutBack">easeOutBack</option>
                        <option value="easeInOutBack">easeInOutBack</option>
                        <option value="easeInBounce">easeInBounce</option>
                        <option value="easeOutBounce">easeOutBounce</option>
                        <option value="easeInOutBounce">easeInOutBounce</option>
                    </select>
                    <br/><small>The Easing Art how the caption is moved out from the slide</small>
                </td>
            </tr>
            <tr>
                <td width="150" align="right"></td>
                <td>
                    <input type="button" id="add_caption_action" value="Add caption" />
                </td>
            </tr>
            </table>
            </div>
            '});

            jQuery(function($){

                $('#add_caption_btn').fancybox({
                    'titlePosition'		: 'inside',
                    'transitionIn'		: 'none',
                    'transitionOut'		: 'none',
					'onClosed'		: function() {}
				});

				$('#add_caption_action').click(function(){
					var css_class = 'caption';
					css_class += ' ' + $('#incoming_animation').val();
					if ( $('#outgoing_animation').val() != '' ) css_class += ' ' + $('#outgoing_animation').val();
					if ( $('#styleing_captions').val() != '' ) css_class += ' ' + $('#styleing_captions').val();

                    var params = '';
                    if ( $('#data_x').val() != '' ) params += ' data-x="' + $('#data_x').val() + '"';
                    if ( $('#data_y').val() != '' ) params += ' data-y="' + $('#data_y').val() + '"';
                    if ( $('#data_speed').val() != '' ) params += ' data-speed="' + $('#data_speed').val() + '"';
                    if ( $('#data_start_after').val() != '' ) params += ' data-start="' + $('#data_start_after').val() + '"';
                    if ( $('#easing').val() != '' ) params += ' data-easing="' + $('#easing').val() + '"';
                    if ( $('#data_end_speed').val() != '' ) params += ' data-endspeed="' + $('#data_end_speed').val() + '"';
                    if ( $('#data_end').val() != '' ) params += ' data-end="' + $('#data_end').val() + '"';
                    if ( $('#end_easing').val() != '' ) params += ' data-endeasing="' + $('#end_easing').val() + '"';

					$('#text').val( $('#text').val() + "\r\n\r\n" + '<div class="'+ css_class +'" '+params+'>'+ $('#data_text').val() +'</div>' );
					$.fancybox.close();
				});

            });

EOD;

        $this->_formScripts[] = str_replace(array("\r\n", "\r", "\n"), "", $script );
	
	Mage::app()->getLayout()->getBlock('head')->addItem('js_css', 'jquery/jquery.fancybox-1.3.4.css');  

    }

    public function getHeaderText()
    {
        if( Mage::registry('revolutionslider_data') && Mage::registry('revolutionslider_data')->getId() ) {
            return Mage::helper('revolutionslider')->__("Edit Banner '%s'", $this->htmlEscape(Mage::registry('revolutionslider_data')->getTitle()));
        } else {
            return Mage::helper('revolutionslider')->__('Add Banner');
        }
    }
}