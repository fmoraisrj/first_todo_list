class SessionController < Devise::SessionsController
  before_filter :configure_permitted_parameters
  
  def new
    
  end

  def create
    super

    redirect_to lists
  end

  def destroy
    super
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email) }
  end
end