# encoding: UTF-8

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
      flash.now[:error] = 'Não foi possível salvar a task'
      render :new
    end
  end

  def update
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])

    if @task.update_attributes(params[:task])
      flash[:notice] = 'Task atualizada com sucesso'
      redirect_to list_path(@task.list_id)
    else
      flash.now[:error] =  'Não foi possível atualizar a task'
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @task = @list.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task destruída com sucesso'
  rescue Mongoid::Errors::DocumentNotFound
    flash[:error] = "Task não encontrada"
  ensure
    
    redirect_to list_path(@list.id)
  end
  
  # ********** Não deve ter Show  e nem Index

  def load_list 
    @list = List.find params[:list_id]
  end

  def reorder
    @list = List.find params[:list_id]
    @ids  = params[:ids]

    @ids.each_with_index do |id, index|
      @task = @list.tasks.find(id)
      @task.order = index
      @task.save!
    end
    render text: "Ok", status: 200
  end
end