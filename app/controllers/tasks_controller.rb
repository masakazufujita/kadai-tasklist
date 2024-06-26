class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :update, :edit, :destroy]

  def index
    @pagy, @tasks = pagy(current_user.tasks.order(id: :desc), items: 5)
    # @tasks = Task.all
  end

  def show
  end

  def new
    # @task = Task.new
    @task = current_user.tasks.build
  end

  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(tasks_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      # redirect_to root_url
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    
    if @task.update(tasks_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
      
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
      
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  

  # Strong Parameter
  def tasks_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end