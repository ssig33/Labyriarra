class ApiController < ApplicationController
  before_filter :api, :login, except: [:update_channels]
  layout :false

  def update_channels
    @channels = Channel.list
    str = render_to_string(template: 'api/channels', layout: false)
    open("#{Rails.root}/public/channel.html", "w"){|file| file.puts str}
    str_pc = render_to_string(template: 'api/channels_pc', layout: false)
    open("#{Rails.root}/public/channel_pc.html", "w"){|file| file.puts str_pc}
    data = Hash[*@channels.map{|x| [x.id.to_s, {u:x.unread?, name: x.name}]}.flatten]
    render json: {html: str, pc: str_pc, data: data}
  end

  def unread
    channel = Channel.find params[:id]
    render json: {u: channel.unread?, name: channel.name}
  end
end
