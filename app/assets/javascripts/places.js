var map;
var places_holder = [];
var marker = null;
var iterator;
var infowindow = null;
var marker_array = [];
var bouncing_marker = null;
var result;

$(document).ready(function() {
  if ($('#places_start_controller') != undefined) {
    get_places_from_controller();
    google.maps.event.addDomListener(window, 'load',  function() {
      /* now inside your initialise function */
      infowindow = new google.maps.InfoWindow({
      content: "holding..."
      });
      drop();
    });
  }
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

function get_places_from_controller() {
  var wall_id = $('#current_wall').text();
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

function place_marker() {
  marker = new google.maps.Marker({
    position: new google.maps.LatLng($(places_holder[iterator]).attr("lat"), $(places_holder[iterator]).attr("long")),
    map: map,
    title: $(places_holder[iterator]).attr("name"),
    animation: google.maps.Animation.DROP,
    draggable:false
  });
  iterator++;
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

function drop() {
  iterator = 0;
  marker = null;
  for (var i = 0; i < places_holder.length; i++) {
    var marker = place_marker();
    marker_array[i] = marker;
    google.maps.event.addListener(marker, 'click', function (a) {
      stop_bounce();
      toggle_bounce(this);
      infowindow.setContent("<h3>" + this.title + "</h3><br/><h4></h4>");
      infowindow.open(map, this);
    });
  }
}