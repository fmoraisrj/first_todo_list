describe("List", function(){
  beforeEach(function(){
    spyOn(Ajax, "postReorder");
  });  

  it("post should be called", function(){
    //Falta importar um html para simular essa situação.
    $("ul[id=lists]>li:first-child").simulateDragSortable({ move: 1 });

    expect(Ajax.postReorder).toHaveBeenCalled();
  });
});
