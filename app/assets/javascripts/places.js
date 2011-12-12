var map;
var places_lat_long_array;
var marker;

$(document).ready(function() {
  google.maps.event.addDomListener(window, 'load',  function() {
    init_google_map();
    place_set_of_markers();
  });
});

function init_google_map() {
  var latlng = new google.maps.LatLng(32.813933, -117.1628362);
  var myOptions = {
    zoom: 11,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
}

function populate_lat_long(lat, lon) {
  // Needed to round off the lat long in the display to make it fit into box
  $("#place_lat_show").text(parseFloat(lat).toFixed(8));
  $("#place_long_show").text(parseFloat(lon).toFixed(8));

  $("#place_latitude").val(lat);
  $("#place_longitude").val(lon);
}

function place_set_of_markers() {
  var places_holder = $('#dummy_places_holder .place_holder');
  places_holder.each(function(place) {
    marker = new google.maps.Marker({
      position: new google.maps.LatLng($(this).attr("lat"), $(this).attr("long")),
      map: map,
      draggable:false
    });
  });
}