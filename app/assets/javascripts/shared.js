$(document).ready(function() {
  
  // The About and Show Page
  $('#top_main_global_bar #about_page').click(function(obj){
    $('#main_nav_tab').hide();
    $.ajax({
      url: '/walls/about',
      type: 'get',
    });
  });
  
  $('#top_main_global_bar #contact_page').click(function(obj){
    $('#main_nav_tab').hide();
    $.ajax({
      url: '/walls/contact',
      type: 'get',
    });
  });
  
  $('#top_main_global_bar #help_page').click(function(obj){
    $('#main_nav_tab').hide();
    $.ajax({
      url: '/walls/help',
      type: 'get',
    });
  });

  // Main Nav-Tab Bar
  $('#main_nav_tab #wall_tab').click(function() {
    wall_id = $('#current_wall').text();
    $.ajax({
      url: '/walls/list',
      type: 'get',
      data: {id: wall_id},
    });
    
    $('li#li_for_wall').attr("class", "active");
    $('li#li_for_place').removeClass("active");
  });
  
  $('#main_nav_tab #place_tab').click(function() {
    wall_id = $('#current_wall').text();
    $.ajax({
      url: '/places/list',
      type: 'get',
      data: {id: wall_id},
    });
    
    $('li#li_for_place').attr("class", "active");
    $('li#li_for_wall').removeClass("active");
  });

  // Right Nav-Tab Bar
  $('#right_side_tab #places_link').click(function() {
    $('#list_of_users').hide();
    $('#list_of_places').show();
    $('li#places_list').attr("class", "active");
    $('li#users_list').removeClass("active");
  });
  
  $('#right_side_tab #users_link').click(function() {
    $('#list_of_places').hide();
    $('#list_of_users').show();
    $('li#users_list').attr("class", "active");
    $('li#places_list').removeClass("active");
  });
  
  

});