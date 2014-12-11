class Api::V1::Band::TaskListsController < ApplicationController

	before_action :authenticate_user!

  def show
    render json: task_list
  end

  def index
    render json: task_lists
  end

  def create
    render json: task_lists.create(task_list_params)
  end

  def update
    render json: task_list.update(task_list_params)
  end

  def destroy
    render json: asset.destroy
  end

  private

    def task_list_params
      params.require(:task_list).permit(:name)
    end

    def scope
      @scope ||= current_user.bands.find(params[:band_id])
    end

    def task_lists
      @task_lists ||= scope.task_lists
    end

    def task_list
      @task_list ||= task_lists.find(params[:id])
    end

end