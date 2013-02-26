class ApiController < ApplicationController
  before_filter :api, :login, except: [:update_channels]
  layout :false

  def update_channels
    @channels = Channel.list
    str = render_to_string(template: 'api/channels', layout: false)
    open("#{Rails.root}/public/channel.html", "w"){|file| file.puts str}
    render json: {html: str}
  end
end
