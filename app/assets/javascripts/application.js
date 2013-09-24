// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .




$(function() {
  $( ".sort" ).sortable({
    stop: function(event, ui) {
      lis = $(".lists-container").find("li");
      list_ids = [];
      
      for (var i = 0; i < lis.length; i++) {
        list_ids.push($(lis[i]).data("id"));
      }
      
      /* É preciso passar o token para impedir que alguém faça uma resquisição se passando por você */
      var csrfToken = $("meta[name='csrf-token']").attr("content");
      $.ajaxSetup({
        headers: {
          'X-CSRF-Token': csrfToken
        }
      });

      $.post(
        '/lists/reorder',  
        {ids: list_ids},
        function(){ alert("post") }
      );
    }
  });

  $( ".sort" ).sortable({
    placeholder: "ui-state-highlight"
  });

  $( ".sort" ).disableSelection();
});