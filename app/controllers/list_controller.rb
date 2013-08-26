class ListController < ApplicationController
	def new
			@list = List.new
	end

	def edit
		@list = List.find(params[:id])
	end

	def destroy
		@list = List.find(params[:id])
		@list.destroy

		redirect_to list_index_path
	end

	def show
		begin 
			@list = List.find(params[:id])
		rescue
				redirect_to list_index_path
		end
	end

	def index
		@lists = List.all.to_a

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
	 	@list.update_attributes!(params[:list].permit(:name_list, :item1, :item2, :item3 ))

	  # 	person.update_attributes!(
		#   first_name: "Jean",
		#   last_name: "Zorg"
		# )

	  if @list.persisted?
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

end
