class Api::V1::Band::AssetsController < ApplicationController

  before_action :authenticate_user!

  def link
    Asset::DeepLinker.new(scope).link(params[:assets_tree])
    render json: {}
  end

  private

    def scope
      @scope ||= current_user.bands.find(params[:band_id])
    end

    def assets
      @assets ||= scope.assets
    end

end