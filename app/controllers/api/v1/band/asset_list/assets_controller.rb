class Api::V1::Band::AssetList::AssetsController < ApplicationController

  before_action :authenticate_user!

  def show
    render json: asset
  end

  def index
    render json: assets
  end

  def create
    form = Asset::CreationForm.new(assets.build)
    form.persist(asset_params)
    render json: form.model
  end

  def update
    render json: asset.update(asset_params)
  end

  def destroy
    render json: asset.destroy
  end

  private

    def asset_params
      params.require(:asset).permit!
    end

    def scope
      @scope ||= current_user.bands.find(params[:band_id]).asset_lists.find(params[:asset_list_id])
    end

    def assets
      @assets ||= scope.assets
    end

    def asset
      @asset ||= assets.find(params[:id])
    end

end