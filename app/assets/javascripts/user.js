// $(document).on('turbolinks:load', function(e){ //リロードしなくてもjsが動くようにする
$(function() {
  function buildHTML(user) {
    var users_name = '<div class="chat-group-user clearfix">' +
                    '<p class="chat-group-user__name">' + user.name + '<p>' +
                    '<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="' + user.id +'" data-user-name="'+ user.name +'">追加</a>' + '</div>';
    return users_name;
  };
  $(document).on('keyup', '#user-search-field', function(e){
    var input = $.trim($(this).val());
    $.ajax({
      url: '/users',
      type: 'GET',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(data){
      $('#user-search-result').find('li').remove();
      var $result = $('#user-search-result');
      $($result).find('hr').remove();

      $(data).each(function(i, user){
        $($result).append('<li>' + buildHTML(user) + '</li>');
      })
    })
    .fail(function() {
        alert("メッセージを入力してください。");
    });
  });
});
