CHECK_ME_OUT_360.users = {
  index_action: function() {
    var selected_privacy = $('#user_privacy :selected').attr("value");
    $('#privacy_description_block p#' + selected_privacy).css("background-color", "yellow");
  },
  show_action: function() {
    CHECK_ME_OUT_360.users.index_action();
    $('#myTab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });

    $('#new_link').click(function() {
      console.log('clicked');
      $("#myTab a:last").tab('show');
    });
  }
}