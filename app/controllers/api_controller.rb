class ApiController < ApplicationController
  before_filter :api, :login, except: [:update_channels]
  layout :false

  def channels
    render json: {html: open("#{Rails.root}/public/channel.html").read}
  end

  def update_channels
    @channels = Channel.list
    str = render_to_string(template: 'api/channels', layout: false)
    open("#{Rails.root}/public/channel.html", "w"){|file| file.puts str}
    render text: true
  end

  def channel
    @channel = Channel.where(name: params[:id]).first
    @log = @channel.log(params[:last_id])
    render json: {html: render_to_string}
  end
end
