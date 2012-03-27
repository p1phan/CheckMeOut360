CHECK_ME_OUT_360 = {
  common: {
    init: function() {
      // application-wide code
      $('.login_logout_top_menu').click(function(obj) {
        $('#yield_for_main_content').hide();
        $('#loader_circle').show();
      });
    }
  }
};

UTIL = {
  exec: function( controller, action ) {
    var ns = CHECK_ME_OUT_360, action = ( action === undefined ) ? "init" : action;

    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
      ns[controller][action]();
    }
  },

  init: function() {
    var body = document.body,
        controller = body.getAttribute( "data-controller" ),
        action = body.getAttribute( "data-action" );
    
    UTIL.exec( "common" );
    UTIL.exec( controller );
    UTIL.exec( controller, action );
  }
};

$( document ).ready( UTIL.init );
