$(document).ready(function() {
  google.maps.event.addDomListener(window, 'load',  function() {
    /* now inside your initialise function */
    infowindow = new google.maps.InfoWindow({
    content: "holding..."
    });
  });
  init_google_map(default_lat, default_long);
  get_places_from_controller();
  drop();
});
