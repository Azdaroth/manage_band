class Api::V1::Band::AssetAttachmentsController < ApplicationController

  before_action :authenticate_user!

  def create
    render json: scope.asset_attachments.create(file: params[:file])
  end

  private

    def asset_params
      params.require(:asset_attachment).permit!
    end

    def scope
      @scope ||= current_user.bands.find(params[:band_id])
    end

end