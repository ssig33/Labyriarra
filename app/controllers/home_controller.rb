class HomeController < ApplicationController
  before_filter :login
  def index
  end

  def pc_mode
    render layout: false
  end

  def channel
    @channel = Channel.where(name: params[:id]).first
    @log = @channel.log(params[:last_id])
    if params[:update]
      render json: {html: render_to_string(partial: 'logs', locals: {log: @log})} and return
    else
      render and return
    end
  end

  def update
    Update.new(path: CONFIG['Socket']).post(params[:id], params[:text])
    render js: '$("#text").val("")'
  end

  def next
    @channel = Channel.next_unread
    redirect_to channel_path(@channel.name)
  end

  def log
    @channel = Channel.where(id: params[:id]).first
    date = Date.parse params[:date]
    @log = @channel.logs.where("created_at > ?", date.to_time.to_s(:db)).where("created_at < ?", date.tomorrow.to_time.to_s(:db)).includes(:nick).order('id desc')
  end
end
