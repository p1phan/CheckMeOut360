$(document).ready(function() {

  $('#about_page').click(function(obj){
    $('#main_content').hide();
    $('#static_contact_page').hide();
    $('#static_about_page').show();
  });
  
  $('#contact_page').click(function(obj){
    $('#main_content').hide();
    $('#static_about_page').hide();
    $('#static_contact_page').show();
  });

});