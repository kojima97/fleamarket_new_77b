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
  require "payjp"


  def buy
    # 購入する商品を引っ張ってきます。
    @product = Product.find(params[:product_id])
    # 商品ごとに複数枚写真を登録できるので、一応全部持ってきておきます。
    @images = @product.images.all

    # まずはログインしているか確認
    if user_signed_in?
      @user = current_user
      # クレジットカードが登録されているか確認
      if @user.credit_card.present?
        # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
        Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
        # ログインユーザーのクレジットカード情報を引っ張ってきます。
        @card = CreditCard.find_by(user_id: current_user.id)
        # (以下は以前のcredit_cardsコントローラーのshowアクションとほぼ一緒です)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
        customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
        @customer_card = customer.cards.retrieve(@card.card_id)

        ##カードのアイコン表示のための定義づけ
        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
          # (画像として登録されている)Visa.pngを返す
          @card_src = "visa.gif"
        when "JCB"
          @card_src = "jcb.gif"
        when "MasterCard"
          @card_src = "master.png"
        when "American Express"
          @card_src = "amex.gif"
        when "Diners Club"
          @card_src = "diners.gif"
        when "Discover"
          @card_src = "discover.gif"
        end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動します。
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    #ちなみに見やすさ考慮し、before_actionなどのリファクタリングなどはあえてしてません。
    @product = Product.find(params[:product_id])
    @images = @product.images.all

    # 購入テーブル登録ずみ商品は２重で購入されないようにする
    # (２重で決済されることを防ぐ)
    if @product.purchase.present?
      redirect_to product_path(@product.id), alert: "売り切れています。"
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @product.with_lock do
        if current_user.credit_card.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張ってきます。
          @card = CreditCard.find_by(user_id: current_user.id)
          # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
          Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
          #登録したカードでの、クレジットカード決済処理
          charge = Payjp::Charge.create(
          # 商品(product)の値段を引っ張ってきて決済金額(amount)に入れる
          amount: @product.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理を行います)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @product.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理(今回の実装では言及しませんが一応、、、)
      @purchase = Purchase.create(buyer_id: current_user.id, product_id: params[:product_id])
      end
    end
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
    params.require(:product).permit(:name, :explanation, :category_id, :status, :bear, :area, :brand, :days, :price, product_photos_attributes: [:photo, :_destroy, :id]).merge(exhibitor_user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
