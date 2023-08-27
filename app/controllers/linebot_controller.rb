class LinebotController < ApplicationController
  protect_from_forgery :except => [:callback]
  def callback
    @linebot = Linebot.new(request: request)
    @linebot.respond_to_user

    head :ok
  end
end
