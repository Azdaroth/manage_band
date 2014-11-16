class BandsController < ApplicationController

  before_filter :authenticate_user!

  def index
    render json: scope
  end

  private

    def scope
      @scope ||= current_user.bands
    end

end