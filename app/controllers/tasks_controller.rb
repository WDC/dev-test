class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
 
  def index
    @task = Task.new

    if params.key?('q')
      @archived = nil
      @query = params['q']

      @tasks = Task.where(
        Task.arel_table[:title].matches(@query).or(
          Task.arel_table[:description].matches(@query)
        )
      )
    else
      @tasks = Task.all

      @archived = params.key?('archived') && params['archived'] == 'true'
      @tasks.where!(archived: true) if @archived
      @tasks = @tasks.unarchived unless @archived
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /tasks/1/marker
  def marker
	change = Task.find_by(id: params[:id])
	change.complete = params[:complete]
	change.save
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_KEY_SECRET']
  config.access_token = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end
    # Uncomment following line to activate Twitter psoting. This is on my live Twitter account, because I was unable to post to a new one wwithout an additional phone number.
    if params[:complete] == 't'
    twitter.update(change.title + ' has been completetd.')
    end
	render :json => {:status => "Complete"}
  end

  # Archives task with ID parameter
  # POST /tasks/1/archiver
  def archiver
	change = Task.find_by(id: params[:id])
	change.archived = 't'
	change.save
	render :json => {:status => "Complete"}
  end

  # Unarchives task with ID parameter
  # POST /tasks/1/unarchiver
  def unarchiver
	change = Task.find_by(id: params[:id])
	change.archived = 'f'
	change.save
	render :json => {:status => "Complete"}
  end


  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :complete, :archived, :tags)
    end
end
