# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.spinner').hide()
  $('#objects-record').DataTable
    'serverSide': true
    'processing': true
    'jQueryUI': true
    'pagingType': 'full_numbers'
    'ajax':
      url: $('#objects-record').data('source')
      type: 'get'
  $('#datetimepicker1').datetimepicker
    format: 'YYYY-MM-DD HH:mm:ss ZZ'
    sideBySide: true
  $('#datetimepicker1').on 'dp.change', (e) ->
    $('#timestamp').val $('#datetimepicker1').data('DateTimePicker').date()
    return
  $(document).on 'submit', 'form#import-records', ->
    $('.spinner').show()
    return
  return