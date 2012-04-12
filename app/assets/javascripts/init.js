CHECK_ME_OUT_360 = {
  common: {
    init: function() {      
      // application-wide code
      $('#login_logout_top_menu').click(function(obj) {
        $('#yield_for_main_content').fadeOut();
        $('#application_loader_circle').fadeIn();
      });
      var pathname = window.location.pathname;
      if (pathname.indexOf('about') >= 0) {
        $('#nav_options').children('li').removeClass("active");
        $('#about_tab').addClass("active");
      }
      else if (pathname.indexOf('contact') >= 0) {
        $('#nav_options').children('li').removeClass("active");
        $('#contact_tab').addClass("active");
      }
      else if (pathname.indexOf('help') >= 0) {
        $('#nav_options').children('li').removeClass("active");
        $('#help_tab').addClass("active"); 
      }
      
      
      
      
      
      
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
