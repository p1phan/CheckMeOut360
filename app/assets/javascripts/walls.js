$(document).ready(function() {
  // if ($('#walls_start_controller').length > 0) {
    $('#news_feed_button').click(function(obj){
      $('#main_page_header').hide();
      $('#news_feed').show();
    });
  
    $('#close_news_feed_button').click(function(obj){
      $('#main_page_header').show();
      $('#news_feed').hide();
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