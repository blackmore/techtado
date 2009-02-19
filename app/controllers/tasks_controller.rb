class TasksController < ApplicationController
  before_filter :require_user, :except => [:index, :show, :archive, :search ]
  before_filter :created_by, :only => :create
  before_filter :show_query, :only => [:update_show_page, :update_index_page]

  # GET /tasks
  # GET /tasks.xml
  def index
    @tasks = Task.outstanding.paginate :page => params[:page]
    @task = Task.new
    @recently_completed_tasks = Task.recently_completed
    @frozen_tasks = Task.frozen
    respond_to do |format|
      format.html #index.html.erb
      format.xml  { render :xml => @tasks }
      format.atom
    end
  end
  
  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
    if params[:status]
    
    else
      respond_to do |format|
        format.html { render :action => 'show', :layout => 'showpage'}
        format.xml  { render :xml => @task }
      end
    end

  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(@params)
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
  
  def archive
    @tasks = Task.finished.paginate :page => params[:page], :order => 'created_at DESC'
    respond_to do |format|
      format.html { render :layout => 'archive'}
      format.xml  { render :xml => @tasks }
    end
  end
  
  def search
    @tasks = Task.search(params[:search])
    @search_query = params[:search]
    respond_to do |format|
      format.html { render :layout => 'search'}
      format.xml  { render :xml => @tasks }
    end
  end
  
  def update_index_page
    @task = Task.find(params[:id])
    @state = params[:status]
      respond_to do |format|
        if @task.update_attributes(@state_params)
          if @task.send_email
            spawn do
              @task.deliver_status_changed!
            end
          end
          format.html {redirect_to(tasks_path)}
          format.js { render :partial => 'update_index.rjs'}
        else
          format.html {render :action => "index"}
        end
      end
  end
  
  def update_show_page
    @task = Task.find(params[:id])
      respond_to do |format|
        if @task.update_attributes(@state_params)
          if @task.send_email
            spawn do
              @task.deliver_status_changed!
            end
          end
          format.html {redirect_to(tasks_path)}
          format.js { render :partial => 'show.rjs'}
        else
          format.html {render :action => "index"}
        end
      end
  end
  
  private
  def created_by
    params[:task].merge!('user_id' => current_user.id,
                         'status' => 1,
                         'assigned_to' => nil,
                         'resubmit' => 0 )
  end
  
  def show_query
    if params[:status]
      @task = Task.find(params[:id])
      status = params[:status]
      @state_params = case status
                      when 'finished' : { :status => -1, :finished_by => current_user.id, :finished_at => Time.now }
                      when 'bounce' : { :status => 1, :assigned_to => nil, :assigned_at => nil }
                      when 'assign_to_user' : { :status => 0, :assigned_to => current_user.id,:assigned_at => Time.now }
                      when 'resubmit' : { :status => 1, :assigned_to => nil, :assigned_at => nil, :finished_by => nil, :finished_at => nil, :resubmitted_at => Time.now, :resubmitted_by => current_user.id, :resubmit => @task.resubmit + 1 }
      end
   end
  end
  
end
