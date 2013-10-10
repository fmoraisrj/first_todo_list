// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

List = {
  sortable: function(){
    var self = this;

    $( "#lists" ).sortable({
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
        var url = '/lists/reorder';
        var data = {ids: list_ids};
        var succesessFunction = function(){};

       // Ajax.postReorder(url, data, succesessFunction);
      }
    });

    $( "#lists" ).sortable({
      placeholder: "ui-state-highlight"
    });

    $( "#lists" ).disableSelection();
  },
  postReorder: function (url, data, succesessFunction){
    $.post(
        url, //'/lists/reorder',  
        data, //{ids: list_ids},
        succesessFunction  //function(){ console.log(list_ids) }
    );
  }
};



