require "spec_helper"

describe TasksController do 

  describe "GET #new" do
    it "deveria retornar uma task nova" do
       get :new
       assigns(:task).should be_an_instance_of Task 
    end

    xit "deveria adicionar uma task a lista" do
      
    end
  end

  describe "GET #edit" do
    xit "deveria editar uma tarefa" do
      
    end

    xit "não pode adicionar uma task nova" do
      
    end
  end

  describe "GET #index" do

  end
end