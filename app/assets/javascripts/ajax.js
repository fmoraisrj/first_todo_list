Ajax = {
  postReorder: function (url, data, succesessFunction){
    $.post(
        url, //'/lists/reorder',  
        data, //{ids: list_ids},
        succesessFunction  //function(){ console.log(list_ids) }
    );
  }
}