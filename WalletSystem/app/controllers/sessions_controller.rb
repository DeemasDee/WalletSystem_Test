# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { status: 'berhasil_masuk', user: user }
    else
      render json: { status: 'gagal', message: 'Kredensial tidak valid' }, status: :unauthorized
    end
  end
end
