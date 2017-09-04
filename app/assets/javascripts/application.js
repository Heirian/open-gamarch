// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap-sprockets
//= require pagination
//= require loadmore
//= require bootstrap-filestyle
//= require turbolinks
//= require_tree .

$(document).ready(function(){


  $(window).load(function(){
    // Remove the # from the hash, as different browsers may or may not include it
    var hash = location.hash.replace('#','');

    if(hash == 'wall'){

       // Clear the hash in the URL
       // location.hash = '';   // delete front "//" if you want to change the address bar
        $('html, body').animate({ scrollTop: $('#my-comments').offset().top}, 1000);

       }
   });
});
