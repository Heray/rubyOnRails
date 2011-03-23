$('.schedule').jScrollPane({animateTo:false});
$(document).ready(
   function() {
   $('.schedule')[0].scrollTo(500);
   return false;
});

scroll_or_resize();
$(window).scroll(scroll_or_resize);
$(window).resize(scroll_or_resize);
var current_date = Date.today();
function current_date_str() {
    return current_date.toString('yyyy-M-d');
}

function perm_resize_update_when() {
}

function perm_drag_update_when() {
}

var resize_var = {
    grid:30.5, 
    minHeight:30.5, 
    minWidth:350,
    maxWidth:350,
    resize:perm_resize_update_when
};

var drag_var = {
    snap: ".half_hour_slot",
    axis: "y",
    drag:perm_drag_update_when
};


/* profile */
function scroll_or_resize(){
/*
    var db = $('.display_box');
    db.height($(window).height()-80);
    $('.left_half').height($(window).height()-120);
    //$('.schedule').jScrollPane({animateTo:false});
    $('.schedule').height($(window).height()-330);
*/

    var left = document.body.scrollLeft | window.pageXOffset;
    var calendar_bar_pos = $(".display_box").position().left + 5;
    var absolute_right_pos = $(".display_box").position().left + 476;
    $(".absolute_right").css("left",absolute_right_pos-left);
    $(".calendar_bar").css("left",calendar_bar_pos-left);
    
    $('.schedule').css("height", (window.innerHeight-100));

    
}

function close_popup_right_half() {
    $(".popup_right_half").hide();
    $(".filtered_events").hide();
    $(".add_event").hide();
    $(".event_detail").hide();
}


var edit = false;
var clicked_perm_event;
function perm_event_clicked() {
    close_popup_right_half();
    edit = true;
    clicked_perm_event = $(this);
    st = $(this).attr("start_time");
    et = $(this).attr("end_time");
    tt = $(this).attr("title");

    $("#ed_start_time").text(st);
    $("#ed_end_time").text(et);
    $("#ed_title").text(tt);

    $(".event_detail").show();
    $(".popup_right_half").show();

    filter_events(st, et, current_date_str());
}

function get_html_body(data) {

    var s = data.indexOf("<body>");
    var e = data.indexOf("</body>");
    var res =  data.substring(s+6, e);
    return res;
}

/* list events */
function refresh_event_list() {
    $.ajax( {
	type: "GET",
	url: "list_events",
	async: true,
	data:[{
	    name: "current_date",
	    value: current_date_str()
	}],
	success: function(data) {
	    var res = get_html_body(data);
	    $('.for_adding_events_block').html(res);

	    var peb = $('.perm_event_block');
	    peb.resizable(resize_var);
	    peb.draggable(drag_var);
	    peb.click(perm_event_clicked);

	}
    });

}

refresh_event_list();

$("#next_day").click(function() {
    current_date.addDays(1);
    refresh_event_list();
});

String.format = function() {
    var s = arguments[0];
    for (var i = 0; i < arguments.length - 1; i++) {
	var reg = new RegExp("\\{" + i + "\\}", "gm");
	s = s.replace(reg, arguments[i + 1]);
    }

    return s;
}

function resize_update_when(event, ui) {
    var obj = temp_eb_list[temp_eb_list.length-1]
    var top_pos = obj.position().top;
    var bottom_pos = top_pos+obj.height();
    var st_time = Math.floor(top_pos/30)/2;
    var ed_time = Math.floor(bottom_pos/30)/2;
    $('input[name*="add_start_time"]').val(st_time);
    $('input[name*="add_end_time"]').val(ed_time);
}

function drag_update_when(event, ui) {
    var obj = temp_eb_list[temp_eb_list.length-1]
    var st_time = Math.floor(obj.position().top/30)/2;
    
    var ed_time = st_time + Math.ceil(obj.height()/30)/2;
    $('input[name*="add_start_time"]').val(st_time);
    $('input[name*="add_end_time"]').val(ed_time);
}

var temp_eb_counter = 0;
var temp_eb_list = new Array();

