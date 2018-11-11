class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      # @tasks = Task.all
      #@tasks = Task.rank(:row_order)
      #@tasks = current_user.tasks.order('created_at DESC')
      
      @tasks = current_user.tasks.rank(:row_order)
      counts(current_user)
    end
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    #@task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "正常に追加されました"
      redirect_to tasks_url
    elsif
      flash.now[:danger] = new_task.content + "が追加されませんでした。"
      render :new
    end
  end
  
  def new
    @task = current_user.tasks.new
    #@task = Task.new
  end
  
  def edit
    
  end
  
  def show
    
  end
  
  def update
    
    # render plain:@task.content.to_s
    # render plain:params[:task][:content]
    # render plain:task_params[:content]
    
    if @task.update(status:task_params[:status],content:task_params[:content])
      flash[:success] = '正常に更新しました'
      redirect_to tasks_url
    elsif
      flash[:danger] = "更新に失敗しました"
      render :edit
    end
      
  end
  
  def destroy
    
    @task.destroy
    
    flash[:success] = '正常に削除されました'
    redirect_back(fallback_location: root_path)
    #redirect_to tasks_url
  end
  
  # this action will be called via ajax
  def sort
    task = Task.find(params[:task_id])
    task.update(task_params)
    render nothing: true
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  #Strong Parameter
  def task_params
    # params.require(:task).permit(:content)
    params.require(:task).permit(:content, :row_order_position, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
