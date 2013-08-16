class ListController < ApplicationController
	def new
	end

	def edit
		@list = List.find(params[:id])
	end

	def show
	begin 
		@list = List.find(params[:id])
	rescue
			redirect_to list_index_path
	end

	end

	def index
		@lists = List.all
	end

	def create 
		 # render text: params[:list].inspect
		#List.create(name_list:"Things to do", item1:"1", item2:"2", item3:"3")
		@list = List.create(list_params)

		if @list.persisted?
			redirect_to list_path(@list.id)
		else
			render :new
		end
	end
 	
	def update
	  @list = List.find(params[:id])
	 	@list.update(params[:post].permit(:name_list, :item1, :item2, :item3 ))

	  if @list.persisted?
	    redirect_to @list
	  else	
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
