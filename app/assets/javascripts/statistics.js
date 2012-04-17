CHECK_ME_OUT_360.statistics = {
  index_action: function() {
    $('#show_me_graphs').click(function() {
      $('#graphs').show();
    });
  },
  map_action: function() {
    google.maps.event.addDomListener(window, 'load',  function() {
      infowindow = new google.maps.InfoWindow({
      content: "holding..."
      });
    });
    var map = init_google_map(default_lat, default_long, "map_canvas");
    var places = all_places();
    drop(places, map);
  },
  graph_action: function() {CHECK_ME_OUT_360.statistics.index_action(); }
}

function all_places() {
  var places;
  $.ajax({
    dataType: 'json',
    url: '/statistics/all_places',
    type: 'get',
    async: false,
    success: function(data,textStatus) {
      places = data;
    }
  });
  return places;
}
