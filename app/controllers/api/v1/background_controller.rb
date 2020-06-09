class Api::V1::BackgroundController < ApplicationController
  def show
   image = Background.new(params[:location])
   render json: BackgroundSerializer.new(image)
 end
end
