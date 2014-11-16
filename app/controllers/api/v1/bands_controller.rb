class Api::V1::BandsController < ApplicationController

  before_filter :authenticate_user!

  def index
    render json: scope
  end

  def show
    render json: scope.find(params[:id])
  end

  private

    def scope
      @scope ||= current_user.bands
    end

end