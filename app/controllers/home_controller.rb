class HomeController < ApplicationController
  before_filter :login
  def index
    render(layout: false) if request.headers["X-PJAX"] or params[:mobile_xhr] == "true" or params[:_pjax] == "true"
  end

  def channel
    @channel = Channel.where(name: params[:id]).first
    @log = @channel.log(params[:last_id])
    render(layout: false) if request.headers["X-PJAX"] or params[:mobile_xhr] == "true" or params[:_pjax] == "true"
  end

  def update
    Update.new(path: CONFIG['Socket']).post(params[:id], params[:text])
    render js: '$("#text").val("")'
  end

  def next
    @channel = Channel.next_unread
    @log = @channel.log(params[:last_id])
    if request.headers["X-PJAX"] or params[:mobile_xhr] == "true" or params[:_pjax] == "true"
      render template: "home/channel", layout: false
    else
      render template: "home/channel"
    end
  end
end
