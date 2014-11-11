class Band::AssetsController < ApplicationController

  before_action :authenticate_user!

  def show
    render json: asset
  end

  def index
    render json: assets
  end

  def create
    render json: assets.create(asset_params)
  end

  def update
    render json: asset.update(asset_params)
  end

  def destroy
    render json: asset.destroy
  end

  private

    def asset_params
      params.require(:params).permit(:name, :file, tag_list: [], assets: [])
    end

    def scope
      @scope ||= current_user.bands.find(params[:band_id])
    end

    def assets
      @assets ||= scope.assets
    end

    def asset
      @asset ||= assets.find(params[:id])
    end

end