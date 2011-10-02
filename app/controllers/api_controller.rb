class ApiController < ApplicationController
  before_filter :api, :login
  layout :false

  def channels
    @channels = Channel.list
    render json: {html: render_to_string}
  end

  def channel
    @channel = Channel.where(name: params[:id]).first
    @log = @channel.log(params[:last_id])
    render json: {html: render_to_string}
  end
end
