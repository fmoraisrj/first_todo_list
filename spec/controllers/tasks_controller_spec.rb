require "spec_helper"

describe TasksController do 

  before do
    @my_list = List.create!(name_list: "list")
    @task = Task.create!(list_id: @my_list.id, body: "texto")
  end

  describe "GET #new" do
    it "deveria retornar uma task nova" do
       get :new, list_id: @my_list.id
       assigns(:task).should be_new_record
       assigns(:task).should be_an_instance_of Task 
    end

    it "deveria renderizar a tela de criar uma task nova" do
      get :new, list_id: @my_list.id
      response.should render_template("new")
    end
  end

  describe "POST #create" do
    context "atributos válidos" do
      before do
        post :create, list_id: @my_list.id, task: { list_id: @my_list.id, body: "texto" }

      end
      it "deveria salvar uma task nova" do
        assigns(:task).body.should == "texto"
      end
      it "deveria redenrizar o show da lista que a task pertence" do
        redirect_to list_path(@task.list_id) #path
        response.should redirect_to "/lists/#{@my_list.id}"
      end
    end

    context "atributos inválidos" do
      before do
        post :create, list_id: @my_list.id, task: { list_id: nil, body: "texto" }
      end

      it "deveria renderizar a página de editar novamente" do
        response.status.should == 200
        response.should render_template :new
      end

      it "deveria mostrar a flash error" do
        flash[:error].should == "Não foi possível salvar a task"
      end
    end
  end

  describe "GET #edit" do
    it "deveria editar uma tarefa" do
      get :edit, list_id: @my_list.id, id: @task
      assigns(:task).should be_an_instance_of Task
    end

    it "deveria renderizar a tela de show da task" do
      get :edit, list_id: @my_list.id, id: @task
      response.should render_template "edit"
    end
  end

  describe "PUT #update" do
    before  do
      @task.save.should be_true
      @task.body.should == "texto"
      Task.should have(1).item
    end

    context "atributos válidos" do
      before do
        put :update, list_id: @my_list.id, id: @task.id, task: { body: "novo texto" }
      end

      it "deveria atualizar a task indicada" do
        @task.reload.body.should == "novo texto"        
      end
    end
  end


  # ********** Não deve ter Show  e nem Index

  
end