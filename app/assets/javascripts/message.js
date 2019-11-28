$(function(){
  function buildHTML(message){
    var content = message.content ? `${message.content}` : "";
    var image = message.image ? `<img src= "${message.image}">` : "";
    var html = `
          <div class="message" data-id="${message.id}">
            <div class="message__upper-info">
              <p class="message__upper-info__talker">
                ${message.user_name}
              </p>
              <p class="message__upper-info__date">
                ${message.date}
              </p>
            </div>
            <p class="message__text">
              ${content}
            </p>
            <div class="image">
              ${image}
            </div>
          </div>
          `
    return html;
  }
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type:"POST",
      data: formData,
      dataType:'json',
      processData:false,
      contentType: false
    })
    .done(function(data){

      var html = buildHTML(data);
      $('.messages').append(html);
      $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast'); 
      $('form')[0].reset();
      $('.submit-btn').prop('disabled', false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    })
  })
  
  var reloadMessages = function(){
    var last_message_id = $('.message:last').data("id");
    $.ajax({ //ajax通信で以下のことを行う
      url: './api/messages',
      type: 'GET',
      dataType: 'json', 
      data: {id: last_message_id}
    })
    .done(function(messages) {
      var insertHTML = '';
      messages.forEach(function(message){
        insertHTML = buildHTML(message);
        $('.messages').append(insertHTML);
        $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast'); 
      })

    })
    .fail(function() {
      alert('error');
    });
  };
  setInterval(reloadMessages, 7000);
});
