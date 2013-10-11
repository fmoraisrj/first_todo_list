# encoding: UTF-8


require "spec_helper"

describe TasksController do 

  before do
    @my_list = List.create!(id: 3, name_list: "list")
    @task = Task.create!(list_id: @my_list.id, body: "t0", order: 0)
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
  context "atributos validos" do
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

    context "atributos invalidos" do
      before do
        post :create, list_id: @my_list.id, task: { list_id: nil, body: "texto" }
      end

      it "deveria renderizar a pagina de editar novamente" do
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

    context "atributos validos" do
      before do
        put :update, list_id: @my_list.id, id: @task.id, task: { body: "novo texto" }
      end

      it "deveria atualizar a task indicada" do
        @task.reload.body.should == "novo texto"        
        response.status.should == 302
      end

      it "deveria redirecionar para show da list referente" do
        response.should redirect_to controller: "lists", action: "show", id: @my_list.id
      end
    end

    context "atributos invalidos" do
      before do
        put :update, list_id: @my_list.id, id: @task.id, task: { body: "" }
      end

      it "deveria mostrar a mensagem de erro" do
        flash.now[:error] =  'Não foi possível atualizar a task'
        response.status.should == 200
      end

      it "deveria redirecionar para show da list referente" do
        response.should render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "atributos válidos" do
      before do
        List.stub(:find).and_return(@my_list)
        @my_list.tasks.stub(:find).and_return(@task)
        @task.should_receive(:destroy).once
      end

      it "deveria deletar a task" do
        delete :destroy, id: @task.id, list_id: @task.list_id 
      end
      
      it "deveria lançar uma mensagem flash de sucesso" do      
        delete :destroy, id: @task.id, list_id: @task.list_id
        flash[:notice].should == 'Task destruída com sucesso'
      end

      it "deveria redirecionar para o show da lista" do
        delete :destroy, id: @task.id, list_id: @task.list_id
        response.should redirect_to controller: "lists", action: "show", id: @my_list.id 
        #response.should redirect_to controller: "lists", action: "show", id: @my_list.id 
      end
    end

    context "atributos inválidos" do
      before do
        List.stub(:find).and_return(@my_list) 
        @my_list.tasks.stub(:find).and_raise(Mongoid::Errors::DocumentNotFound.new(Task, find: 90090909))
        delete :destroy, id: 90090909 , list_id: @my_list.id
      end

      it "deveria lançar as mensagens flash de erro" do        
        flash[:error].should == 'Task não encontrada'
      end

      it "deveria redirecionar para o show da lista" do
        response.should redirect_to controller: "lists", action: "show", id: @my_list.id 
      end
    end
  end

  describe "POST #reorder" do
    before(:each) do
      @t1 = Task.create!(list_id: @my_list.id, body: "t1", order: 1)
      @t2 = Task.create!(list_id: @my_list.id, body: "t2", order: 2)
      @t3 = Task.create!(list_id: @my_list.id, body: "t3", order: 3)
    end

    it "deveria reordenar as tasks" do
      ids = [@t3.id, @t2.id, @t1.id, @task.id]
      #ids = @tasks.collect{|task| task.id }
      post :reorder, list_id: @my_list.id, ids: ids
      
      sorted_tasks = Task.asc(:order).to_a
      sorted_tasks[1].id.to_s.should == @t1.id.to_s
      response.status.should == 200
    end
  end
  # describe "POST #reorder" do
  #   before do
  #     @l1 = List.create!(name_list: "list1", order: 1 )
  #     @l2 = List.create!(name_list: "list2", order: 2 )
  #     @l3 = List.create!(name_list: "list3", order: 3 )

  #     List.unstub(:find)
  #   end

  #   it "deveria reordenar as listas" do
  #     ids = [@l3.id, @l2.id, @l1.id]
  #     post :reorder,  ids: ids 

  #     sorted_lists = List.asc(:order).to_a
  #     sorted_lists.collect{ |list| list.id }
  #     sorted_lists[0].id.to_s.should == ids[0].to_s 
  #     sorted_lists[1].id.should == ids[1] 
  #     sorted_lists[2].id.should == ids[2] 
  #     response.status.should == 200
  #   end
  # end

  # ********** Não deve ter Show  e nem Index
  
end