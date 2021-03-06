class VideosController < ApplicationController
  def index
    @videos = Video.all
  end
  
  def show
    @video = Video.find(params[:id])
  end
  
  def new
    @videos = [Video.new]
  end
  
  def create
    @videos = []
    @videos_saved = []
    for video in params[:video][:details]
      @video = Video.new(video.merge(params[:video]))
      unless @video.save
        @videos << @video
      else
        @videos_saved << @video
      end
    end
    
    if !@videos_saved.empty?
      spawn do
        @video.deliver_notification!(@videos_saved)
      end
    end
    
    if @videos.empty?
      flash[:notice] = "Successfully created video."
      redirect_to list_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @video = Video.find(params[:id])
  end
  
  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      flash[:notice] = "Successfully updated video."
      redirect_to list_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    flash[:notice] = "Successfully destroyed video."
    redirect_to list_path
  end
  
  def list
      store_location
      @video = Video.new
      
      filter_on = case params[:filter_on].to_i
                   when 1 then "title"
                   when 2 then "customers.name"
                   end
                   
      sort, @direction = case params[:sort]
                        when "title"  then ["title", "title_down"]
                        when "source_media"   then ["source_media", "source_down"]
                        when "customer" then ["customers.name", "customers_down"]
                        when "created"  then ["updated_at", "created_down"]
                        when "title_reverse"  then ["title DESC", "title_up"]
                        when "source_media_reverse"   then ["source_media DESC", "sources_up"]
                        when "customer_reverse" then ["customers.name DESC", "customers_up"]
                        when "created_reverse"  then ["updated_at DESC", "videos_up"]
                        else "videos.updated_at DESC"
                        end
      
      unless params[:query].nil?
        conditions = ["#{filter_on} LIKE ?", "%#{params[:query]}%"]  
      else
        two_weeks_ago = Time.now - (60*60*336)
        conditions = { :updated_at => two_weeks_ago..Time.now }
      end

      @videos = Video.find(:all, :include => [:customer], :order => sort, :conditions => conditions, :limit => 30 )

      if request.xml_http_request?
        render :partial => "videos_list", :layout => false
      end
    end
end
