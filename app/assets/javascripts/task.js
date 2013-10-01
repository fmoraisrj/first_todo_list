
Task = {
  sortable: function(){
    var self = this;
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
        this.postReorder( '/lists/' + list_id + '/tasks/reorder',  {"ids": tasks_ids, "list_id": list_id}, function(){ console.log("Task") };
      }
      
      $("#tasks").sortable({
        placeholder: "ui-state-highlight"
      });

      $("#tasks").disableSelection();
    });
  }, 
  postReorder: function (url, data, succesessFunction){
    $.post(
        url, //'/lists/reorder',  
        data, //{ids: list_ids},
        succesessFunction  //function(){ console.log(list_ids) }
    );
  }
}