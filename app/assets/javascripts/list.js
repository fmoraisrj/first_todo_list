// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function() {
  $( "#lists" ).sortable({
    stop: function(event, ui) {
      lis = $(".lists-container").find("li");
      list_ids = [];
      
      for (var i = 0; i < lis.length; i++) {
        list_ids.push($(lis[i]).data("id"));
      }
      debugger;
      console.log(list_ids);
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
        function(){ console.log(list_ids) }
      );
    }
  });

  $( "#lists" ).sortable({
    placeholder: "ui-state-highlight"
  });

  $( "#lists" ).disableSelection();
});