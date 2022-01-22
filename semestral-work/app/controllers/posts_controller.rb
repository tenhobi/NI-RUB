class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show tag ]
  before_action :correct_user, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.sort_by(&:created_at).reverse
  end

  # GET /posts/tag/:tag
  def tag
    @tag = params[:tag]&.strip
    unless @tag.empty?
      @posts = Post.joins(:tags).where(tags: {name: @tag})
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        update_tags(@post, post_params[:description])
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        update_tags(@post, post_params[:description])
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated."}
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    params[:id] = nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:description, :image, :user_id)
    end

    # On new or edit parse description to update currently used tags
    def update_tags(post, text)
      post.tags.delete_all
      text.scan(/#[a-zA-Z][a-zA-Z0-9]*/) do |match|
        post.tags << Tag.new(name: match[1..-1])
      end
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to posts_path, alert: "You are not Authorized to access this resource" if @post.nil?
    end
end
