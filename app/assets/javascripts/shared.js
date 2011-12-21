$(document).ready(function() {
  
  // The About and Show Page
  $('#about_page').click(function(obj){
    $('.main_content').hide();
    $('#static_contact_page').hide();
    $('#static_about_page').show();
  });
  
  $('#contact_page').click(function(obj){
    $('.main_content').hide();
    $('#static_about_page').hide();
    $('#static_contact_page').show();
  });

  // Main Nav-Tab Bar
  $('#wall_tab').click(function() {
    $('li#li_for_wall').attr("class", "active");
    $('li#li_for_place').removeClass("active");
  });
  
  $('#place_tab').click(function() {
    $('li#li_for_place').attr("class", "active");
    $('li#li_for_wall').removeClass("active");
  });

  // Right Nav-Tab Bar
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