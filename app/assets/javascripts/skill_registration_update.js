$(document).ready(function ($) {
  $('#tabs').tabulous();
});

$('#tab_button').click(function(){
  $('#tabs-1').removeClass('hidescale');
  $('#tabs-1').removeClass('showscale');
});

$('#tab_button1').click(function(){
  $('#tabs-2').css('top','0');
});

$('.add_qualification').click(function(){
  var len = $("#tbl_qualification").prop('rows').length;
  var value = len + 1
  var name = len
  var tag = '<tr class="tr_qualification"><td class="table_label">資格' + value + '</td><td class="text"><input class="form-control" type="text" name="qualification' + name + '" value=""></td></tr>>' +
  '<input type="hidden" name="qualification_id' + name +  '" value="' + value +  '" />' +
  '<input type="hidden" name="qualification_insert_update_flag' + name + '" value="0" />'
  $('#tbl_qualification').append(tag);

  $('#qualification_count').val(value);
});

function screentransition(id) {
  var url = "http://localhost:3000/userskills/new?category_id=" + id;
  window.location.href = url;
}
