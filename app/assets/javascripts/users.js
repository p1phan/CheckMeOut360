CHECK_ME_OUT_360.users = {
  index_action: function() {
    var selected_privacy = $('#user_privacy :selected').attr("value");
    $('#privacy_description_block p#' + selected_privacy).css("background-color", "yellow");
  },
  show_action: function() {CHECK_ME_OUT_360.users.index_action(); }
}