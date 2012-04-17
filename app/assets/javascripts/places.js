var places_holder = [];
var marker = null;
var bouncing_marker = null;
var default_lat = 32.813933;
var default_long = -117.1628362;

CHECK_ME_OUT_360.places = {
  index_action: function() {
    /* initialize google maps and place markers */
    resize_block('.sub-hero-unit', '.semi-hero-unit');
    $(window).resize(function() {
      // resize_block('.sub-hero-unit', '.semi-hero-unit');
    });
  },
  show_action: function() {CHECK_ME_OUT_360.places.index_action(); },
  map_action: function() {
    google.maps.event.addDomListener(window, 'load',  function() {
      infowindow = new google.maps.InfoWindow({
      content: "holding..."
      });
    });
    var map = init_google_map(default_lat, default_long, "map_canvas");
    var places = get_places_from_controller();
    drop(places, map);
  }
}

function init_google_map(lat,lon, map_id) {
  var latlng = new google.maps.LatLng(lat, lon);
  var myOptions = {
    zoom: 11,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById(map_id), myOptions);
  return map;
}

function cluster_marker() {
  var markerCluster = new MarkerClusterer(map, places_holder);
}

function get_places_from_controller() {
  var wall_id = $('#current_user_profile').text();
  var places;
  $.ajax({
    dataType: 'json',
    url: '/users/' + wall_id + '/places/all_places',
    type: 'get',
    data: {id: wall_id},
    async: false,
    success: function(data,textStatus) {
      places = data;
    }
  });
  return places;
}

function populate_lat_long(lat, lon) {
  // Needed to round off the lat long in the display to make it fit into box
  $("#place_lat_show").text(parseFloat(lat).toFixed(8));
  $("#place_long_show").text(parseFloat(lon).toFixed(8));

  $("#place_latitude").val(lat);
  $("#place_longitude").val(lon);
}

function place_marker(map, place) {
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng($(place).attr("lat"), $(place).attr("long")),
    map: map,
    title:  ("<h3>" + $(place).attr("name")),
    animation: google.maps.Animation.DROP,
    draggable:false
  });
  return marker;
}

function toggle_bounce(marker) {
  if (marker != undefined) {
    if (marker.getAnimation() != null) {
      marker.setAnimation(null);
    } else {
      marker.setAnimation(google.maps.Animation.BOUNCE);
    }
    bouncing_marker = marker
  }
}

function stop_bounce() {
  if (bouncing_marker != null) {
    bouncing_marker.setAnimation(null);
  }
}

function add_marker_window_listener(map, marker_to_drop) {
    stop_bounce();
    toggle_bounce(marker_to_drop);
    infowindow.setContent(marker_to_drop.title);
    infowindow.open(map, marker_to_drop);
}

function drop(places, map) {
  var iterator = 0;
  var marker_array = [];
  for (var i = 0; i < places.length; i++) {
    var marker = place_marker(map, places[iterator]);
    iterator++;
    google.maps.event.addListener(marker, 'click', function (a) {
      add_marker_window_listener(map, this);
    });
    marker_array.push(marker);
  }
  var mc = new MarkerClusterer(map, marker_array);  
}