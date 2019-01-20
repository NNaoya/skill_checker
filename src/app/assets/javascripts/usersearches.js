$('#category_id').change(function(){
  var input = $('#category_id').val();

  // ajax通信
  $.ajax({
    url: '/usersearches/search',
    type: 'GET',
    data: ('category=' + input),
    processData: false,
    contentType: false,
    dataType: 'json'
  })

  // ajax通信に成功した場合
  .done(function(data){
    $('select#skill_id option').remove();
    $(data).each(function(i, user){
      $('select#skill_id').append('<option value="' + user.id + '">' + user.skill + '</option>')
    });
  })

});
