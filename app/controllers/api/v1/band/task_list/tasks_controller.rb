class Api::V1::Band::TaskList::TasksController < ApplicationController

  before_action :authenticate_user!

  def show
    render json: task
  end

  def index
    render json: tasks
  end

  def create
    render json: tasks.create(task_params)
  end

  def update
    form = Task::UpdateForm.new(task, band: band)
    form.persist(task_params)
    render json: form.model
  end

  def destroy
    render json: task.destroy
  end

  private

    def task_params
      params.require(:task).permit!
    end

    def band
      @band ||= current_user.bands.find(params[:band_id])
    end

    def scope
      @scope ||= band.task_lists.find(params[:task_list_id])
    end

    def tasks
      @tasks ||= scope.tasks
    end

    def task
      @task ||= tasks.find(params[:id])
    end

end