class SessionsController < ApplicationController
  def index
  end
  
  def create
    if params[:password] == CONFIG["Password"]
      session[:login] = true
      redirect_to controller: :home, action: :index
    else
      redirect_to action: :index   
    end
  end
end
