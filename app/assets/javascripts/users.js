$(function() {
  //一致するユーザーがいた場合の処理
  function addUser(user) {
    let html = `
    <div class="chat-group-user clearfix">
      <p class="chat-group-user__name">${user.name}</p>
      <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}", data-user-name="${user.name}">追加</div>
    </div>
    `;
    //作ったhtmlを追加
    $("#user-search-result").append(html);
  }
//一致するユーザーがいなかった場合の処理
  function addNoUser() {
    let html = `
    <div class="chat-group-user clearfix">
      <p class="chat-group-user__name">一致するユーザーが見つかりません</p>
    </div>
    `;
    //作ったhtmlを追加
    $("#user-search-result").append(html);
  }

//削除ボタンが押された時の処理
  function addDeleteUser(name, id) {
    let html = `
    <div class="chat-group-user clearfix js-chat-member">
      <p class="chat-group-user__name">${name}</p>
      <a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id= "${id}" data-user-name="${name}">削除</a>
    </div>
    `;
    //作ったhtmlを追加
    $(".js-add-user").append(html);
  }

//ユーザーをグループに登録するための処理
  function addMember(userId) {
    let html = `
    <input name="group[user_ids][]" type="hidden"  value="${userId}" id="group_user_ids_${userId}" />`;
    $("#chat-group-users").append(html);
  }

  $("#user-search-field").on("keyup", function() {
    var input = $("#user-search-field").val();
    $.ajax({
      type: 'GET',
      url: '/users',
      data: { keyword: input },
      dataType: 'json'
    })
    //jbuilderファイルで作った配列を引数にしdone関数を起動
    .done(function(users){
      //if, elseのどの場合でも、処理後は、すでに検索欄に出力されている情報を削除する。
      $('#user-search-result').empty();
      //検索に一致するユーザーが0でない場合(いる場合)
      if (users.length !== 0) {
      //usersという配列をforEachで分解し、ユーザーごとにaddUser関数に飛ばす
        users.forEach(function(user) {
          addUser(user);
        });
      //入力欄に文字が入力されていない場合処理を終了
      } else if (input.length == 0) {
        return false;
      //検索に一致するユーザーがいない場合はaddNoUserに飛ばす
      } else {
        addNoUser();
      }
    })
    .fail(function(){
      alert("通信エラーです。ユーザーが表示できません。");
    });
  });

  $(document).on("click", '.chat-group-user__btn--add', function() {
    let userName = $(this).attr("data-user-name");
    let userId = $(this).attr("data-user-id");
    $(this).parent().remove();
    addDeleteUser(userName, userId);
    addMember(userId);
  });

  $(document).on("click", '.chat-group-user__btn--remove', function() {
    $(this)
      .parent()
      .remove();
  });
});