// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require datatables.min
//= require moment
//= require bootstrap-datetimepicker    
//= require turbolinks
//= require_tree .
	
$(document).ready(function(){
    $(".spinner").hide();
    $('#objects-record').DataTable( {
        "serverSide": true,
        "processing": true,
        "jQueryUI": true,
        "pagingType": "full_numbers",
        "ajax": {
            url : $('#objects-record').data('source'),
            type: "get"
        }
    } );

    $('#datetimepicker1').datetimepicker({
        //("%Y-%m-%d %H:%M:%S %Z"),
        format: 'YYYY-MM-DD HH:mm:ss ZZ',
        sideBySide: true
    });

    $("#datetimepicker1").on("dp.change", function(e) {
        $("#timestamp").val( $('#datetimepicker1').data("DateTimePicker").date() );
    });


    $(document).on('submit','form#import-records',function(){
       $(".spinner").show();
    });

});