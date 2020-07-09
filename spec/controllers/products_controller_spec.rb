require 'rails_helper'

describe ProductsController, type: :controller do
  let(:user)      { create(:user) }
  let(:product)      { create(:product) }
  let(:category)  { create(:category)}
  let(:product_photos)  { create(:product_photo)}

  describe '#index' do
    context 'ログインしている場合' do
      before do
        login user
      end

      it '@parentsに期待した値が入っていること' do
        parents = Category.all.limit(13)
        get :index
        expect(assigns(:parents)).to match(parents.sort)
      end
      it '@productsに期待した値が入っていること' do
        products = create_list(:product, 1, user_id: user.id , category_id: 30 , product_photos: [product_photos],category: create(:category))
        get :index
        expect(assigns(:products)).to match(products.sort)
      end

      

      it 'index.html.haml に遷移すること' do
        get :index
        expect(response).to render_template :index
      end
    end
    
    context 'ログインしていない場合' do

      it '@productsに期待した値が入っていること' do
        products = create_list(:product, 1, user_id: user.id , category_id: 30, product_photos: [product_photos],category: create(:category))
        get :index
        expect(assigns(:products)).to match(products.sort{ |a, b| b.created_at <=> a.created_at } )
      end

      it 'index.html.haml に遷移すること' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  
end