class HomeController < ApplicationController
  def index
    @users         = User.all
    @users_counter  = @users.count
    @lists_counter = List.all.count 
    @tasks_counter = Task.all.count
  end
end
