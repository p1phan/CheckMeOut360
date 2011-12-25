$(document).ready(function() {
  if ($('#walls_start_controller') != undefined) {
    $('#register_button').click(function(obj){
      $('#main_page_header').hide();
      $('#registration_form').show();
    });
  
    $('#registration_cancel_button').click(function(obj){
      $('#main_page_header').show();
      $('#registration_form').hide();
      return false;
    });
  
    $("#new_post_button").click(function() {
      $("#new_post_button").hide();
      $("#new_post_form").show();
    });

    $("#posts_close_button").click(function() {
      $('#new_post #message_text_box').val("");
    });
  }
});