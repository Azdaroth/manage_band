class Api::V1::Band::AssetListsController < ApplicationController

  before_action :authenticate_user!

  def show
    render json: asset_list
  end

  def index
    render json: asset_lists
  end

  def create
    render json: asset_lists.create(asset_list_params)
  end

  def update
    render json: asset_list.update(asset_list_params)
  end

  def destroy
    render json: asset.destroy
  end

  private

    def asset_list_params
      params.require(:asset_list).permit(:name, tag_list: [])
    end

    def scope
      @scope ||= current_user.bands.find(params[:band_id])
    end

    def asset_lists
      @assets ||= scope.asset_lists
    end

    def asset_list
      @asset ||= asset_listss.find(params[:id])
    end

end