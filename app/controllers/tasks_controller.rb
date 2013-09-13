class TasksController < ApplicationController
  before_filter :load_list, only: [:new, :edit]

  def new
    @task = Task.new
  end

  def edit 
    begin
      @task = @list.tasks.find(params[:id])  
    rescue
      flash.now[:error] = "Task não encontrada"
      render :edit
    end
  end

  def create
    #render text: params[:task].inspect
    # redirect_to list_path( @task.list_id )
    # Para acessar os atributos dos params usar símbolos como abaixo
    @task = Task.create(params[:task])

    if @task.persisted?
      flash[:notice] = 'task criada com sucesso'
      redirect_to list_path(@task.list_id) #path
    else
      @list = List.find params[:list_id]
      @task = Task.new
      # render text: params[:task].inspect
      flash.now[:error] = 'Não foi psossível salvar a task'
      render :new
    end
  end


# def create 
#     # render text: params[:list].inspect
#     #List.create(name_list:"Things to do", item1:"1", item2:"2", item3:"3")
#     @list = List.create(list_params)

#     if @list.persisted?
#       flash[:notice] = 'Lista criada com sucesso'
#       redirect_to list_path(@list.id)
#     else
#       flash.now[:error] =  'Não foi possível criar a lista'
#       render :new     
#     end
#   end


  def update
  end

  def destroy
  end
  
  # ********** Não deve ter Show  e nem Index

  def load_list 
    
    @list = List.find params[:list_id]
  end

end