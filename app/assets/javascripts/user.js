// $(document).on('turbolinks:load', function(e){ //リロードしなくてもjsが動くようにする
$(function() {
  function memberHTML(user) {
    var users_name = '<li>' + '<div class="chat-group-user clearfix">' +
                      '<p class="chat-group-user__name">' + user.name + '</p>' +
                      '<a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="' + user.id +'" data-user-name="'+ user.name +'">追加</a>' + '</div>' + '</li>';
    return users_name;
  };

  function addMemberHTML(name, user_id) {
    var add_users = '<li>' + '<div class="chat-group-user clearfix js-chat-member" id="chat-group-user-8">' +
                      '<input name="group[user_ids][]" type="hidden" value="' + user_id + '">' +
                      '<p class="chat-group-user__name">' + name + '</p>' +
                      '<a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove" js-remove-btn">削除</a>' + '</div>' + '</li>';
    return add_users;
  }

  $(document).on('keyup', '#user-search-field', function(e){
    var input = $(this).val();
    $.ajax({
      url: '/users',
      type: 'GET',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(data){
      var $result = $('.user-search-result');
      $($result).children().remove();

      $(data).each(function(i, user){
        $($result).append(memberHTML(user));
      })
    })
    .fail(function() {
        alert("メッセージを入力してください。");
    });

    $(document).on('click', '.chat-group-user__btn--add', function(){
        $(this).parent().remove();

        var name = $(this).attr('data-user-name');
        var user_id = $(this).attr('data-user-id');
        $('.add-user--result').append(addMemberHTML(name, user_id));
    })

    $(document).on('click', '.chat-group-user__btn--remove', function(){
        $(this).parent().remove();
    });
  });
});
