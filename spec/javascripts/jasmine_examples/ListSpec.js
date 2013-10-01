describe("List", function() {
  beforeEach(function(){
      // spyOn($, "post").andCallFake(function(params){
      //   params.success(true);
      // });
      spyOn(List, "postReorder");
  });

  it("post should send files to reorder", function(){
    List.postReorder();
    
    expect(List.postReorder).toHaveBeenCalled();
  });
});