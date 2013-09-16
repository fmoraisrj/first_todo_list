require "spec_helper"

describe Task do 

  let :new_list do
    List.new({ id: "1", name_list: "my_new_list", item1: "my_item1", item2: "my_item2", item3: "my_item3" })
  end

  it "is valid" do
    list = List.stub(:find).and_return(new_list) 
    task = Task.new
    task.list_id = list.id
    task.status = true

    task.should be_valid    
  end

  xit "is not valid" do
    
  end
end