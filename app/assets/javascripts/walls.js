$(document).ready(function() {
  // if ($('#walls_start_controller').length > 0) {
    $('#news_feed_button').click(function(obj){
      $('#news_feed').slideDown('slow');
    });
  
    $('#close_news_feed_button').click(function(obj){
      $('#news_feed').slideUp('slow');
      return false;
    });
  
    $("#new_post_button").click(function() {
      $("#new_post_button").hide();
      $("#new_post_form").show();
    });

    $("#posts_close_button").click(function() {
      $('#new_post #message_text_box').val("");
    });
  // }
});