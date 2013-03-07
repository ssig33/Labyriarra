class ApplicationController < ActionController::Base
  protect_from_forgery
 
  def phone?
    request.env['HTTP_USER_AGENT'] =~ /iPhone/ or request.env['HTTP_USER_AGENT'] =~ /Android/ or request.env['HTTP_USER_AGENT'] =~ /Windows\ Phone/
  end


  def api
    raise unless request.xhr?
  end

  def login
    redirect_to controller: :sessions, action: :index unless session[:login]
  end
end
