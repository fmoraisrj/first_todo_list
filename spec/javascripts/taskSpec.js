describe("Task", function(){
  beforeEach(function(){
    spyOn(Ajax, "postReorder");
  });  

  it("should call postReorder ", function(){
    Task.sortable();//Tenho que arrumar um jeito de chamar o método chamado pelo usuário #stop

    expect(Ajax.postReorder).toHaveBeenCalled();
  });
});
