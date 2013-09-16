require "spec_helper"

describe Task do 

  let :new_list do
    List.new({ id: "1", name_list: "my_new_list", item1: "my_item1", item2: "my_item2", item3: "my_item3" })
  end

  let :wrong_list do
    List.new({ id: nil, name_list: "my_new_list", item1: "my_item1", item2: "my_item2", item3: "my_item3" })
  end

  it "is valid" do
    
    task = Task.new
    task.list = new_list
    task.status = true

    task.should be_valid    
  end

  it "is not valid" do
    
    task = Task.new
    # task.list = wrong_list
    task.status = true

    task.should_not be_valid    
  end
end