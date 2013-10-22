class UsersController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, if: :devise_controller? # :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    
    if @user.persisted?
      flash[:notice] = 'Welcome to mtodolist!'
      redirect_to home_index_path
    else
      flash.now[:erro] = "We can't create yout user, please correct and try again."
      render :new
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email) }
  end

  private

  def user_params
    params.require(:user).permit(:username,:email, :password)      
  end
end

