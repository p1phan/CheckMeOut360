$(document).ready(function() {
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
    $("#new_post_form").hide();
    $("#new_post_button").show();
  })
  
  $('#places_link').click(function() {
    $('#list_of_users').hide();
    $('#list_of_places').show();
    $('li#places_list').attr("class", "active");
    $('li#users_list').removeClass("active");
  });
  
  $('#users_link').click(function() {
    $('#list_of_places').hide();
    $('#list_of_users').show();
    $('li#users_list').attr("class", "active");
    $('li#places_list').removeClass("active");
  });
});