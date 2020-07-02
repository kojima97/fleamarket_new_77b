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
      redirect_to root_path(@product), notice: '出品完了'
    else
      @product = Product.new
      @product.product_photos.build
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @category_parent_array.unshift("---")
      flash.now[:alert] = '入力欄を再度ご確認ください。'
      render :new
    end
  end

  def purchase_details_confirmation
  end

  private

  def product_params
    params.require(:product).permit(:product_id, :name, :price, :status, :brand, :explanation, :bear, :shipping_method, :area, :ship_day, :user_id, :category_id, [product_photos_attributes: [:photo, :product_id]]).merge(exhibitor_user_id: current_user.id)
  end
end

