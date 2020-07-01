class ProductsController < ApplicationController
  
  def index  
  end

  def show
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
  end

  def edit
  end

  def update
  end

  def destroy
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


end

