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
//= require activestorage
//= require turbolinks
//= require foundation
// require_tree .

$(document).ready(function () {
  $(function(){ $(document).foundation(); });
  //setup before functions
  var typingTimer;
  var doneTypingInterval = 5000; 

  $('#search').keyup(function() {
    clearTimeout(typingTimer);

    var inputVal = $('#search').val();
    if (inputVal) {
      typingTimer = setTimeout(doneTyping(inputVal), doneTypingInterval);
    } else{
      $('#main').css({ display: 'block' });
      $("#result").css({ display: 'none' });
    }
  });

  //user is "finished typing," do something
  function doneTyping (inputVal) {
    Rails.ajax({
      url: "/books/" + inputVal,
      type: "get",
      success: function(data) {
        $("#result").css({ display: 'block' });
        $('#main').css({ display: 'none' });
        $("#result")[0].innerHTML = data.html;
      },
      error: function(err) {
        console.log('error', err);
      },
    });
  }
});
