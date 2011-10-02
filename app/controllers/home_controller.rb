class HomeController < ApplicationController
  def index
    render(layout: false) if request.headers["X-PJAX"]
  end

  def channel
    render(layout: false) if request.headers["X-PJAX"]
  end

  def update
    Update.new(path: CONFIG['Socket']).post(params[:id], params[:text])
    render js: '$("#text").val("")'
  end
end
