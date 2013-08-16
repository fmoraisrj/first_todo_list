class ListController < ApplicationController
	def new
	end

	def show 
		@list = List.find(params[:id])
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

	#  if @post.save
  #   redirect_to @post
  # else
  #   render 'new'
  # end
	#redirect_to  action: 'show', id: @list.id

    
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
