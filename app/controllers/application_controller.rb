class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  ## ログイン中のユーザー情報を取得する。
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  ##　ログイン中かを判定する。
  def logged_in?
    !current_user.nil?
  end

end
