class PostsController < ApplicationController
  layout "application"


   before_filter :authenticate, :except => [:index, :show, :archive]
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all
	  @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
  @post = Post.find(params[:id])
	@posts = Post.all
	@post_months = @posts.group_by { |t| t.created_at.beginning_of_month }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @posts = Post.all
	@post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
	@post = Post.new
	

	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
	@posts = Post.all
	@post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
  end

  # POST /posts
  # POST /posts.xml
  def create
	@posts = Post.all
	@post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
	@post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  def archive
    @posts = Post.all
	@post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
    @post = Post.find(:all, :conditions => ["'%y' = ? and '%m' = ?", params[:year].to_s, params[:month].to_s])
    
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @post }
      end
  end

end
