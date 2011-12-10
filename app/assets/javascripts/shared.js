$(document).ready(function() {
  // $('.tabs').tabs();
  // // 
  // $('.tabs').bind('change', function (e) {
  //   console.log(e.target); // activated tab
  //   // e.relatedTarget // previous tab
  // })
  // // 
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