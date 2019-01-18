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
      <p>
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

  // CreateTodoボタンが押されたら発火
  $('.js-form').submit(function(e) {
    e.preventDefault();  // submitによるフォームの送信を中止
    
    // テキストフィールドの中身を取得
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
      var html = buildHTML(data);  //返ってきたデータをbuildHTMLに渡す
      $('.mesgs').append(html);  //作成したhtmlをビューに追加
      textField.val('');  //テキストフィールドを空に
    })
    .fail(function() {
      alert('error')
    });
  });
});