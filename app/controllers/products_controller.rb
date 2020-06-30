class ProductsController < ApplicationController

  def index
    @products = Product.all.includes(:product_photos).order(created_at: :desc)
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @comments = Comment.where(product_id: params[:id])
    @user = User.find(@product.exhibitor_user_id)
    @category = Category.find(@product.category_id)
    area = Prefecture.all.pluck(:name)
    @area = area[@product.area - 1]
  end

  def new
  end

  def purchase_details_confirmation
  end

end

