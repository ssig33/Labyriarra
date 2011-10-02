class HomeController < ApplicationController
  before_filter :login
  def index
    render(layout: false) if request.headers["X-PJAX"] or params[:mobile_xhr] == "true"
  end

  def channel
    @channel = Channel.where(name: params[:id]).first
    @log = @channel.log(params[:last_id])
    render(layout: false) if request.headers["X-PJAX"] or params[:mobile_xhr] == "true"
  end

  def update
    Update.new(path: CONFIG['Socket']).post(params[:id], params[:text])
    render js: '$("#text").val("")'
  end
end
