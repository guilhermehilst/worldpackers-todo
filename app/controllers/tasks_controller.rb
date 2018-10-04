class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    end
  end

  def complete
    @task.update_attribute(:completed, true)
    TrackingEventWorker.perform_async(@task.id) 

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task #{@task.title} was successfully completed." }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :completed)
    end
end
