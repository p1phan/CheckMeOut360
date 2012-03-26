$(document).ready(function() {
  /* initialize google maps and place markers */
  google.maps.event.addDomListener(window, 'load',  function() {
    infowindow = new google.maps.InfoWindow({
    content: "holding..."
    });
  });
  var map = init_google_map(default_lat, default_long);
  get_places_from_controller();
  drop(map);
  
  /* setting checkin block heights */
  /* link up the places, checkins and gallery buttons */
  $('#profile_place_button').addClass('active');
  
  $('#profile_place_button').click(function() {
    setTimeout("var map = init_google_map(default_lat, default_long);get_places_from_controller();drop(map);",500);
    $('#profiles_checkins').hide();
    $('#profile_places').show();
    $('#profile_checkin_button').removeClass('active');
    $('#profile_place_button').addClass('active');
  });
  
  $('#profile_checkin_button').click(function() {
    $('#profile_places').hide();
    $('#profiles_checkins').show();
    $('#profile_place_button').removeClass('active');
    $('#profile_checkin_button').addClass('active');
    resize_block();
    $(window).resize(function() {
      resize_block();
    });
  });
  clearTimeout(0);
});

function resize_block() {
  $('.center_block').each(function(index, obj) {
    var mini = $(obj).children('.mini-hero-unit');
    var sub = $(obj).children('.sub-hero-unit');
    $(mini).height(sub.height());
  });
}