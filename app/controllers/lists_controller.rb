# encoding: UTF-8
class ListsController < ApplicationController
	def new
		@list = List.new
	end

	def edit
		begin
			@list = List.find(params[:id])
		rescue
			flash.now[:error] = "List não encontrada"
			render :edit
		end
	end

	def destroy
		@list = List.find(params[:id])
		@list.destroy
		redirect_to lists_path
		rescue Mongoid::Errors::DocumentNotFound
			flash[:error] = "Lista não encontrada"
			redirect_to list_path
	end

	def show
		@list = List.find(params[:id])
		
		@list.tasks.asc(:order).to_a

		rescue StandardError
			redirect_to lists_path
	end

	def index
		@lists = List.all_sorted.to_a

		respond_to do |format|
			format.html 
			format.xml { render xml: @lists.to_xml }
			format.json { render json: @lists.to_json }
		end
	end

	def create 
		# render text: params[:list].inspect
		#List.create(name_list:"Things to do", item1:"1", item2:"2", item3:"3")
		@list = List.create(list_params)

		if @list.persisted?
			flash[:notice] = 'Lista criada com sucesso'
			redirect_to list_path(@list.id)
		else
			flash.now[:error] =  'Não foi possível criar a lista'
			render :new			
		end
	end

	def update
		@list = List.find(params[:id])
		updated = @list.update_attributes(params[:list].permit(:name_list, :item1, :item2, :item3 ))
		if updated
			flash[:notice] = 'Lista atualizada com sucesso'
			redirect_to @list
		else
			flash.now[:error] =  'Não foi possível atualizar a lista'
			render :edit
		end
	end

	def list_params
		params.require(:list).permit(
			:name_list,
			:item1,
			:item2,
			:item3
		)
	end

	def reorder
		@ids = params[:ids]
		
		@ids.each_with_index do |id, index|
			list = List.find(id)
			list.order = index
			list.save
		end
		
		render text: "Ok", status: 200 # :index
	end
end
