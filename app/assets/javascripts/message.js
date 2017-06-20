$(function() {
  function buildHTML(message) {
    var name = '<p class="chat-screen__chat-area__message-name">'+ message.name +'</p>';
    var time = '<p class="chat-screen__chat-area__message-time">'+ message.time + '<p>';
    var body = '<p class ="chat-screen__chat-area__message">' + message.body +'</p>';
    if(message.image) {
      var image_tag = '<img src = "' + message.image + '">';
      var image = '<p class ="chat-screen__chat-area__image">' + image_tag +'</p>';
    } else {
      var image = '<p class ="chat-screen__chat-area__image"></p>';
    };
    $('.chat-screen__chat-area').append(name, time, body, image);
  };

  function build(message) {
    var insertImage = '';
    if (message.image) {
      insertImage = `<img src="${message.image}">`;
    }
    var html = `
        <p class="chat-screen__chat-area__message-name">${message.name}</p>
        <p class="chat-screen__chat-area__message-time">${message.date}</p>
        <p class="chat-screen__chat-area__message">${message.body}</p>
        <p class="chat-screen__chat-area__image">${insertImage}</p>`;
    return html
  }

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
    })
  });

  setInterval(function() {
      $.ajax({
        type: 'GET',
        url: location.href,
        processData: false,
        contentType: false,
        dataType: 'json'
      })
      .done(function(json) {
        var insertHTML = '';
        json.messages.forEach(function(message) {
          insertHTML += build(message);
        });
        $('.chat-screen__chat-area').html(insertHTML);
      })
      .fail(function(data) {
        alert('自動更新に失敗しました');
      });
  } , 5 * 1000 );
});
