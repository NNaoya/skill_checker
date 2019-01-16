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

function screentransition_toupdate(id) {
  var url = "http://localhost:3000/categories/update?category_id=" + id;
  window.location.href = url;
}

function screentransition_tonew() {
  var url = "http://localhost:3000/categories/new";
  window.location.href = url;
}
