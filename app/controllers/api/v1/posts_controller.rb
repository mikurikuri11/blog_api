class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find_by(id: params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created # 201
    else
      render json: @post.errors, status: :unprocessable_entity # 422
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: @post, status: :ok # 200
    else
      render json: @post.errors, status: :unprocessable_entity # 422
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      render json: @post, status: :ok # 200
    else
      render json: @post.errors, status: :unprocessable_entity # 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
