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
    @product = Product.find(params[:id])
    # @category = Category.find(@product.category_id)
  end

  def new
    if user_signed_in?
      @product = Product.new
      @product.product_photos.build
      @category_parent_array = Category.where(ancestry: nil)
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
      flash.now[:alert] = '入力欄を再度ご確認ください。'
      render :new
      @category_parent_array = Category.where(ancestry: nil).pluck(:name).unshift("---")
    end
  end
  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    
    def edit
      @category_parent_array = Category.where(ancestry: nil)
      @grandchildren_category = @product.category
      @children_category = @grandchildren_category.parent
      @category_children_array = Category.where(ancestry: @children_category.ancestry)
      @category_grandchildren_array = Category.where(ancestry: @grandchildren_category.ancestry)
    end
    def update
      @product.update(product_params)
      # binding.pry
      redirect_to product_path(params[:id])
      render :edit
    end
    def destroy
      @product = Product.find(params[:id])
      if current_user.id == @product.exhibitor_user_id && @product.destroy
        redirect_to root_path
      else
        @parents = Category.where(ancestry: nil)
        @comments = Comment.where(product_id: params[:id])
        render :show
      end
    end
    
    def get_category_children
      @category_children = Category.find_by(id: params[:parent_name], ancestry: nil).children
    end
    def get_category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
    end
    private
    def product_params
      params.require(:product).permit(:name, :explanation, :category_id, :status, :bear, :shipping_method, :prefecture_id, :brand, :ship_day, :price, product_photos_attributes: [:photo]).merge(exhibitor_user_id: current_user.id)
    end
    def set_product
      @product = Product.find(params[:id])
    end
    
    def ensure_currect_user
      if current_user.id != @product.exhibitor_user_id
        redirect_to root_path(params[:id])
      end
    end
  end
end
