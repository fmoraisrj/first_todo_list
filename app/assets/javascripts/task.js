$(function() {
  $("#tasks").sortable({
    stop: function(event, ui) {
      lis = $(".tasks-container").find("li");
      tasks_ids = [];
      
      for (var i = 0; i < lis.length; i++) {
        tasks_ids.push($(lis[i]).data("id"));
      }
      
      /* É preciso passar o token para impedir que alguém faça uma resquisição se passando por você */
      var csrfToken = $("meta[name='csrf-token']").attr("content");
      $.ajaxSetup({
        headers: {
          'X-CSRF-Token': csrfToken
        }
      });
      list_id = $("#tasks").data("list-id");
      
      $.post(
        '/lists/' + list_id + '/tasks/reorder',  
        {"ids": tasks_ids, "list_id": list_id},
        function(){ console.log("Task") }
      );
    }
  });

  $("#tasks").sortable({
    placeholder: "ui-state-highlight"
  });

  $("#tasks").disableSelection();
});