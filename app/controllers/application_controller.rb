class ApplicationController < ActionController::Base
  protect_from_forgery

  def api
    raise unless request.xhr?
  end
end
