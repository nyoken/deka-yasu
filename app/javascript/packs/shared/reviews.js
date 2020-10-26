// [.syncer-acdn]にクリックイベントを設定する
$( '.reviews__op-cl' ).click( function(){
  // [data-target]の属性値を代入する
  var target = $( this ).data( 'target' );

  // [target]と同じ名前のIDを持つ要素に[slideToggle()]を実行する
  $( '#' + target ).slideToggle();
});