var resize_var = {
    grid:30.5, 
    minHeight:30.5, 
    minWidth:350,
    maxWidth:350,
    resize:resize_update_when
};

var drag_var = {
    snap: ".half_hour_slot",
    axis: "y",
    drag:drag_update_when
};

function temp_add_event_block(id, st, ed) {
    if (temp_eb_list.length > 0) 
	temp_eb_list.pop().hide();

    var cond = 'div[half_slot="'+id+'"]';
    var div_str = '<div class="temp_event_block" eb_id="'
	+ temp_eb_counter  +'"></div>';
    $(cond).append(div_str);
    var this_eb = $( ".temp_event_block" );
    this_eb.resizable(resize_var);
    this_eb.draggable(drag_var);
    temp_eb_list.push(this_eb);


    temp_eb_counter ++;
}

function filter_events(st, et, cd) {
    //cd: current date

    $(".filtered_events").hide();
    var fields = {
	start_time: st,
	end_time: et,
	current_date: cd
    };
    var res = $.ajax( {
	type: "POST",
	url: "filter_events",
	async: false,
	data:fields
    }).responseText;
    $(".filtered_events").html(get_html_body(res));
    $(".filtered_events").show();

}

$(".half_hour_slot").click(function() {
    $(".add_event").hide();
    if (edit) {
	edit = false;
	
	return;
    }
    
    $(".event_detail").hide();
    var id = $(this).attr("half_slot");
    var st = parseFloat(id,10);
    var et = st+1;

    temp_add_event_block(id, st, et);

    $('input[name*="add_start_time"]').val(st);
    $('input[name*="add_end_time"]').val(et);
    $(".add_event").show();

    filter_events(st, et, current_date_str());
    
    $(".popup_right_half").show();


});

var event_detail_is_expand = true;
$(".event_detail_expand_shrink").click(function() {
    if (event_detail_is_expand) {
	$(".detail_info").show();
	event_detail_is_expand = false;
	$(this).text("shrink");
    }
    else {
	$(".detail_info").hide();
	$(this).text("expand");
	event_detail_is_expand = true;
    }
});

//TODO: not save for just using event ID. 
//      should check if it's the right user
var event_detail_is_edit = true;
$(".event_detail_edit_done").click(function() {
    if (event_detail_is_edit) {
	$(".show_basic_info").hide();
	$("#edit_title").val(clicked_perm_event.attr("title"));
	$("#edit_start_time").val(clicked_perm_event.attr("start_time"));
	$("#edit_end_time").val(clicked_perm_event.attr("end_time"));
	//more

	$(".edit_basic_info").show();
	$(this).text("done");
	event_detail_is_edit = false;
    }
    else {
	//save
	var fields = $(".edit_form").serializeArray();
	fields.push({
	    name: "perm_event_id",
	    value: clicked_perm_event.attr("perm_event_id")
	});
	var res = $.ajax( {
            type: "POST",
            url: "edit_event",
            async: false,
            data:fields,
	}).responseText;
	
	if (res=="OK") {
            alert(res);
	    $(".edit_basic_info").hide();
	    $(".show_basic_info").show();
	    $(this).text("change");
	    event_detail_is_edit = true;
	}
    }
    
});

$(".added_time_slot").click(function() {
    $(".add_event").hide();
    $(".event_detail").show();
});


var calendar_bar_pos = $(".display_box").position().left+5;
$(".calendar_bar").css("left",calendar_bar_pos);

/* add event */
$("#add_submit").button();
$("#add_submit").click(add_event_click);

var event_add_clicked = false;

function add_event_click() {
    if (event_add_clicked) return;
    event_add_clicked = true;
    var fields = $(".add_form").serializeArray();
    fields.push({
	name: "current_date",
	value: current_date_str()
    });
    var res = $.ajax( {
        type: "POST",
        url: "add_event",
        async: false,
        data:fields,
    }).responseText;
    
    if (res=="OK") {
        alert(res);
	event_add_clicked = false;
        $(".add_event").hide();
    }
};




