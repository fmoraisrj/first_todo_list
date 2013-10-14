describe("Ajax", function() {
  beforeEach(function(){
      spyOn(Ajax, "postReorder");
  });

  it("post should send files to reorder", function(){
    Ajax.postReorder();
    
    expect(Ajax.postReorder).toHaveBeenCalled();
  });
});