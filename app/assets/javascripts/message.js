$(function() {

  //todoのcontentをliタグでhtmlに追加
  function buildHTML(message) {
    var image = ""
    if (message.image != "") {
      image = `
        <div class="sent_msg__image">
          <img src="${message.image}" width="100" height="100">
        </div>
      `;
    }
    var html = `
    <div class="sent_msg">
      <p class="messages" data-id="${message.id}">
        ${message.content}
      </p>
      
      ${image}
      <span class="time_date">
        ${ message.user }
        ${ message.created_at }
      </span>
    </div>
    `;
    return html;
  }

  $(function(){
    // 10s ごとにメッセージを非同期で更新
    setInterval(update, 10000);
  });

  // 表示されている最後のメッセージIDの取得
  function getLastMessageID(){
    if($('.messages')[0])
      return $('.messages:last').data('id');
    else  
      return 0;
  }

  // 非同期でメッセージを自動更新
  function update(){
    var last_message_id = getLastMessageID();
    $.ajax({
      type: 'GET',
      url: window.location.href,
      data: {
        message: { id: last_message_id }
      },
      dataType: 'json',
    })
    .always(function(data) {
      addMessages(data);
    });
  }

  //返ってきたデータをhtml に付け加える
  function addMessages(data) {
    $.each(data, function(i, data){
      var html = buildHTML(data);  
      $('.mesgs').append(html);
    });
  };
  
  // 非同期でメッセージ送信
  $('.js-form').submit(function(e) {
    e.preventDefault();  // submitによるフォームの送信を中止
    
    var textField = $('.write_msg');
    var formdata = new FormData($(this).get(0));
    $.ajax({
      type: 'POST',
      url: window.location.href,
      data: formdata,
      dataType: 'json',
      contentType: false,
      processData: false,
      disabled: false
    })
    .done(function(data) {
      addMessages(data);
      textField.val(''); 
    })
    .fail(function() {
      alert('error')
    });
  });
});