var places_holder = [];
var marker = null;
var bouncing_marker = null;
var default_lat = 32.813933;
var default_long = -117.1628362;

function init_google_map(lat,lon) {
  var latlng = new google.maps.LatLng(lat, lon);
  var myOptions = {
    zoom: 11,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  return map;
}

function get_places_from_controller() {
  var wall_id = $('#current_user_profile').text();
  $.ajax({
    dataType: 'json',
    url: '/places/all_places',
    type: 'get',
    data: {id: wall_id},
    async: false,
    success: function(data,textStatus) {
      places_holder = data;
    }
  });
}

function populate_lat_long(lat, lon) {
  // Needed to round off the lat long in the display to make it fit into box
  $("#place_lat_show").text(parseFloat(lat).toFixed(8));
  $("#place_long_show").text(parseFloat(lon).toFixed(8));

  $("#place_latitude").val(lat);
  $("#place_longitude").val(lon);
}

function place_marker(map, i) {
  marker = new google.maps.Marker({
    position: new google.maps.LatLng($(places_holder[i]).attr("lat"), $(places_holder[i]).attr("long")),
    map: map,
    title:  ("<h3>" + $(places_holder[i]).attr("name")),
    animation: google.maps.Animation.DROP,
    draggable:false
  });
  return marker;
}
// 
// function drop_single_marker(lat,lon,title) {
//   marker = new google.maps.Marker({
//     position: new google.maps.LatLng(lat,lon),
//     map: map,
//     title:  title,
//     animation: google.maps.Animation.DROP,
//     draggable:false
//   });
//   iterator++;
//   return marker;
// }
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

function drop(map) {
  iterator = 0;
  marker = null;
  for (var i = 0; i < places_holder.length; i++) {
    var marker = place_marker(map, iterator);
    iterator++;
    google.maps.event.addListener(marker, 'click', function (a) {
      add_marker_window_listener(map, this);
    });
  }
}