# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authenticate_user
    @current_user = User.find_by(id: session[:user_id])
    render json: { status: 'error', message: 'Anda harus login terlebih dahulu' }, status: :unauthorized unless @current_user
  end
end
