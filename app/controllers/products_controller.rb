class ProductsController < ApplicationController

  before_action :set_parents, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @product = Product.new
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
    @category_parent_array.unshift("---")
  end

  def create
  end

  def purchase_details_confirmation
  end

  def set_parents
    @parents = Category.where(ancestry: nil)
  end

end

