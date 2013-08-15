class ListController < ApplicationController
	def new
	end
	def show 
		@list = List.find(params[:id])
	end
	def create 
		 # render text: params[:list].inspect
		#List.create(name_list:"Things to do", item1:"1", item2:"2", item3:"3")
		@list = List.create(params[:list])
		redirect_to @list 
	end

end
