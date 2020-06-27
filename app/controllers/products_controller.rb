class ProductsController < ApplicationController

  def index
  end

  def show
  end

  def new
    if user_signed_in?
      @product = Product.new
      @product.product_photos.build
    else
      redirect_to root_path, notice: 'ログインもしくはサインインしてください。'
    end
  end

  def purchase_details_confirmation
  end

end

