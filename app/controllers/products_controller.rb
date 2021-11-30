class ProductsController < ApplicationController

  def new
    @title = t('products.new')
    @product = {}
  end

  def add_variant
    @variant = {name: '', price: ''}
  end

  def index
    @title = t('products.list')
    response = ApiVivetech::get_products(@current_user['token'])
    @products = response['data']
  end
    
  def show
    @title = t('products.show')
    response = ApiVivetech::get_product({id: params[:id], token: @current_user['token']})
    if !response['status']
      flash[:alert] = t('products.search')
      redirect_to controller: 'products', action: "index"
    end
    @product = response['data']
  end

  def create
    params[:product][:variants] = params[:variants]
    response = ApiVivetech::create_product({data: params[:product], token: @current_user['token']})
    if response['status']
      flash[:alert] = t('products.save.success')
      redirect_to controller: 'products', action: "index"
    else
      flash[:warning] = t('products.save.error')
      redirect_to controller: 'products', action: "new"
    end
  end


end
