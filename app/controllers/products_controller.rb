class ProductsController < ApplicationController

  def index
  end

  def show
  end

  def new
    if user_signed_in?
      @product = Product.new
      @product.product_photos.build
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @category_parent_array.unshift("---")
    else
      redirect_to root_path, notice: 'ログインもしくはサインインしてください。'
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      @product = Product.new
      @product.product_photos.build
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @category_parent_array.unshift("---")

      render :new
    end
  end

  def purchase_details_confirmation
  end

  private

  def product_params
    params.require(:product).permit(:name, :explanation, :category_id, :status, :bear, :area, :brand, :ship_day, :shipping_method, :price, product_photos_attributes: [:photo, :_destroy, :id]).merge(exhibitor_user_id: current_user.id)
  end
end

