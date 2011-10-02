class ApplicationController < ActionController::Base
  protect_from_forgery

  def api
    raise unless request.xhr?
  end

  def login
    redirect_to controller: :sessions, action: :index unless session[:login]
  end
end
