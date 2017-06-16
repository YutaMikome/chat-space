$(function() {
  function buildHTML(message) {
    // var create_message = $(
      // '<div class="chat-screen__chat-area">' +
    var name = '<p class="chat-screen__chat-area__message-name">'+ message.name +'</p>';
    var time = '<p class="chat-screen__chat-area__message-time">'+ message.time + '<p>';
    var body = '<p class ="chat-screen__chat-area__message">' + message.body +'</p>';
    if(message.image) {
      var image_tag = '<img src = "' + message.image + '">';
      var image = '<p class ="chat-screen__chat-area__image">' + image_url +'</p>';
    } else {
      var image = '<p class ="chat-screen__chat-area__image"></p>';
    };
    $('.chat-screen__chat-area').append(name, time, body, image);
  };

  $('.message-form'). on('submit', function(e){
    e.preventDefault();
    e.stopPropagation();
    var $form = $('.message-form');
    var formData = new FormData ($(this).get(0));
    var url = $(this).attr("action");
    $.ajax ({
      type:'POST',
      url: url,
      data: formData,
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(message) {
      buildHTML(message);
      $form[0].reset();
      $('.chat-screen__chat-area').animate({scrollTop: $('.chat-screen__chat-area')[0].scrollHeight}, 'fast');
    })
    .fail(function() {
      alert('error');
    });
  });
});
