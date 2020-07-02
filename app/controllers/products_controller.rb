class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all.includes(:product_photos).order(created_at: :desc)
    @parents = Category.where(ancestry: nil)

  end

  def show
    @parents = Category.where(ancestry: nil)
    @comments = Comment.where(product_id: params[:id])
    @user = User.find(@product.exhibitor_user_id)
    @category = Category.find(@product.category_id)
  end

  def new
    @product = Product.new
    @product.product_photos.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      @product = Product.new
      @product.product_photos.build

      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if current_user.id == @product.exhibitor_user_id && @product.destroy
      redirect_to root_path
    else
      @parents = Category.where(ancestry: nil)  
      @comments = Comment.where(product_id: params[:id])
  
      render :show
    end
  end

  def purchase_details_confirmation
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def product_params
    params.require(:product).permit(:name, :explanation, :category_id, :status, :bear, :area, :brand, :days, :price, product_photos_attributes: [:photo, :_destroy, :id]).merge(exhibitor_user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
